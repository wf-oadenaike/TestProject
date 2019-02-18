
CREATE PROCEDURE [Investment].[usp_NTReconCalculations] AS
-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[usp_NTReconCalculations]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			10/01/2017
--					D Bacchus
--					04/05/2017
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		perform NT Reconciliation calculations
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

	SET NOCOUNT ON;

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Investment].[usp_NTReconCalculations]';

/*
	DECLARE @SpecialCumShares TABLE ([EDM_SEC_ID] [int],
									 [EX_DATE] [DATE],
									 [Quantity] [decimal](15,2));

-- work out special cum shares for Security/EX_DATE from BPS Hist and [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT]
-- sum up quantity between Ex date and next Ex date
INSERT INTO @SpecialCumShares
([EDM_SEC_ID], [EX_DATE], [Quantity])
SELECT dh.[EDM_SEC_ID],dh.[EX_DATE],
       SUM(ISNULL(toa.F_QUANTITY, 0)) as Quantity
FROM (SELECT DISTINCT [EDM_SEC_ID],[EX_DATE],ISNULL(DATEADD(d,-1,LEAD(EX_DATE) OVER (PARTITION BY [EDM_SEC_ID] ORDER BY [EX_DATE])),GetDate()) as NextExDate
      FROM [dbo].[T_BPS_DVD_HIST]) dh
INNER JOIN [dbo].[T_MASTER_SEC] ms
ON ms.EDM_SEC_ID = dh.EDM_SEC_ID
INNER JOIN [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] toa
ON toa.C_IDENTIFIER = ms.ISIN
AND toa.D_DATE BETWEEN dh.EX_DATE AND dh.NextExDate
WHERE toa.C_EVENT IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION') -- Allocated
AND toa.C_REASONCODE = 1 -- 1 = Special Cum Dividend
AND toa.I_TKTNUM NOT IN (SELECT I_TKTNUM FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] x WHERE x.I_TSORDNUM = toa.I_TSORDNUM AND x.C_EVENT IN ('ALLOCATION CANCELLED')) -- Not cancelled
GROUP BY dh.[EDM_SEC_ID],dh.[EX_DATE];
*/

-- store extra cash and FA columns on Override table
-- may not have sec_id/ex-date or override - in which case create new record

-- NT Cash

WITH NT_CASH_REPORT_CTE AS
 (SELECT [SEDOL],[ISIN],[EX_DATE], MAX(FROM_DATE) as MaxDate
        FROM [dbo].[T_NT_CASH_REPORT]
		WHERE [I_TRAN_PROC_3] = 'INCOM'
	    AND [ACCOUNT_NUMBER] IN ('WI0001','WI0018')
		AND [ISIN] IS NOT NULL
		GROUP BY [SEDOL],[ISIN],[EX_DATE]
  UNION
  SELECT [SEDOL],[ISIN],[EX_DATE], MAX(FROM_DATE) as MaxDate
        FROM [dbo].[T_NT_CASH_REPORT]
		WHERE [I_TRAN_PROC_3] = 'INCOM'
	    AND [ACCOUNT_NUMBER] IN ('WI0001','WI0018')
		AND [ISIN] IS NULL
		AND [SEDOL] NOT IN (SELECT [SEDOL]
	                        FROM [dbo].[T_NT_CASH_REPORT]
							WHERE [ISIN] IS NOT NULL)
		GROUP BY [SEDOL],[ISIN],[EX_DATE]
       ),
-- for calculating EX-Dates in past for BPS_DVD_HIST

-- use FX rate and Positions at EX_DATE? Not latest values (only for future dates)
 
	BPS_HIST_CTE AS
 (
  SELECT bdh.[EDM_SEC_ID]
      ,bdh.[EX_DATE] as EX_DATE
      ,bdh.[DVD_VALUE]
	  ,ISNULL(ms.[WITHHOLDING_TAX],0) as WITHHOLDING_TAX
	  ,ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) as DIVIDEND_CCY
--	  ,ISNULL(scs.Quantity,0) as OverrideSpecialCumShares
--	  ,CASE WHEN scs.Quantity IS NULL THEN 0
--			WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN scs.Quantity*bdh.[DVD_VALUE]/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
--	        ELSE scs.Quantity*bdh.[DVD_VALUE]/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
--	   END as SpecialCumTrades
  FROM (SELECT [EDM_SEC_ID],[EX_DATE],SUM([DVD_VALUE]) AS [DVD_VALUE]
        FROM [dbo].[T_BPS_DVD_HIST] dh
--		WHERE NOT EXISTS (SELECT 1 
--		                  FROM [Investment].[DvdForecastCalcOverride] fco
--						  WHERE fco.EDM_SEC_ID = dh.EDM_SEC_ID
--						  AND (fco.EX_DATE = dh.EX_DATE OR fco.[OverrideExDate] = dh.[EX_DATE]))
        WHERE EXISTS (SELECT 1 
                      FROM [dbo].[T_MASTER_POS] mp
                      WHERE dh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
                      AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF'))
  GROUP BY [EDM_SEC_ID],[EX_DATE]) bdh
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]


--  LEFT OUTER JOIN @SpecialCumShares scs
--  ON scs.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
--  AND scs.[EX_DATE] = bdh.[EX_DATE]
  )
	   
MERGE INTO [Investment].[DvdForecastCalcOverride] Tar
	USING (
	   
SELECT ms.[EDM_SEC_ID]
	  ,ms.[SECURITY_NAME]
	  ,ncr_cte.[EX_DATE]
	  ,CASE WHEN fco.[EDM_SEC_ID] IS NULL THEN bdh.[DVD_VALUE] 
			ELSE fco.[DVD_VALUE]
	   END as [DVD_VALUE]
	  ,CASE WHEN fco.[EDM_SEC_ID] IS NULL THEN bdh.[WITHHOLDING_TAX]
			ELSE fco.[WITHHOLDING_TAX]
	   END as [WITHHOLDING_TAX]	 
	  ,CASE WHEN fco.[EDM_SEC_ID] IS NULL THEN bdh.[DIVIDEND_CCY]
			ELSE fco.[DIVIDEND_CCY]
	   END as [DIVIDEND_CCY]	
	  --,CASE WHEN fco.[EDM_SEC_ID] IS NULL THEN bdh.OverrideSpecialCumShares
	  --		ELSE fco.OverrideSpecialCumShares
	  -- END as OverrideSpecialCumShares	 	   
	  --,CASE WHEN fco.[EDM_SEC_ID] IS NULL THEN bdh.SpecialCumTrades
	  --		ELSE fco.SpecialCumTrades
	  -- END as SpecialCumTrades
	  ,0 as SpecialCumTrades 
	  ,Investment.ufn_GetQtr(ncr_cte.[EX_DATE]) as Qtr
  FROM NT_CASH_REPORT_CTE ncr_cte  
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ( ncr_cte.[SEDOL] = ms.[SEDOL] OR ncr_cte.[ISIN] = ms.[ISIN] )
  LEFT OUTER JOIN [Investment].[DvdForecastCalcOverride] fco
  ON fco.[EDM_SEC_ID] = ms.[EDM_SEC_ID]
  AND ( (fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] = ncr_cte.[EX_DATE])
  OR (fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] = ncr_cte.[EX_DATE]) )
  
  INNER JOIN BPS_HIST_CTE bdh
  ON bdh.[EX_DATE] = ncr_cte.[EX_DATE]
  AND bdh.[EDM_SEC_ID] = ms.[EDM_SEC_ID]
 
  ) as Src
 ON Tar.[EDM_SEC_ID] = Src.[EDM_SEC_ID]
 AND ( Tar.[EX_DATE] = Src.[EX_DATE]
   OR Tar.[OverrideExDate] = Src.[EX_DATE] )
	 WHEN NOT MATCHED THEN
		INSERT ([EDM_SEC_ID],
		        [SECURITY_NAME],
				[EX_DATE],
				[DVD_VALUE],
				[WITHHOLDING_TAX],
				[DIVIDEND_CCY],
				[IsActive],
				[JoinGUID],
				[Qtr],
			--	[OverrideExDate],
			--	[OverrideDvdValue],
				[OverrideSpecialCumShares])
		VALUES (Src.EDM_SEC_ID,
		        Src.SECURITY_NAME,
				Src.EX_DATE,
				Src.DVD_VALUE,
				Src.WITHHOLDING_TAX,
				Src.DIVIDEND_CCY,
				1,
				NewId(),
				Src.Qtr,
			--	Src.EX_DATE,
			--	Src.DVD_VALUE,
			--  Src.OverrideSpecialCumShares)
				0);
				  				  				  
  -- now Merge into DvdFundSecurityCalc
  -- get FUND from T_NT_CASH_REPORT as well
  
  WITH NT_CASH_REPORT_CTE AS
 (SELECT [ACCOUNT_NUMBER],[SEDOL],[ISIN],[EX_DATE], MAX(FROM_DATE) as MaxDate
        FROM [dbo].[T_NT_CASH_REPORT]
		WHERE [I_TRAN_PROC_3] = 'INCOM'
	    AND [ACCOUNT_NUMBER] IN ('WI0001','WI0018')
		AND [ISIN] IS NOT NULL
		GROUP BY [ACCOUNT_NUMBER],[SEDOL],[ISIN],[EX_DATE]
  UNION
  SELECT [ACCOUNT_NUMBER],[SEDOL],[ISIN],[EX_DATE], MAX(FROM_DATE) as MaxDate
        FROM [dbo].[T_NT_CASH_REPORT]
		WHERE [I_TRAN_PROC_3] = 'INCOM'
	    AND [ACCOUNT_NUMBER] IN ('WI0001','WI0018')
		AND [ISIN] IS NULL
		AND [SEDOL] NOT IN (SELECT [SEDOL]
	                        FROM [dbo].[T_NT_CASH_REPORT]
							WHERE [ISIN] IS NOT NULL)
		GROUP BY [ACCOUNT_NUMBER],[SEDOL],[ISIN],[EX_DATE]
       )
	   
MERGE INTO [Investment].[DvdFundSecurityCalc] Tar
	USING ( SELECT fsc.[FUND_SHORT_NAME]
	             , fsc.[DvdForecastCalcOverrideId]
				 , MAX(fsc.[POSITION]) as POSITION
				 , MAX(fsc.[GrossDvdValue]) as GrossDvdValue
				 , MAX(fsc.[NetDvdValue]) as NetDvdValue
				 , MAX(fsc.[SpecialCumTrades]) as SpecialCumTrades
				 , MAX(fsc.[NetDvdValue] + fsc.[SpecialCumTrades]) as TotalNetDvd
				 , SUM(fsc.[NET_AMOUNT_BASE]) as NTCustodyNetAmountBase
				 , SUM(ISNULL(ABS(fsc.[NetDvdValue] + fsc.SpecialCumTrades - fsc.[NET_AMOUNT_BASE]),fsc.[NET_AMOUNT_BASE])) as NTCustodyReconDiff
FROM	
(SELECT mp.[FUND_SHORT_NAME] 
	  ,fco.[DvdForecastCalcOverrideId] 
	  ,mp.[QUANTITY] as [POSITION]
	  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100
	        ELSE mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]
	   END as GrossDvdValue
	  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	        ELSE mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	   END as NetDvdValue
	  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	        ELSE ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	   END as SpecialCumTrades   
      ,ncr.[NET_AMOUNT_BASE]
  FROM [dbo].[T_NT_CASH_REPORT] ncr
  INNER JOIN NT_CASH_REPORT_CTE ncr_cte
  ON ( ncr.[SEDOL] = ncr_cte.[SEDOL] OR ncr.[ISIN] = ncr_cte.[ISIN] )
  AND ncr.[EX_DATE] = ncr_cte.[EX_DATE]
  AND ncr.[ACCOUNT_NUMBER] = ncr_cte.[ACCOUNT_NUMBER]
  AND ncr.[ACCOUNT_NUMBER] IN ('WI0001','WI0018')
  
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ( ncr.[SEDOL] = ms.[SEDOL] OR ncr.[ISIN] = ms.[ISIN] )
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  
  INNER JOIN [Investment].[DvdForecastCalcOverride] fco
  ON fco.[EDM_SEC_ID] = ms.[EDM_SEC_ID]
  AND (fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] = ncr.[EX_DATE])
  --OR (fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] = ncr.[EX_DATE])
  
  INNER JOIN [dbo].[T_MASTER_POS] mp
  ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
  AND ( (mp.[FUND_SHORT_NAME] = 'WIMEIF' AND ncr.ACCOUNT_NUMBER = 'WI0001')
   OR (mp.[FUND_SHORT_NAME] = 'WIMIFF' AND ncr.ACCOUNT_NUMBER = 'WI0018') )
  AND fco.[EX_DATE] = mp.[POSITION_DATE]

  LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
  ON fx.DATE = fco.[EX_DATE]
  AND fx.[FROM_ISO_CURRENCY_CODE]='GBP'
  AND (mse.DIVIDEND_CCY IS NOT NULL AND fx.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
  OR mse.DIVIDEND_CCY IS NULL AND fx.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
  
  ) as fsc group by fsc.[FUND_SHORT_NAME], fsc.[DvdForecastCalcOverrideId]

  ) as Src
  ON Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
  AND Tar.[DvdForecastCalcOverrideId] = Src.[DvdForecastCalcOverrideId]
	 WHEN NOT MATCHED THEN
		INSERT ([FUND_SHORT_NAME],
				[DvdForecastCalcOverrideId],
				[POSITION],
				[GrossDvdValue],
				[NetDvdValue],
				[SpecialCumTrades],
				[TotalNetDvd],
                [NTCustodyNetAmountBase],
                [NTCustodyReconDiff],
				[IsActive],
				[JoinGUID])
		VALUES (Src.FUND_SHORT_NAME,
		        Src.DvdForecastCalcOverrideId,
				Src.POSITION,
				Src.GrossDvdValue,
				Src.NetDvdValue,
				Src.SpecialCumTrades,
				Src.TotalNetDvd,
				Src.NTCustodyNetAmountBase,
				Src.NTCustodyReconDiff,
				1,
				NewId())	
	 WHEN MATCHED THEN
		UPDATE SET NTCustodyNetAmountBase = Src.NTCustodyNetAmountBase
				  ,NTCustodyReconDiff = Src.NTCustodyReconDiff
				  ,IsActive = 1
				  ,DvdFundSecurityCalcLastModifiedDatetime=GetDate();

    
  -- NT FA
  -- There is a possibility, stock/ex_date not in BPS so create new entry on Override table
  
MERGE INTO [Investment].[DvdForecastCalcOverride] Tar
	USING (
	
  SELECT ms.[EDM_SEC_ID]
      ,ms.[SECURITY_NAME]
	  ,dirr.[DATE] as [EX_DATE]
	  ,Investment.ufn_GetQtr(dirr.[DATE]) as Qtr
  FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr
  INNER JOIN [dbo].[T_MASTER_SEC] ms  
  ON (dirr.[CUSIP] = ms.[CUSIP]
      OR dirr.[CUSIP] = ms.[TICKER])
  LEFT OUTER JOIN [Investment].[DvdForecastCalcOverride] fco
  ON fco.[EDM_SEC_ID] = ms.[EDM_SEC_ID]
  AND ( (fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] = dirr.[DATE])
  OR (fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] = dirr.[DATE]) )
  WHERE dirr.[CUSIP] IS NOT NULL
  AND dirr.TOTAL_EQUITY != 0 
  AND dirr.[DATE] = (SELECT MAX(DATE) FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT])
-- AND dirr.[DATE] = (SELECT MAX(DATE) FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr1 WHERE dirr1.[FUND_SHORT_NAME] = dirr.[FUND_SHORT_NAME]) -- only interested in latest date for the fund
  AND dirr.ACCOUNT_NUMBER IN ('1709427','1744293') -- substitute for correct account number for WIMIFF
    
 ) as Src
 ON Tar.[EDM_SEC_ID] = Src.[EDM_SEC_ID]
 AND (Tar.[EX_DATE] = Src.[EX_DATE]
   OR Tar.[OverrideExDate] = Src.[EX_DATE] )
	 WHEN NOT MATCHED THEN
		INSERT ([EDM_SEC_ID],
				[SECURITY_NAME],
				[EX_DATE],
				[IsActive],
				[JoinGUID],
				[Qtr],
				[OverrideSpecialCumShares])
		VALUES (Src.EDM_SEC_ID,
				Src.SECURITY_NAME,
				Src.EX_DATE,
				1,
				NewId(),
				Src.Qtr,
				0);

-- now Merge into DvdFundSecurityCalc
  
MERGE INTO [Investment].[DvdFundSecurityCalc] Tar
	USING (
	
  SELECT fsc.[DvdForecastCalcOverrideId]
        ,fsc.[FUND_SHORT_NAME]
	    ,fsc.[POSITION]
	    ,fsc.GrossDvdValue
	    ,fsc.NetDvdValue
	    ,fsc.SpecialCumTrades		 
	    ,fsc.[TOTAL_EQUITY] as NTFAValueBase
	    ,CASE WHEN fsc.NetDvdValue IS NOT NULL THEN 
		  	  ABS(fsc.NetDvdValue + fsc.SpecialCumTrades - fsc.[TOTAL_EQUITY])
			  ELSE fsc.[TOTAL_EQUITY]
	     END as NTFAReconDiff 
  FROM (SELECT fco.[DvdForecastCalcOverrideId]
        ,CASE WHEN dirr.ACCOUNT_NUMBER = '1709427' THEN 'WIMEIF'
              ELSE 'WIMIFF'
         END as [FUND_SHORT_NAME]
	    ,mp.[QUANTITY] as POSITION
	    ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100
	          ELSE mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]
	     END as GrossDvdValue
	    ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	          ELSE mp.[QUANTITY]*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	     END as NetDvdValue
	    ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	          ELSE ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,fco.[DVD_VALUE])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
	     END as SpecialCumTrades		 
	    ,dirr.[TOTAL_EQUITY]
  FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr
  INNER JOIN [dbo].[T_MASTER_SEC] ms  
  ON (dirr.[CUSIP] = ms.[CUSIP]
      OR dirr.[CUSIP] = ms.[TICKER])
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  INNER JOIN [Investment].[DvdForecastCalcOverride] fco
  ON fco.[EDM_SEC_ID] = ms.[EDM_SEC_ID]
  AND ( (fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] = dirr.[DATE])
  OR (fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] = dirr.[DATE]) )
  
  INNER JOIN [dbo].[T_MASTER_POS] mp
  ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
  AND ( (mp.[FUND_SHORT_NAME] = 'WIMEIF' AND dirr.ACCOUNT_NUMBER = '1709427')
   OR (mp.[FUND_SHORT_NAME] = 'WIMIFF' AND dirr.ACCOUNT_NUMBER = '1744293') ) -- substitute correct account num for WIMIFF
  AND fco.[EX_DATE] = mp.[POSITION_DATE]

  LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
  ON fx.DATE = fco.[EX_DATE]
  AND fx.[FROM_ISO_CURRENCY_CODE]='GBP'
  AND (mse.DIVIDEND_CCY IS NOT NULL AND fx.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
  OR mse.DIVIDEND_CCY IS NULL AND fx.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
  
  WHERE dirr.[CUSIP] IS NOT NULL
  AND dirr.TOTAL_EQUITY != 0 
  AND dirr.[ACCOUNT_NUMBER] IN ('1709427','1744293') -- substitute correct account number for WIMIFF
  AND dirr.[DATE] = (SELECT MAX(DATE) FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr1 WHERE dirr1.[ACCOUNT_NUMBER] = dirr.[ACCOUNT_NUMBER]) -- only interested in latest date for the fund
    
 ) as fsc) as Src
 ON Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
 AND Tar.[DvdForecastCalcOverrideId] = Src.[DvdForecastCalcOverrideId]
   
	 WHEN NOT MATCHED THEN
		INSERT ([FUND_SHORT_NAME],
				[DvdForecastCalcOverrideId],
				[POSITION],
				[GrossDvdValue],
				[NetDvdValue],
				[SpecialCumTrades],
				[TotalNetDvd],
				[NTFAValueBase],
				[NTFAReconDiff],
				[IsActive],
				[JoinGUID])
		VALUES (Src.FUND_SHORT_NAME,
		        Src.DvdForecastCalcOverrideId,
				Src.POSITION,
				Src.GrossDvdValue,
				Src.NetDvdValue,
				Src.SpecialCumTrades,
				Src.NetDvdValue + Src.SpecialCumTrades,
				Src.NTFAValueBase,
				Src.NTFAReconDiff,
				1,
				NewId())	
	 WHEN MATCHED THEN
		UPDATE SET NTFAValueBase = Src.NTFAValueBase
				  ,NTFAReconDiff = Src.NTFAReconDiff
				  ,IsActive = 1
				  ,DvdFundSecurityCalcLastModifiedDatetime=GetDate();

				  
	-- calculate quarterly values for calendar year
	
	-- runs everytime and gets updated also for projected.
	-- once in past can store overrides + comment

	-- calculate NetIncome from rpt + sum (TotalNetDvd) for current Qtr only for future ex-dates though '1709427' 'WIMEIF'
	WITH CurrentRPT_CTE AS
	(
         SELECT
		 CASE dirr.ACCOUNT_NUMBER
			WHEN '1709427' THEN 'WIMEIF'
		 END as [FUND_SHORT_NAME],
         Cal.CalQuarter,
		Cal.CalYear,
		Investment.ufn_GetQtr(Cal.CalendarDate) as Qtr,
        ISNULL(dirr.[CURRENT_NET_INCOME],0) as NetIncome, 
		(SELECT SUM (ISNULL(fco.TotalNetDvd,0)) 
		 FROM [Investment].[DvdForecastCalcOverride] fco 
		 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
		 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId
		 WHERE fco.Qtr = Investment.ufn_GetQtr(Cal.CalendarDate)
		 AND fco.IsActive = 1
		 AND ((fco.OverrideExDate IS NOT NULL AND fco.OverrideExDate >= CAST(GetDate() as date))
		   OR (fco.EX_DATE IS NOT NULL AND fco.OverrideExDate IS NULL AND fco.EX_DATE >= CAST(GetDate() as date)))
		 AND fsc.[FUND_SHORT_NAME] IN ('WIMEIF') AND dirr.[ACCOUNT_NUMBER] IN ('1709427')
		   ) as ProjNetIncome, 
		dirr.[UNITS_IN_ISSUE] as UnitsInIssue
	FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr
	INNER JOIN (SELECT MAX(DATE) as Maxdate, ACCOUNT_NUMBER
                FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
		   	    WHERE [CUSIP] IS NULL
				GROUP BY ACCOUNT_NUMBER) dirr1
	ON dirr.[DATE] = dirr1.MaxDate
	AND dirr.[CUSIP] IS NULL
	INNER JOIN [Core].[Calendar] Cal
	ON dirr.[DATE] = Cal.CalendarDate
	WHERE dirr.ACCOUNT_NUMBER IN ('1709427')
	)
	
	MERGE INTO [Investment].[DvdNTCalcHighLevelOverride] Tar
	USING (
	
    SELECT CAST(GetDate() as date) as DATE, 
	   FUND_SHORT_NAME,
       Qtr,
       NetIncome + ISNULL(ProjNetIncome,0) as NetIncome,
       UnitsInIssue,
	   (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = dirr.Qtr AND chlo.FUND_SHORT_NAME = dirr.FUND_SHORT_NAME ) as PrevDvdRate
        --	,NetIncome/ISNULL(UnitsInIssue,0.00001)*100 as DvdRate
    FROM CurrentRPT_CTE dirr
	where UnitsInIssue is not null


	UNION -- Future Quarters

	SELECT CAST(GetDate() as date) as DATE,
	      dfc.FUND_SHORT_NAME,
          Qtrs.Qtr,
		  SUM (dfc.TotalNetDvd) as NetIncome,
		  CurrQtr.UnitsInIssue as UnitsInIssue,
		  (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = Qtrs.Qtr AND chlo.FUND_SHORT_NAME = dfc.FUND_SHORT_NAME ) as PrevDvdRate
		 -- ,SUM (fco.NetDvdValue + fco.SpecialCumTrades)/ISNULL(CurrQtr.UnitsInIssue,0.00001)*100 as DvdRate
	FROM 
   (SELECT DISTINCT [CalQuarter],[CalYear],[FirstDayOfQuarter],[LastDayOfQuarter], 'Q' + CAST([CalQuarter] as varchar) + ' ' + SUBSTRING(CAST([CalYear] as varchar),3,2) as Qtr
    FROM [Core].[Calendar]
    WHERE CalYear=year(getdate())
	AND CalQuarter > (SELECT CalQuarter FROM [Core].[Calendar] WHERE [CalendarDate] = CAST(Getdate() as DATE))) Qtrs
	LEFT OUTER JOIN (SELECT fco.EX_DATE, fco.OverrideExDate, fco.IsActive, fsc.TotalNetDvd, fsc.FUND_SHORT_NAME
	                 FROM [Investment].[DvdForecastCalcOverride] fco
					 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
					 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId) dfc
	ON ((dfc.OverrideExDate IS NULL AND dfc.EX_DATE IS NOT NULL AND dfc.EX_DATE BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  OR dfc.OverrideExDate BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  AND dfc.IsActive = 1
    CROSS JOIN CurrentRPT_CTE CurrQtr
	where UnitsInIssue is not null
	and dfc.FUND_SHORT_NAME = 'WIMEIF'
	GROUP BY  dfc.FUND_SHORT_NAME
	         ,Qtrs.Qtr
			 ,CurrQtr.UnitsInIssue


    UNION -- past qtrs
	SELECT CAST(GetDate() as date) as DATE,
	      dfc.FUND_SHORT_NAME,
          Qtrs.Qtr,
		  SUM (dfc.TotalNetDvd) as NetIncome,
		  CurrQtr.UnitsInIssue as UnitsInIssue,
		  (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = Qtrs.Qtr AND chlo.FUND_SHORT_NAME = dfc.FUND_SHORT_NAME ) as PrevDvdRate
	FROM 
   (SELECT DISTINCT [CalQuarter],[CalYear],[FirstDayOfQuarter],[LastDayOfQuarter], 'Q' + CAST([CalQuarter] as varchar) + ' ' + SUBSTRING(CAST([CalYear] as varchar),3,2) as Qtr
    FROM [Core].[Calendar]
    WHERE CalYear=year(getdate())
	AND CalQuarter < (SELECT CalQuarter FROM [Core].[Calendar] WHERE [CalendarDate] = CAST(Getdate() as DATE))) Qtrs
	LEFT OUTER JOIN (SELECT fco.EX_DATE, fco.OverrideExDate, fco.IsActive, fsc.TotalNetDvd, fsc.FUND_SHORT_NAME
	                 FROM [Investment].[DvdForecastCalcOverride] fco
					 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
					 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId
					 AND fco.FUND_SHORT_NAME = fsc.FUND_SHORT_NAME) dfc
	ON ((dfc.OverrideExDate IS NULL AND dfc.EX_DATE IS NOT NULL AND dfc.EX_DATE BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  OR dfc.OverrideExDate BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  AND dfc.IsActive = 1
    CROSS JOIN CurrentRPT_CTE CurrQtr
	where UnitsInIssue is not null
	and dfc.FUND_SHORT_NAME = 'WIMEIF'
	GROUP BY  dfc.FUND_SHORT_NAME
	         ,Qtrs.Qtr
			 ,CurrQtr.UnitsInIssue

 
 ) as Src
 ON Tar.[Qtr] = Src.[Qtr]
 AND Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
	 WHEN NOT MATCHED THEN
		INSERT ([DATE],
		        [FUND_SHORT_NAME],
				[Qtr],
				[NetIncome],
				[UnitsInIssue],
				[DvdRate],
				[IsActive],
				[JoinGUID])
			--	[OverrideNetIncome]
            -- ,[OverrideUnitsInIssue])
		VALUES (Src.DATE,
		        Src.[FUND_SHORT_NAME],
				Src.Qtr,
				Src.NetIncome,
				ISNULL(Src.UnitsInIssue,0),
				CASE WHEN ISNULL(Src.UnitsInIssue,0) = 0 THEN 0 ELSE Src.NetIncome/Src.UnitsInIssue*100 END,
				1,
				NewId())
			--	Src.NetIncome,
			--	ISNULL(Src.UnitsInIssue,0))
	 WHEN MATCHED THEN -- use overrides if set
		UPDATE SET DATE = Src.DATE
				  ,NetIncome = Src.NetIncome
				  ,UnitsInIssue = ISNULL(Src.UnitsInIssue,0) 
				  ,DvdRate = CASE WHEN ISNULL(Tar.OverrideUnitsInIssue,0) != 0 THEN ISNULL(Tar.OverrideNetIncome,Src.NetIncome)/Tar.OverrideUnitsInIssue*100
						          WHEN ISNULL(Src.UnitsInIssue,0) != 0 THEN ISNULL(Tar.OverrideNetIncome,Src.NetIncome)/Src.UnitsInIssue*100
							 ELSE 0 END
				  ,PrevDvdRate = Src.PrevDvdRate
				  ,IsActive = 1
				  ,DvdNTCalcHighLevelOverrideLastModifiedDatetime=GetDate();
				  


	-- calculate NetIncome from rpt + sum (TotalNetDvd) for current Qtr only for future ex-dates though 1744293 WIMIFF
	WITH CurrentRPT_CTE AS
	(
         SELECT
		 CASE dirr.ACCOUNT_NUMBER
			WHEN '1744293' THEN 'WIMIFF'
		 END as [FUND_SHORT_NAME],
         Cal.CalQuarter,
		Cal.CalYear,
		Investment.ufn_GetQtr(Cal.CalendarDate) as Qtr,
        ISNULL(dirr.[CURRENT_NET_INCOME],0) as NetIncome, 
		(SELECT SUM (ISNULL(fco.TotalNetDvd,0)) 
		 FROM [Investment].[DvdForecastCalcOverride] fco 
		 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
		 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId
		 WHERE fco.Qtr = Investment.ufn_GetQtr(Cal.CalendarDate)
		 AND fco.IsActive = 1
		 AND ((fco.OverrideExDate IS NOT NULL AND fco.OverrideExDate >= CAST(GetDate() as date))
		   OR (fco.EX_DATE IS NOT NULL AND fco.OverrideExDate IS NULL AND fco.EX_DATE >= CAST(GetDate() as date)))
		 AND fsc.[FUND_SHORT_NAME] IN ('WIMIFF') AND dirr.[ACCOUNT_NUMBER] IN ('1744293')
		   ) as ProjNetIncome, 
		dirr.[UNITS_IN_ISSUE] as UnitsInIssue
	FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr
	INNER JOIN (SELECT MAX(DATE) as Maxdate, ACCOUNT_NUMBER
                FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
		   	    WHERE [CUSIP] IS NULL
				GROUP BY ACCOUNT_NUMBER) dirr1
	ON dirr.[DATE] = dirr1.MaxDate
	AND dirr.[CUSIP] IS NULL
	INNER JOIN [Core].[Calendar] Cal
	ON dirr.[DATE] = Cal.CalendarDate
	WHERE dirr.ACCOUNT_NUMBER IN ('1744293')
	)
	
	MERGE INTO [Investment].[DvdNTCalcHighLevelOverride] Tar
	USING (

    SELECT CAST(GetDate() as date) as DATE, 
	   FUND_SHORT_NAME,
       Qtr,
       NetIncome + ISNULL(ProjNetIncome,0) as NetIncome,
       UnitsInIssue,
	   (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = dirr.Qtr AND chlo.FUND_SHORT_NAME = dirr.FUND_SHORT_NAME ) as PrevDvdRate
        --	,NetIncome/ISNULL(UnitsInIssue,0.00001)*100 as DvdRate
    FROM CurrentRPT_CTE dirr
	where UnitsInIssue is not null


	UNION -- Future Quarters

	
	SELECT CAST(GetDate() as date) as DATE,
	      dfc.FUND_SHORT_NAME,
          Qtrs.Qtr,
		  SUM (dfc.TotalNetDvd) as NetIncome,
		  CurrQtr.UnitsInIssue as UnitsInIssue,
		  (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = Qtrs.Qtr AND chlo.FUND_SHORT_NAME = dfc.FUND_SHORT_NAME ) as PrevDvdRate
		 -- ,SUM (fco.NetDvdValue + fco.SpecialCumTrades)/ISNULL(CurrQtr.UnitsInIssue,0.00001)*100 as DvdRate
	FROM 
   (SELECT DISTINCT [CalQuarter],[CalYear],[FirstDayOfQuarter],[LastDayOfQuarter], 'Q' + CAST([CalQuarter] as varchar) + ' ' + SUBSTRING(CAST([CalYear] as varchar),3,2) as Qtr
    FROM [Core].[Calendar]
    WHERE CalYear=year(getdate())
	AND CalQuarter > (SELECT CalQuarter FROM [Core].[Calendar] WHERE [CalendarDate] = CAST(Getdate() as DATE))) Qtrs
	LEFT OUTER JOIN (SELECT fco.EX_DATE, fco.OverrideExDate, fco.IsActive, fsc.TotalNetDvd, fsc.FUND_SHORT_NAME
	                 FROM [Investment].[DvdForecastCalcOverride] fco
					 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
					 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId) dfc
	ON ((dfc.OverrideExDate IS NULL AND dfc.EX_DATE IS NOT NULL AND dfc.EX_DATE BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  OR dfc.OverrideExDate BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  AND dfc.IsActive = 1
    CROSS JOIN CurrentRPT_CTE CurrQtr
	where UnitsInIssue is not null
	and dfc.FUND_SHORT_NAME = 'WIMIFF'
	GROUP BY  dfc.FUND_SHORT_NAME
	         ,Qtrs.Qtr
			 ,CurrQtr.UnitsInIssue


    UNION -- past qtrs
	SELECT CAST(GetDate() as date) as DATE,
	      dfc.FUND_SHORT_NAME,
          Qtrs.Qtr,
		  SUM (dfc.TotalNetDvd) as NetIncome,
		  CurrQtr.UnitsInIssue as UnitsInIssue,
		  (SELECT DvdRate FROM [Investment].[DvdNTCalcHighLevelOverride] chlo WHERE chlo.Qtr = Qtrs.Qtr AND chlo.FUND_SHORT_NAME = dfc.FUND_SHORT_NAME ) as PrevDvdRate
	FROM 
   (SELECT DISTINCT [CalQuarter],[CalYear],[FirstDayOfQuarter],[LastDayOfQuarter], 'Q' + CAST([CalQuarter] as varchar) + ' ' + SUBSTRING(CAST([CalYear] as varchar),3,2) as Qtr
    FROM [Core].[Calendar]
    WHERE CalYear=year(getdate())
	AND CalQuarter < (SELECT CalQuarter FROM [Core].[Calendar] WHERE [CalendarDate] = CAST(Getdate() as DATE))) Qtrs
	LEFT OUTER JOIN (SELECT fco.EX_DATE, fco.OverrideExDate, fco.IsActive, fsc.TotalNetDvd, fsc.FUND_SHORT_NAME
	                 FROM [Investment].[DvdForecastCalcOverride] fco
					 INNER JOIN [Investment].[DvdFundSecurityCalc] fsc
					 ON fco.DvdForecastCalcOverrideId = fsc.DvdForecastCalcOverrideId
					 AND fco.FUND_SHORT_NAME = fsc.FUND_SHORT_NAME) dfc
	ON ((dfc.OverrideExDate IS NULL AND dfc.EX_DATE IS NOT NULL AND dfc.EX_DATE BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  OR dfc.OverrideExDate BETWEEN Qtrs.[FirstDayOfQuarter] AND Qtrs.[LastDayOfQuarter])
	  AND dfc.IsActive = 1
    CROSS JOIN CurrentRPT_CTE CurrQtr
	where UnitsInIssue is not null
	and dfc.FUND_SHORT_NAME = 'WIMIFF'
	GROUP BY  dfc.FUND_SHORT_NAME
	         ,Qtrs.Qtr
			 ,CurrQtr.UnitsInIssue

 
 ) as Src
 ON Tar.[Qtr] = Src.[Qtr]
 AND Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
	 WHEN NOT MATCHED THEN
		INSERT ([DATE],
		        [FUND_SHORT_NAME],
				[Qtr],
				[NetIncome],
				[UnitsInIssue],
				[DvdRate],
				[IsActive],
				[JoinGUID])
			--	[OverrideNetIncome]
            -- ,[OverrideUnitsInIssue])
		VALUES (Src.DATE,
		        Src.[FUND_SHORT_NAME],
				Src.Qtr,
				Src.NetIncome,
				ISNULL(Src.UnitsInIssue,0),
				CASE WHEN ISNULL(Src.UnitsInIssue,0) = 0 THEN 0 ELSE Src.NetIncome/Src.UnitsInIssue*100 END,
				1,
				NewId())
			--	Src.NetIncome,
			--	ISNULL(Src.UnitsInIssue,0))
	 WHEN MATCHED THEN -- use overrides if set
		UPDATE SET DATE = Src.DATE
				  ,NetIncome = Src.NetIncome
				  ,UnitsInIssue = ISNULL(Src.UnitsInIssue,0) 
				  ,DvdRate = CASE WHEN ISNULL(Tar.OverrideUnitsInIssue,0) != 0 THEN ISNULL(Tar.OverrideNetIncome,Src.NetIncome)/Tar.OverrideUnitsInIssue*100
						          WHEN ISNULL(Src.UnitsInIssue,0) != 0 THEN ISNULL(Tar.OverrideNetIncome,Src.NetIncome)/Src.UnitsInIssue*100
							 ELSE 0 END
				  ,PrevDvdRate = Src.PrevDvdRate
				  ,IsActive = 1
				  ,DvdNTCalcHighLevelOverrideLastModifiedDatetime=GetDate();



				  
 -- high level FA diff -store against qtr
 
 MERGE INTO [Investment].[DvdNTCalcHighLevelOverride] Tar
	USING (

 SELECT d.DATE, d.FUND_SHORT_NAME, d.Qtr, SUM(d.NTFAReconDiff) as NTFAReconDiff
 FROM
 (
 SELECT dirr.[DATE],
        CASE WHEN dirr.ACCOUNT_NUMBER = '1709427' THEN 'WIMEIF'
              ELSE 'WIMIFF'
        END as [FUND_SHORT_NAME],
	    Investment.ufn_GetQtr(dirr.[DATE]) as Qtr,
        CASE WHEN dirr.[ACCOUNT_NUMBER] = '1709427' THEN -- WIMEIF
				ISNULL(dirr.[CURRENT_NET_INCOME],0) - ISNULL(dirr.[EQL_LIQUIDATIONS],0) - ISNULL(dirr.[EQL_CREATIONS],0) - ISNULL(dirr.[EXCH_GAIN_LOSS],0) - ISNULL(PrevIncomeWIMEIF.[CURRENT_NET_INCOME],0)
		   	 ELSE
				ISNULL(dirr.[CURRENT_NET_INCOME],0) - ISNULL(dirr.[EQL_LIQUIDATIONS],0) - ISNULL(dirr.[EQL_CREATIONS],0) - ISNULL(dirr.[EXCH_GAIN_LOSS],0) - ISNULL(PrevIncomeWIMIFF.[CURRENT_NET_INCOME],0)			
		END as NTFAReconDiff
 FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT] dirr
 INNER JOIN (SELECT ACCOUNT_NUMBER,MAX(DATE) as Maxdate
             FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
			 WHERE [CUSIP] IS NULL
			 GROUP BY ACCOUNT_NUMBER) dirr1
 ON dirr.[DATE] = dirr1.MaxDate
 AND dirr.[ACCOUNT_NUMBER] = dirr1.[ACCOUNT_NUMBER]
 AND dirr.[CUSIP] IS NULL


 LEFT OUTER JOIN (SELECT TOP 1 [CURRENT_NET_INCOME]
             FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
			 WHERE [DATE] < (SELECT MAX(DATE)
				             FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
						     WHERE [CUSIP] IS NULL
							 AND [ACCOUNT_NUMBER] = '1709427')
			 AND [CUSIP] IS NULL
			 AND [ACCOUNT_NUMBER] = '1709427'
			 ORDER BY [DATE] desc
				  ) PrevIncomeWIMEIF
 ON dirr.[ACCOUNT_NUMBER] = '1709427'

 LEFT OUTER JOIN (SELECT TOP 1 [CURRENT_NET_INCOME]
             FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
			 WHERE [DATE] < (SELECT MAX(DATE)
				             FROM [dbo].[T_NT_DIVIDENDS_INCOME_REC_RPT]
						     WHERE [CUSIP] IS NULL
							 AND [ACCOUNT_NUMBER] = '1744293') -- WIMIFF substitute for correct account number
			 AND [CUSIP] IS NULL
			 AND [ACCOUNT_NUMBER] = '1744293'
			 ORDER BY [DATE] desc
				  ) PrevIncomeWIMIFF
 ON dirr.[ACCOUNT_NUMBER] = '1744293' -- WIMIFF substitute for correct account number 
 ) d GROUP BY d.DATE, d.FUND_SHORT_NAME, d.Qtr
				  
 ) as Src
 ON Tar.[Qtr] = Src.[Qtr]
 AND Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
	 WHEN NOT MATCHED THEN
		INSERT ([DATE],
		        [FUND_SHORT_NAME],
				[Qtr],
				[NTFAReconDiff],
				[IsActive],
				[JoinGUID])
		VALUES (Src.DATE,
		        Src.FUND_SHORT_NAME,
				Src.Qtr,
				Src.NTFAReconDiff,
				1,
				NewId())
	 WHEN MATCHED THEN
		UPDATE SET NTFAReconDiff = Src.NTFAReconDiff
		          ,DATE = Src.DATE
				  ,IsActive = 1
				  ,DvdNTCalcHighLevelOverrideLastModifiedDatetime=GetDate();				  


	-- Ensure we have the fund short name		
	UPDATE Investment.DvdForecastCalcOverride
	SET FUND_SHORT_NAME = b.FUND_SHORT_NAME
	FROM Investment.DvdForecastCalcOverride a
	JOIN T_MASTER_POS b
	ON A.EDM_SEC_ID = b.EDM_SEC_ID


	-- We only wan to see funds for WIMEIF and WIMIFF
	
	ALTER TABLE [Investment].[DvdForecastOverrideEvents] DROP CONSTRAINT [DvdForecastOverrideEventsCalcOverrideId]
	ALTER TABLE [Investment].[DvdFundSecurityCalc] DROP CONSTRAINT [DvdFundSecurityCalcDvdForecastCalcOverrideId]

	DELETE [Investment].[DvdForecastOverrideEvents]
	FROM [Investment].[DvdForecastOverrideEvents] a
	JOIN Investment.DvdForecastCalcOverride b
	ON a.DvdForecastCalcOverrideId = b.DvdForecastCalcOverrideId
	AND b.FUND_SHORT_NAME NOT IN ('WIMEIF', 'WIMIFF')

	DELETE FROM Investment.DvdForecastCalcOverride WHERE FUND_SHORT_NAME NOT IN ('WIMEIF', 'WIMIFF')

	ALTER TABLE [Investment].[DvdForecastOverrideEvents]  WITH CHECK ADD  CONSTRAINT [DvdForecastOverrideEventsCalcOverrideId] FOREIGN KEY([DvdForecastCalcOverrideId])
	REFERENCES [Investment].[DvdForecastCalcOverride] ([DvdForecastCalcOverrideId])

	ALTER TABLE [Investment].[DvdFundSecurityCalc]  WITH NOCHECK ADD  CONSTRAINT [DvdFundSecurityCalcDvdForecastCalcOverrideId] FOREIGN KEY([DvdForecastCalcOverrideId])
	REFERENCES [Investment].[DvdForecastCalcOverride] ([DvdForecastCalcOverrideId])


	-- update position
	UPDATE Investment.DvdForecastCalcOverride 
	SET POSITION = P1.QUANTITY
	FROM T_MASTER_POS P1 
	JOIN Investment.DvdForecastCalcOverride O
	ON P1.EDM_SEC_ID = O.EDM_SEC_ID
	AND P1.FUND_SHORT_NAME = O.FUND_SHORT_NAME
	AND P1.POSITION_DATE = (SELECT MAX(POSITION_DATE) FROM T_MASTER_POS WHERE EDM_SEC_ID = P1.EDM_SEC_ID AND FUND_SHORT_NAME = P1.FUND_SHORT_NAME)

				  
END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH;

