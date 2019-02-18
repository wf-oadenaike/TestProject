CREATE VIEW "CADIS"."IL_Master_Fund_Income" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."FUND_FISCAL_YEAR" AS "Fund Fiscal Year",V."UNITS_IN_ISSUE" AS "Units In Issue",V."EARNED_INCOME" AS "Income Earned",V."YET_TO_GO_XD" AS "Yet To Go XD",V."NET_INCOME" AS "Net Income" FROM "CADIS"."VW_UI_FND_INCOME" V
