CREATE VIEW "CADIS"."IL_Premaster_Account_Balance" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."POSITION_DATE" AS "Position Date",V."ASSET_SUB_CATEGORY" AS "Asset Sub Category",V."CCY" AS "Currency",V."LOCAL_VALUE" AS "Local Value",V."BASE_VALUE" AS "Base Value" FROM "dbo"."T_PREMASTER_POS_ACCOUNT_BALANCE" V
