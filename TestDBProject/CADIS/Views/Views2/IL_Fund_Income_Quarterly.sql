CREATE VIEW "CADIS"."IL_Fund_Income_Quarterly" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."FUND_FISCAL_YEAR" AS "Fund FIscal Year",V."FUND_FISCAL_QUARTER" AS "Fund Fiscal Quarter",V."UNITS_IN_ISSUE" AS "Units In Issue",V."EARNED_INCOME" AS "Income Earned",V."YET_TO_GO_XD" AS "Yet To Go XD",V."NET_INCOME" AS "Net Income",V."P.P.U" AS "P.P.U" FROM "CADIS"."VW_UI_FND_INCOME_QUARTERLY" V
