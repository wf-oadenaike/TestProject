CREATE VIEW [Access.ManyWho].[DvdProjectedChangesVw]
-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].DvdProjectedChangesVw
-- 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 07/11/2017 JIRA: DAP-1416 [Returns changes in projected Dividend data between latest data set and previous day's]
-- D.Fanning: 04/12/2017 JIRA: DAP-1583 [New column to indicate new dividend flag]
-- 
-------------------------------------------------------------------------------------- 
AS
WITH AS_AT AS
(
SELECT AS_AT_DATE, ROW_NUMBER() OVER (ORDER BY AS_AT_DATE DESC) AS ROWNUMBER 
FROM   
              (SELECT       AS_AT_DATE 
              FROM   [dbo].[T_BPS_DVD_PROJECT_AUDIT]
              GROUP  BY AS_AT_DATE
              ) ASAT
)
SELECT	TOP 100000 DV2.AS_AT_DATE AS PREVIOUS_DATE, 
		DV1.AS_AT_DATE AS LATEST_DATE, 
		SEC.EDM_SEC_ID,
		DV1.EX_DATE AS LATEST_EX_DATE, 
		DV2.DVD_VALUE AS PREVIOUS_DVD_VALUE, 
		DV1.DVD_VALUE AS LATEST_DVD_VALUE,
		NewDividend = 
		Case 
			when DV2.DVD_VALUE is NULL then 1 
			else 0
		End,
		ROW_NUMBER() OVER(ORDER BY SEC.EDM_SEC_ID ASC) AS ROW_UNIQUE_ID
FROM 
		(
		SELECT BPS.AS_AT_DATE, BPS.STOCK, BPS.EX_DATE, BPS.DECLARED_DATE, BPS.ISIN, SUM(BPS.DVD_VALUE) AS DVD_VALUE -- , BPS.ROW_ID
		FROM   [dbo].[T_BPS_DVD_PROJECT_AUDIT] BPS
		INNER  JOIN AS_AT A2
		ON            A2.AS_AT_DATE = BPS.AS_AT_DATE
		AND           A2.ROWNUMBER = 1
		GROUP BY BPS.AS_AT_DATE, BPS.STOCK, BPS.EX_DATE, BPS.DECLARED_DATE, BPS.ISIN
		) DV1
LEFT	OUTER JOIN 
		(
		SELECT BPS.AS_AT_DATE, BPS.STOCK, BPS.EX_DATE, BPS.DECLARED_DATE, SUM(BPS.DVD_VALUE) AS DVD_VALUE -- , BPS.ROW_ID
		FROM   [dbo].[T_BPS_DVD_PROJECT_AUDIT] BPS
		INNER  JOIN AS_AT A2
		ON            A2.AS_AT_DATE = BPS.AS_AT_DATE
		AND           A2.ROWNUMBER = 2
		GROUP BY BPS.AS_AT_DATE, BPS.STOCK, BPS.EX_DATE, BPS.DECLARED_DATE
		) DV2
ON      DV2.STOCK = DV1.STOCK
AND     DV2.EX_DATE = DV1.EX_DATE
LEFT	OUTER JOIN [dbo].[T_MASTER_SEC] SEC
ON		SEC.ISIN = DV1.ISIN
WHERE	ISNULL(DV1.DVD_VALUE,0) <> ISNULL(DV2.DVD_VALUE,0)
ORDER	BY SEC.EDM_SEC_ID ASC, DV1.EX_DATE ASC

