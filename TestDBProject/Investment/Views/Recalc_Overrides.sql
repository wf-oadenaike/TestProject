CREATE VIEW [Investment].[Recalc_Overrides]

-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[Recalc_Overrides]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		26/06/2017			JIRA: DAP-1150 View to present Recalc Overrides to ManyWho
-- D.Fanning:		07/08/2017			JIRA: DAP 1260 Amended DvdValue to reflect overrides
-- D.Bacchus		14/08/2017			JIRA: DAP-1284 Optimised performance 
-------------------------------------------------------------------------------------- 

AS

SELECT
	ROW_NUMBER() OVER(ORDER BY [EDM_SEC_ID] ASC) AS ROW_UNIQUE_ID 
	,DVD_Overrides_ID
	,DVD_Fund_Overrides_ID
	,[EDM_SEC_ID]
	,SecurityName 
	,FundShortName
	,ExDate
	,DvdValue_ExDate
	,Quantity_ExDate
	,Quantity_LastDate
	,Position_LastDate
	,Quantity_FirstDate
	,Position_FirstDate
	,Quantity_DvdCalc
	,GrossDvdValue
	,NetDvdValue
	,SpecialCumTrades
	,WithholdingTax
	,DvdCCY
	,Qtr
	,Yr
	,SpotRate
	,Ticker
	,HasOverride
FROM
(
SELECT
	--ROW_NUMBER() OVER(ORDER BY DVD.[EDM_SEC_ID] ASC) AS ROW_UNIQUE_ID 
	dVD_O.DVD_Overrides_ID
	,DVD_FUND_O.DVD_Fund_Overrides_ID
	,DVD.[EDM_SEC_ID]
	,DVD.SecurityName 
	,DVD.FundShortName
	,DVD.ExDate
	,ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) AS DvdValue_ExDate
	,DVD.Quantity_ExDate
	,DVD.Quantity_LastDate
	,DVD.Position_LastDate
	,DVD.Quantity_FirstDate
	,DVD.Position_FirstDate

	,DVD.Quantity_DvdCalc

	,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
	ELSE
		DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate
	END) AS GrossDvdValue

	,
	(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
	ELSE
		(DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
	END) as NetDvdValue
	

	,(CASE WHEN DVD_FUND_O.[BBG_EX_DATE] IS NULL THEN DVD.SpecialCumTrades
	ELSE
		(DVD_FUND_O.[OVERRIDE_QUANTITY] * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
	END) as SpecialCumTrades


	,DVD.WithholdingTax
	,DVD.DvdCCY
	,DVD.Qtr
	,DVD.Yr
	,DVD.SpotRate
	,DVD.Ticker
	--,1 as IsActive

	,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NOT NULL OR DVD_FUND_O.[BBG_EX_DATE] IS NOT NULL THEN 1 ELSE 0 END) as HasOverride

FROM 
	[Investment].[ufn_BBG_DVDs]() DVD
LEFT OUTER JOIN
	Investment.DVD_Overrides DVD_O	ON DVD_O.EDM_SEC_ID = DVD.EDM_SEC_ID
							AND DVD_O.[BBG_EX_DATE] = DVD.ExDate
							AND DVD_O.IsActive = 1
LEFT OUTER JOIN
	Investment.DVD_Fund_Overrides DVD_FUND_O	ON DVD_FUND_O.EDM_SEC_ID = DVD.EDM_SEC_ID
									AND DVD_FUND_O.[FUND_SHORT_NAME] = DVD.FundShortName
									AND DVD_FUND_O.[BBG_EX_DATE] = DVD.ExDate
									AND DVD_FUND_O.IsActive = 1
WHERE
	DVD.Position_LastDate = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])

UNION

SELECT
	--ROW_NUMBER() OVER(ORDER BY DVD.[EDM_SEC_ID] ASC) AS ROW_UNIQUE_ID 
	DVD_O.DVD_Overrides_ID
	,DVD_FUND_O.DVD_Fund_Overrides_ID
	,DVD.[EDM_SEC_ID]
	,DVD.SecurityName 
	,DVD.FundShortName
	,DVD.ExDate
	,ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) AS DvdValue_ExDate
	,DVD.Quantity_ExDate
	,DVD.Quantity_LastDate
	,DVD.Position_LastDate
	,DVD.Quantity_FirstDate
	,DVD.Position_FirstDate

	,DVD.Quantity_DvdCalc

	,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
	ELSE
		DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate
	END) AS GrossDvdValue

	,
	(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
	ELSE
		(DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
	END) as NetDvdValue
	

	,(CASE WHEN DVD_FUND_O.[BBG_EX_DATE] IS NULL THEN DVD.SpecialCumTrades
	ELSE
		(DVD_FUND_O.[OVERRIDE_QUANTITY] * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
	END) as SpecialCumTrades


	,DVD.WithholdingTax
	,DVD.DvdCCY
	,DVD.Qtr
	,DVD.Yr
	,DVD.SpotRate
	,DVD.Ticker
	--,1 as IsActive

	,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NOT NULL OR DVD_FUND_O.[BBG_EX_DATE] IS NOT NULL THEN 1 ELSE 0 END) as HasOverride

FROM 
	[Investment].[ufn_BBG_DVDs]() DVD
LEFT OUTER JOIN
	Investment.DVD_Overrides DVD_O	ON DVD_O.EDM_SEC_ID = DVD.EDM_SEC_ID
							AND DVD_O.[BBG_EX_DATE] = DVD.ExDate
							AND DVD_O.IsActive = 1
LEFT OUTER JOIN
	Investment.DVD_Fund_Overrides DVD_FUND_O	ON DVD_FUND_O.EDM_SEC_ID = DVD.EDM_SEC_ID
									AND DVD_FUND_O.[FUND_SHORT_NAME] = DVD.FundShortName
									AND DVD_FUND_O.[BBG_EX_DATE] = DVD.ExDate
									AND DVD_FUND_O.IsActive = 1
WHERE
	DVD.Position_LastDate <> (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])
	AND DVD.ExDate <= DVD.Position_LastDate
) D

order by ROW_UNIQUE_ID

OFFSET 0 ROWS 


