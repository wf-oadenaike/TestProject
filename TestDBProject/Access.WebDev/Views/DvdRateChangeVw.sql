CREATE VIEW [Access.WebDev].[DvdRateChangeVw]
	AS 
   WITH PrevOverrideRate_CTE as
     (SELECT [DvdForecastCalcOverrideId]
            ,MAX([DvdForecastOverrideEventLastModifiedDatetime]) as PrevUpdatedDate
      FROM [Investment].[DvdForecastOverrideEvents]
      WHERE [DvdForecastOverrideEventLastModifiedDatetime] < CAST(GetDate() as date)
	  AND [OverrideDvdValue] IS NOT NULL
      GROUP BY [DvdForecastCalcOverrideId]), 
	NT_POS_CTE AS
     (SELECT [ACCOUNT],[EDM_SEC_ID],
        	 MAX([TRADE_DATE]) as MaxTradeDate
      FROM [dbo].[T_NT_POS]
      WHERE Account IN ('WIMEIF','WIMIFF')
      GROUP BY [ACCOUNT],[EDM_SEC_ID]),
    FXRATE_CTE AS
     (SELECT [TO_ISO_CURRENCY_CODE],
             MAX(DATE) as MaxDate
      FROM [dbo].[T_MASTER_FXRATE]
      WHERE [FROM_ISO_CURRENCY_CODE]='GBP'
      GROUP BY [TO_ISO_CURRENCY_CODE])

	-- no override value
    SELECT mp.[FUND_SHORT_NAME]
          ,fco.[EDM_SEC_ID]
          ,fco.[SECURITY_NAME]
		  ,ms.[TICKER]
          ,fco.[EX_DATE] as [EX_DATE]
		  ,fco.[PrevDvdValue] as PrevDvdValue
          ,fco.[DVD_VALUE] as NewDvdValue
		  ,fco.[DVD_VALUE] - fco.[PrevDvdValue] as ChangeDvdValue
		  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN np.[POSITION]*(fco.[DVD_VALUE] - fco.[PrevDvdValue])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
			    ELSE np.[POSITION]*(fco.[DVD_VALUE] - fco.[PrevDvdValue])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
		   END as ChangeAmount
          ,UPPER(fco.[DIVIDEND_CCY]) as [DIVIDEND_CCY]
		  ,(SELECT MAX([DvdForecastCalcOverrideLastModifiedDatetime]) FROM [Investment].[DvdForecastCalcOverride]) as LastUpdatedDate
    FROM [Investment].[DvdForecastCalcOverride] fco
	INNER JOIN (SELECT FUND_SHORT_NAME, EDM_SEC_ID, MAX(POSITION_DATE) as MaxPositionDate
	            FROM [dbo].[T_MASTER_POS]
				WHERE [FUND_SHORT_NAME] IN ('WIMEIF','WIMIFF')
				GROUP BY FUND_SHORT_NAME, EDM_SEC_ID) mp
	ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_MASTER_SEC] ms
	ON ms.EDM_SEC_ID = fco.EDM_SEC_ID
	INNER JOIN T_MASTER_SEC_EQUITY mse
    ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
	INNER JOIN NT_POS_CTE npe
    ON npe.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_NT_POS] np
    ON npe.[EDM_SEC_ID] = np.[EDM_SEC_ID]
    AND npe.MaxTradeDate = np.TRADE_DATE
    AND np.Account=mp.[FUND_SHORT_NAME]
	LEFT OUTER JOIN FXRATE_CTE fxc
    ON (mse.DIVIDEND_CCY IS NOT NULL AND fxc.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
    OR mse.DIVIDEND_CCY IS NULL AND fxc.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
    LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
    ON fx.DATE = fxc.MaxDate
    AND fx.[TO_ISO_CURRENCY_CODE] = fxc.[TO_ISO_CURRENCY_CODE]
    WHERE ((fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] >= CAST(GetDate() as date) AND fco.[OverrideExDate] <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0)))
	OR (fco.[OverrideExDate] IS NULL AND fco.EX_DATE>= CAST(GetDate() as date) AND fco.EX_DATE <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0))))
	AND fco.OverrideDvdValue IS NULL AND fco.[PrevDvdValue] IS NOT NULL AND fco.[DVD_VALUE] IS NOT NULL AND fco.[PrevDvdValue] != fco.[DVD_VALUE]
	AND IsActive=1

	UNION -- previous overrides
	
    SELECT mp.[FUND_SHORT_NAME]
          ,fco.[EDM_SEC_ID]
          ,fco.[SECURITY_NAME]
		  ,ms.[TICKER]
          ,ISNULL(fco.[OverrideExDate],fco.[EX_DATE]) as [EX_DATE]
		  ,fcoe.[OverrideDvdValue] as PrevDvdValue
          ,fco.[OverrideDvdValue] as NewDvdValue
		  ,fco.[OverrideDvdValue] - fcoe.[OverrideDvdValue] as ChangeDvdValue
		  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN np.[POSITION]*(fco.[OverrideDvdValue] - fcoe.[OverrideDvdValue])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
				ELSE np.[POSITION]*(fco.[OverrideDvdValue] - fcoe.[OverrideDvdValue])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
		   END as ChangeAmount
          ,UPPER(fco.[DIVIDEND_CCY]) as [DIVIDEND_CCY]
		  ,(SELECT MAX([DvdForecastCalcOverrideLastModifiedDatetime]) FROM [Investment].[DvdForecastCalcOverride]) as LastUpdatedDate
    FROM [Investment].[DvdForecastCalcOverride] fco
	INNER JOIN (SELECT FUND_SHORT_NAME, EDM_SEC_ID, MAX(POSITION_DATE) as MaxPositionDate
	            FROM [dbo].[T_MASTER_POS]
				WHERE [FUND_SHORT_NAME] IN ('WIMEIF','WIMIFF')
				GROUP BY FUND_SHORT_NAME, EDM_SEC_ID) mp
	ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_MASTER_SEC] ms
	ON ms.EDM_SEC_ID = fco.EDM_SEC_ID
	INNER JOIN T_MASTER_SEC_EQUITY mse
    ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
	INNER JOIN NT_POS_CTE npe
    ON npe.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_NT_POS] np
    ON npe.[EDM_SEC_ID] = np.[EDM_SEC_ID]
    AND npe.MaxTradeDate = np.TRADE_DATE
    AND np.Account=mp.[FUND_SHORT_NAME]
	LEFT OUTER JOIN FXRATE_CTE fxc
    ON (mse.DIVIDEND_CCY IS NOT NULL AND fxc.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
    OR mse.DIVIDEND_CCY IS NULL AND fxc.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
    LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
    ON fx.DATE = fxc.MaxDate
    AND fx.[TO_ISO_CURRENCY_CODE] = fxc.[TO_ISO_CURRENCY_CODE]
	INNER JOIN [Investment].[DvdForecastOverrideEvents] fcoe
	ON fcoe.[DvdForecastCalcOverrideId] = fco.[DvdForecastCalcOverrideId]
	INNER JOIN PrevOverrideRate_CTE por
	ON por.[DvdForecastCalcOverrideId] = fco.[DvdForecastCalcOverrideId]
	AND por.PrevUpdatedDate = fcoe.[DvdForecastOverrideEventLastModifiedDatetime]
    WHERE fco.[OverrideDvdValue] IS NOT NULL
	AND ((fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] >= CAST(GetDate() as date) AND fco.[OverrideExDate] <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0)))
	OR (fco.[OverrideExDate] IS NULL AND fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] >= CAST(GetDate() as date) AND fco.[EX_DATE] <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0))))
	AND fcoe.[OverrideDvdValue] != fco.[OverrideDvdValue] 
	AND IsActive=1
	
	UNION -- override but no previous override in events

	    SELECT mp.[FUND_SHORT_NAME]
          ,fco.[EDM_SEC_ID]
          ,fco.[SECURITY_NAME]
		  ,ms.[TICKER]
          ,ISNULL(fco.[OverrideExDate],fco.[EX_DATE]) as [EX_DATE]
		  ,fco.[DVD_VALUE] as PrevDvdValue
          ,fco.[OverrideDvdValue] as NewDvdValue
		  ,fco.[OverrideDvdValue] - fco.[DVD_VALUE] as ChangeDvdValue
		  ,CASE WHEN ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) = 'GBP' THEN np.[POSITION]*(fco.[OverrideDvdValue] - fco.[DVD_VALUE])/100*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
				ELSE np.[POSITION]*(fco.[OverrideDvdValue] - fco.[DVD_VALUE])/fx.[SPOT_RATE]*(1-ISNULL(ms.[WITHHOLDING_TAX],0))
		   END as ChangeAmount
          ,UPPER(fco.[DIVIDEND_CCY]) as [DIVIDEND_CCY]
		  ,(SELECT MAX([DvdForecastCalcOverrideLastModifiedDatetime]) FROM [Investment].[DvdForecastCalcOverride]) as LastUpdatedDate
    FROM [Investment].[DvdForecastCalcOverride] fco
	INNER JOIN (SELECT FUND_SHORT_NAME, EDM_SEC_ID, MAX(POSITION_DATE) as MaxPositionDate
	            FROM [dbo].[T_MASTER_POS]
				WHERE [FUND_SHORT_NAME] IN ('WIMEIF','WIMIFF')
				GROUP BY FUND_SHORT_NAME, EDM_SEC_ID) mp
	ON fco.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_MASTER_SEC] ms
	ON ms.EDM_SEC_ID = fco.EDM_SEC_ID
	INNER JOIN T_MASTER_SEC_EQUITY mse
    ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
	INNER JOIN NT_POS_CTE npe
    ON npe.[EDM_SEC_ID] = fco.[EDM_SEC_ID]
    INNER JOIN [dbo].[T_NT_POS] np
    ON npe.[EDM_SEC_ID] = np.[EDM_SEC_ID]
    AND npe.MaxTradeDate = np.TRADE_DATE
    AND np.Account=mp.[FUND_SHORT_NAME]
	LEFT OUTER JOIN FXRATE_CTE fxc
    ON (mse.DIVIDEND_CCY IS NOT NULL AND fxc.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
    OR mse.DIVIDEND_CCY IS NULL AND fxc.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
    LEFT OUTER JOIN [dbo].[T_MASTER_FXRATE] fx
    ON fx.DATE = fxc.MaxDate
    AND fx.[TO_ISO_CURRENCY_CODE] = fxc.[TO_ISO_CURRENCY_CODE]
    WHERE fco.[OverrideDvdValue] IS NOT NULL AND fco.[DVD_VALUE] IS NOT NULL
	AND ((fco.[OverrideExDate] IS NOT NULL AND fco.[OverrideExDate] >= CAST(GetDate() as date) AND fco.[OverrideExDate] <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0)))
	OR (fco.[OverrideExDate] IS NULL AND fco.[EX_DATE] IS NOT NULL AND fco.[EX_DATE] >= CAST(GetDate() as date) AND fco.[EX_DATE] <= DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GetDate())+1,0))))
	AND IsActive=1
	AND NOT EXISTS (SELECT 1
	                  FROM [Investment].[DvdForecastOverrideEvents] fcoe
					  INNER JOIN PrevOverrideRate_CTE por
					  ON por.[DvdForecastCalcOverrideId] = fcoe.[DvdForecastCalcOverrideId]
					  AND por.PrevUpdatedDate = fcoe.[DvdForecastOverrideEventLastModifiedDatetime]
					  WHERE fco.[DvdForecastCalcOverrideId] = fcoe.[DvdForecastCalcOverrideId]);
