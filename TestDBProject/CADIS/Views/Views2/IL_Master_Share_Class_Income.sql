CREATE VIEW "CADIS"."IL_Master_Share_Class_Income" AS 
SELECT V."VALUATION_DATE" AS "Valuation Date",V."FUND_SHORT_NAME" AS "Fund Short Name",V."SHARECLASS" AS "Share Class Name",V."UNITS_IN_ISSUE" AS "Units In Issue",V."FUND_VALUE" AS "Net Assets" FROM "CADIS"."VW_UI_SHARECLASS_INCOME" V
