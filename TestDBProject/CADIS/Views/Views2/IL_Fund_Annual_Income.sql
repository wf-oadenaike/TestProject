CREATE VIEW "CADIS"."IL_Fund_Annual_Income" AS 
SELECT V."VALUATION_DATE" AS "Valuation Date",V."FUND_SHORT_NAME" AS "Fund Short Name",V."FUND_FISCAL_YEAR" AS "Fund Fiscal Year",V."UNITS_IN_ISSUE" AS "Units In Issue",V."EARNED_INCOME" AS "Income Earned",V."YET_TO_GO_XD" AS "Yet To Go XD",V."NET_INCOME" AS "Net Income",V."P.P.U" AS "P.P.U" FROM "CADIS"."VW_UI_FND_ANNUAL_INCOME" V
