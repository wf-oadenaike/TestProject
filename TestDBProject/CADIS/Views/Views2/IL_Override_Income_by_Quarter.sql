CREATE VIEW "CADIS"."IL_Override_Income_by_Quarter" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."EDM_SEC_ID" AS "EDM_SEC_ID",V."FUND_FISCAL_YEAR" AS "Fund Fiscal Year",V."FUND_FISCAL_QUARTER" AS "Fund Fiscal Quarter",V."EX_DATE" AS "Dividend Ex Date",V."RATE" AS "Rate",V."NOTES" AS "Notes" FROM "dbo"."T_OVERRIDE_INCOME" V
