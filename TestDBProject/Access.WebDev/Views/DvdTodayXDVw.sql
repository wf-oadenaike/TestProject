CREATE VIEW [Access.WebDev].[DvdTodayXDVw]
	AS 
    SELECT mp.[FUND_SHORT_NAME]
          ,fco.[EDM_SEC_ID]
          ,fco.[SECURITY_NAME]
		  ,ms.[TICKER]
          ,ISNULL(fco.[OverrideExDate],fco.[EX_DATE]) as [EX_DATE]
          ,ISNULL(fco.[OverrideDvdValue],fco.[DVD_VALUE]) AS [DVD_VALUE]
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
    WHERE (
	([OverrideExDate] IS NOT NULL AND [OverrideExDate] = CAST(GetDate() as date))
	OR ([OverrideExDate] IS NULL AND EX_DATE = CAST(GetDate() as date))
	)
	AND IsActive=1;
