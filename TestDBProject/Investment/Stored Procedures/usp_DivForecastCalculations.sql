CREATE PROCEDURE [Investment].[usp_DivForecastCalculations] AS
-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[usp_DivForecastCalculations]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			10/01/2017
--					D Bacchus
--					04/05/2017
--					D Bacchus	pevent subquey returning more than one value error
--					05/05/2017
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		perform div forecast calculations
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

	SET NOCOUNT ON;

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Investment].[usp_DivForecastCalculations]';
	DECLARE @CurrentQtrStartDate 	[DATE];
	
	DECLARE @Ids TABLE ( DvdForecastCalcOverrideId int );
	
	SET @CurrentQtrStartDate = (SELECT [FirstDayOfQuarter]
				   			    FROM [Core].[Calendar]
							    WHERE CalendarDate = cast(getdate() as date));
						
-- make [Investment].[DvdForecastCalcOverride] inactive where not in [DVD_HIST]/[DVD_PROJ]
-- this means EX_DATE has changed
UPDATE fco
SET [IsActive] = 0,
    [DvdForecastCalcOverrideLastModifiedDatetime] = GetDate()
FROM [Investment].[DvdForecastCalcOverride] fco
WHERE NOT EXISTS (
SELECT EX_DATE
FROM [dbo].[T_BPS_DVD_HIST] bdh
WHERE bdh.EX_DATE = fco.EX_DATE
AND bdh.EDM_SEC_ID = fco.EDM_SEC_ID
UNION
SELECT EX_DATE
FROM [dbo].[T_BPS_DVD_PROJECT] bdp
WHERE bdp.EX_DATE = fco.EX_DATE
AND bdp.EDM_SEC_ID = fco.EDM_SEC_ID)
AND fco.EX_DATE IS NOT NULL;				  
					  
-- calculate for Override where no EX_Date in BPS DVD

-- update on DvdForecastCalcOverride  
UPDATE fco
	SET WITHHOLDING_TAX = ISNULL(ms.[WITHHOLDING_TAX],0),
		DIVIDEND_CCY = ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY),
		Qtr = Investment.ufn_GetQtr(fco.[OverrideExDate]),
		DvdForecastCalcOverrideLastModifiedDatetime = GetDate()
FROM [Investment].[DvdForecastCalcOverride] fco
INNER JOIN [dbo].[T_MASTER_SEC] ms
ON ms.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
INNER JOIN T_MASTER_SEC_EQUITY mse
ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
WHERE fco.[OverrideExDate] >= cast(GetDate() as date)
AND fco.EX_DATE IS NULL
AND fco.[IsActive] = 1;

-- ... and MERGE into DvdFundSecurityCalc (record may exist in which case update)

WITH NT_POS_CTE AS
 (SELECT [ACCOUNT],
         [EDM_SEC_ID],
   		 MAX([TRADE_DATE]) as MaxTradeDate
  FROM [dbo].[T_NT_POS]
  --WHERE Account='WIMEIF'
  GROUP BY [ACCOUNT],[EDM_SEC_ID]),
   FXRATE_CTE AS
 (SELECT [TO_ISO_CURRENCY_CODE],
         MAX(DATE) as MaxDate
  FROM [dbo].[T_MASTER_FXRATE]
  WHERE [FROM_ISO_CURRENCY_CODE]='GBP'
  GROUP BY [TO_ISO_CURRENCY_CODE])
 
MERGE INTO [Investment].[DvdFundSecurityCalc] Tar
	USING ( SELECT npe.ACCOUNT as FUND_SHORT_NAME,
	               fco.DvdForecastCalcOverrideId,
                   CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN np.[POSITION]*ISNULL(fco.OverrideDvdValue,0)/100
					    ELSE np.[POSITION]*ISNULL(fco.OverrideDvdValue,0)/fx.[SPOT_RATE]
					    END as GrossDvdValue,
                   CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN np.[POSITION]*ISNULL(fco.OverrideDvdValue,0)/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
					    ELSE np.[POSITION]*ISNULL(fco.OverrideDvdValue,0)/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
					    END as NetDvdValue,
	               CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,0)/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
					    ELSE ISNULL(fco.OverrideSpecialCumShares,0)*ISNULL(fco.OverrideDvdValue,0)/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
					    END as SpecialCumTrades,
	               1 as IsActive,
	               np.[POSITION] as Position
            FROM [Investment].[DvdForecastCalcOverride] fco
            INNER JOIN [dbo].[T_MASTER_SEC] ms
            ON ms.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
            INNER JOIN T_MASTER_SEC_EQUITY mse
 ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
            INNER JOIN NT_POS_CTE npe
            ON npe.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
            AND npe.[ACCOUNT] IN ('WIMEIF','WIMIFF')
            INNER JOIN [dbo].[T_NT_POS] np
            ON npe.[EDM_SEC_ID] = np.[EDM_SEC_ID]
            AND npe.MaxTradeDate = np.TRADE_DATE
			AND npe.[ACCOUNT] = np.[ACCOUNT]
            --AND np.Account='WIMEIF'
            LEFT OUTER JOIN FXRATE_CTE fxc
            ON (mse.DIVIDEND_CCY IS NOT NULL AND fxc.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
            OR mse.DIVIDEND_CCY IS NULL AND fxc.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
            LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
            ON fx.DATE = fxc.MaxDate
            AND fx.[TO_ISO_CURRENCY_CODE] = fxc.[TO_ISO_CURRENCY_CODE]
            WHERE fco.[OverrideExDate] >= cast(GetDate() as date)
            AND fco.EX_DATE IS NULL
            AND fco.[IsActive] = 1
          ) Src
        ON Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
        AND Tar.[DvdForecastCalcOverrideId] = Src.[DvdForecastCalcOverrideId]
    WHEN NOT MATCHED THEN
		INSERT ([FUND_SHORT_NAME]
               ,[DvdForecastCalcOverrideId]
               ,[POSITION]
               ,[GrossDvdValue]
               ,[NetDvdValue]
               ,[SpecialCumTrades]
               ,[TotalNetDvd]
               ,[UseNTCustodyValue]
               ,[UseNTFAValue]
               ,[IsActive]
               ,[JoinGUID])
		VALUES (Src.FUND_SHORT_NAME,
				Src.DvdForecastCalcOverrideId,
				Src.POSITION,
				Src.GrossDvdValue,
				Src.NetDvdValue,
				Src.SpecialCumTrades,
				Src.NetDvdValue + Src.SpecialCumTrades,
			    'TBD',
				'TBD',
				Src.IsActive,
				NewId())
	 WHEN MATCHED THEN
		UPDATE SET POSITION = Src.POSITION
		          ,GrossDvdValue = Src.GrossDvdValue
				  ,NetDvdValue = Src.NetDvdValue
				  ,SpecialCumTrades = Src.SpecialCumTrades
				  ,IsActive = Src.IsActive
				  ,TotalNetDvd = Src.NetDvdValue + Src.SpecialCumTrades
				  ,DvdFundSecurityCalcLastModifiedDatetime = GetDate();

------------------------------------------------------------------------

-- perform div calculations for EX Dates in BPS DVD 
-- get everything for current quarter onwards and into the future
-- use FX Rate/ Position at this date or latest one if in future

-- allow for scenario where override entries have been put in already for new record.
-- this requires us to update rather than insert (otherwise get two rows - override and BPS for same security/ex_date)

-- need Merge for both DvdForecastCalcOverride/DvdFundSecurityCalc

-- may get more than dividend entry (regular/special) for sec/ex-date so sum up
  
MERGE INTO [Investment].[DvdForecastCalcOverride] Tar
	USING ( 
	SELECT 
	DISTINCT
	bdh.[EDM_SEC_ID]
      ,bdh.[EX_DATE] as EX_DATE
      ,bdh.[DVD_VALUE]
	  ,1 as IsActive
	  ,ms.[SECURITY_NAME] 
	  ,ISNULL(ms.[WITHHOLDING_TAX],0) as WITHHOLDING_TAX
	  ,ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) as DIVIDEND_CCY
	  ,Investment.ufn_GetQtr(bdh.[EX_DATE]) as Qtr
	  ,(SELECT TOP 1 dfco.DVD_VALUE FROM [Investment].[DvdForecastCalcOverride] dfco WHERE bdh.[EDM_SEC_ID] = dfco.[EDM_SEC_ID] AND bdh.[EX_DATE] = dfco.[EX_DATE]) as PrevDvdValue
	 -- ,ISNULL(fco.OverrideExDate,fco.EX_DATE) as OverrideExDate
	 -- ,ISNULL(fco.OverrideDvdValue,fco.DVD_VALUE) as OverrideDvdValue
	 -- ,ISNULL(fco.OverrideSpecialCumShares,0) as OverrideSpecialCumShares
  FROM (SELECT [EDM_SEC_ID],[EX_DATE],SUM([DVD_VALUE]) AS [DVD_VALUE]
        FROM [dbo].[T_BPS_DVD_HIST]
        GROUP BY [EDM_SEC_ID],[EX_DATE]) bdh
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  LEFT OUTER JOIN [Investment].[DvdForecastCalcOverride] fco-- check for Override values for sec_id/ex_date
  ON fco.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  AND (fco.[EX_DATE] = bdh.[EX_DATE]
  OR fco.[EX_DATE] IS NULL AND fco.[OverrideExDate] = bdh.[EX_DATE])
  --AND fco.[IsActive] = 1 -- only get active ones
  WHERE bdh.[EX_DATE] >= @CurrentQtrStartDate
  AND bdh.[EX_DATE] < cast(GetDate() as date)
  AND EXISTS (SELECT 1 
              FROM [dbo].[T_MASTER_POS] mp
              WHERE bdh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
              AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF'))
  
  UNION -- future ex-dates
  SELECT 
  DISTINCT
  bdh.[EDM_SEC_ID]
      ,bdh.[EX_DATE] as EX_DATE
      ,bdh.[DVD_VALUE]
	  ,1 as IsActive
	  ,ms.[SECURITY_NAME] 
	  ,ISNULL(ms.[WITHHOLDING_TAX],0) as WITHHOLDING_TAX
	  ,ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) as DIVIDEND_CCY
	  ,Investment.ufn_GetQtr(bdh.[EX_DATE]) as Qtr
	  ,(SELECT TOP 1 dfco.DVD_VALUE FROM [Investment].[DvdForecastCalcOverride] dfco WHERE bdh.[EDM_SEC_ID] = dfco.[EDM_SEC_ID] AND bdh.[EX_DATE] = dfco.[EX_DATE]) as PrevDvdValue
	 -- ,ISNULL(fco.OverrideExDate,fco.EX_DATE) as OverrideExDate
	 -- ,ISNULL(fco.OverrideDvdValue,fco.DVD_VALUE) as OverrideDvdValue
	 -- ,ISNULL(fco.OverrideSpecialCumShares,0) as OverrideSpecialCumShares
  FROM (SELECT [EDM_SEC_ID],[EX_DATE],SUM([DVD_VALUE]) AS [DVD_VALUE]
        FROM [dbo].[T_BPS_DVD_HIST]
        GROUP BY [EDM_SEC_ID],[EX_DATE]) bdh
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  LEFT OUTER JOIN [Investment].[DvdForecastCalcOverride] fco-- check for Override values for sec_id/ex_date
  ON fco.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  AND (fco.[EX_DATE] = bdh.[EX_DATE]
    OR fco.[EX_DATE] IS NULL AND fco.[OverrideExDate] = bdh.[EX_DATE])
  WHERE bdh.[EX_DATE] >= cast(GetDate() as date)
  AND EXISTS (SELECT 1 
              FROM [dbo].[T_MASTER_POS] mp
              WHERE bdh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
              AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF'))
  
  UNION -- for Proj
  SELECT 
  DISTINCT
  bdh.[EDM_SEC_ID]
      ,bdh.[EX_DATE] as EX_DATE
      ,bdh.[DVD_VALUE]
	  ,1 as IsActive
	  ,ms.[SECURITY_NAME] 
	  ,ISNULL(ms.[WITHHOLDING_TAX],0) as WITHHOLDING_TAX
	  ,ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) as DIVIDEND_CCY
	  ,Investment.ufn_GetQtr(bdh.[EX_DATE]) as Qtr
	  ,(SELECT TOP 1 dfco.DVD_VALUE FROM [Investment].[DvdForecastCalcOverride] dfco WHERE bdh.[EDM_SEC_ID] = dfco.[EDM_SEC_ID] AND bdh.[EX_DATE] = dfco.[EX_DATE]) as PrevDvdValue
	 -- ,ISNULL(fco.OverrideExDate,fco.EX_DATE) as OverrideExDate
	 -- ,ISNULL(fco.OverrideDvdValue,fco.DVD_VALUE) as OverrideDvdValue
	 -- ,ISNULL(fco.OverrideSpecialCumShares,0) as OverrideSpecialCumShares
  FROM (SELECT [EDM_SEC_ID],[EX_DATE],SUM([DVD_VALUE]) AS [DVD_VALUE]
        FROM [dbo].[T_BPS_DVD_PROJECT]
        GROUP BY [EDM_SEC_ID],[EX_DATE]) bdh
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  LEFT OUTER JOIN [Investment].[DvdForecastCalcOverride] fco-- check for Override values for sec_id/ex_date
  ON fco.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
  AND (fco.[EX_DATE] = bdh.[EX_DATE]
    OR fco.[EX_DATE] IS NULL AND fco.[OverrideExDate] = bdh.[EX_DATE])
  --AND fco.[IsActive] = 1 -- only get active ones
  WHERE bdh.[EX_DATE] >= cast(GetDate() as date)
  AND EXISTS (SELECT 1 
              FROM [dbo].[T_MASTER_POS] mp
              WHERE bdh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
              AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF'))
		) Src
	 ON Tar.[EDM_SEC_ID] = Src.[EDM_SEC_ID]
	 AND (Tar.[EX_DATE] = Src.[EX_DATE]
	 OR Tar.[EX_DATE] IS NULL AND Tar.[OverrideExDate] = Src.[EX_DATE])
	 WHEN NOT MATCHED THEN
		INSERT ([EDM_SEC_ID],
				[EX_DATE],
				[DVD_VALUE],
				[IsActive],
				[JoinGUID],
				[SECURITY_NAME],
				[DIVIDEND_CCY],
	            [WITHHOLDING_TAX],
				[Qtr],
			--	[OverrideExDate],
			--	[OverrideDvdValue],
				[OverrideSpecialCumShares])
		VALUES (Src.EDM_SEC_ID,
				Src.EX_DATE,
				Src.DVD_VALUE,
				Src.IsActive,
				NewId(),
				Src.SECURITY_NAME,
				Src.DIVIDEND_CCY,
	            Src.WITHHOLDING_TAX,
				Src.Qtr,
				0)
	 WHEN MATCHED THEN
		UPDATE SET IsActive = Src.IsActive
				  ,DIVIDEND_CCY = Src.DIVIDEND_CCY
				  ,WITHHOLDING_TAX = Src.WITHHOLDING_TAX
				  ,Qtr = Src.Qtr
				  ,DVD_VALUE = Src.DVD_VALUE
				  ,PrevDvdValue = Src.PrevDvdValue
				  ,EX_DATE = Src.EX_DATE
				  ,DvdForecastCalcOverrideLastModifiedDatetime = GetDate()
	OUTPUT inserted.DvdForecastCalcOverrideId 
	INTO @Ids(DvdForecastCalcOverrideId )
	;

-- now merge into DvdFundSecurityCalc based on DvdForecastCalcOverrideId inserted/updated
WITH MASTER_POS_CTE AS
 (
 SELECT DISTINCT 
		[FUND_SHORT_NAME],
         [EDM_SEC_ID],
   		 MAX([POSITION_DATE]) as MaxPositionDate
  FROM [dbo].[T_MASTER_POS]
  WHERE FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF')
  GROUP BY [FUND_SHORT_NAME],[EDM_SEC_ID]
  ),
   FXRATE_CTE AS
 (
 SELECT [TO_ISO_CURRENCY_CODE],
         MAX(DATE) as MaxDate
  FROM [dbo].[T_MASTER_FXRATE]
  WHERE [FROM_ISO_CURRENCY_CODE]='GBP'
  GROUP BY [TO_ISO_CURRENCY_CODE]
  )


MERGE INTO [Investment].[DvdFundSecurityCalc] Tar
	USING ( 
	
	SELECT d.FUND_SHORT_NAME, d.DvdForecastcalcOverrideId, MAX(d.POSITION) AS POSITION, MAX(d.GrossDvdValue) AS GrossDvdValue, MAX(d.NetDvdValue) AS NetDvdValue, MAX(d.SpecialCumTrades) AS SpecialCumTrades, IsActive
	FROM
	(
	SELECT mp.[FUND_SHORT_NAME]
	  ,fco.[DvdForecastCalcOverrideId]
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
	  ,1 as IsActive
  FROM [Investment].[DvdForecastCalcOverride] fco
  INNER JOIN @Ids Ids
  ON Ids.DvdForecastCalcOverrideId = fco.DvdForecastCalcOverrideId
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
  INNER JOIN [dbo].[T_MASTER_POS] mp
  ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
  AND fco.[EX_DATE] = mp.[POSITION_DATE]
  AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF')
  LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
  ON fx.DATE = fco.[EX_DATE]
  AND fx.[FROM_ISO_CURRENCY_CODE]='GBP'
  AND (mse.DIVIDEND_CCY IS NOT NULL AND fx.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
  OR mse.DIVIDEND_CCY IS NULL AND fx.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)  
  WHERE fco.[EX_DATE] >= @CurrentQtrStartDate
  AND fco.[EX_DATE] < cast(GetDate() as date)
  UNION
  SELECT mp.[FUND_SHORT_NAME]
	  ,fco.[DvdForecastCalcOverrideId]
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
	  ,1 as IsActive
  FROM [Investment].[DvdForecastCalcOverride] fco
  INNER JOIN @Ids Ids
  ON Ids.DvdForecastCalcOverrideId = fco.DvdForecastCalcOverrideId
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON ms.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
  INNER JOIN T_MASTER_SEC_EQUITY mse
  ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]  
  INNER JOIN MASTER_POS_CTE mpe
  ON mpe.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
  AND mpe.[FUND_SHORT_NAME] IN ('WIMEIF', 'WIMIFF')
  INNER JOIN [dbo].[T_MASTER_POS] mp
  ON mpe.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
  AND mpe.MaxPositionDate = mp.POSITION_DATE
  AND mp.FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF')
  LEFT OUTER JOIN FXRATE_CTE fxc
  ON (mse.DIVIDEND_CCY IS NOT NULL AND fxc.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
  OR mse.DIVIDEND_CCY IS NULL AND fxc.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
  LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
  ON fx.DATE = fxc.MaxDate
  AND fx.[TO_ISO_CURRENCY_CODE] = fxc.[TO_ISO_CURRENCY_CODE]  
  WHERE fco.[EX_DATE] >= cast(GetDate() as date)
  ) d 
  GROUP BY d.FUND_SHORT_NAME, d.DvdForecastcalcOverrideId, IsActive
  
		) Src
	 ON Tar.[FUND_SHORT_NAME] = Src.[FUND_SHORT_NAME]
	 AND Tar.[DvdForecastCalcOverrideId] = Src.[DvdForecastCalcOverrideId]
	 WHEN NOT MATCHED THEN
		INSERT ([FUND_SHORT_NAME],
				[DvdForecastCalcOverrideId],
				[POSITION],
				[GrossDvdValue],
				[NetDvdValue],
				[SpecialCumTrades],
				[IsActive],
				[JoinGUID],
				[TotalNetDvd],
				[UseNTCustodyValue],
                [UseNTFAValue])
		VALUES (Src.FUND_SHORT_NAME,
				Src.DvdForecastCalcOverrideId,
				Src.POSITION,
				Src.GrossDvdValue,
				Src.NetDvdValue,
				Src.SpecialCumTrades,
				Src.IsActive,
				NewId(),
				Src.NetDvdValue + Src.SpecialCumTrades,
				'TBD',
				'TBD')
	 WHEN MATCHED THEN
		UPDATE SET GrossDvdValue = Src.GrossDvdValue
				  ,NetDvdValue = Src.NetDvdValue
				  ,SpecialCumTrades = Src.SpecialCumTrades
				  ,IsActive = Src.IsActive
				  ,POSITION = Src.POSITION
				  ,TotalNetDvd = Src.NetDvdValue + Src.SpecialCumTrades
				  ,DvdFundSecurityCalcLastModifiedDatetime = GetDate();
 

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

