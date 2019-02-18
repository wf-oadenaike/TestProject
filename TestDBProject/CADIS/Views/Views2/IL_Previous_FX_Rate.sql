﻿CREATE VIEW "CADIS"."IL_Previous_FX_Rate" AS 
SELECT V."STORE_DATE" AS "Store Date",V."FXRATE_ID" AS "FX Rate Id",V."DATE" AS "FX Date", J4.DF AS "From Currency", J5.DF AS "To Currency",V."SPOT_RATE" AS "FX Rate (Spot Rate)",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed By","CADIS_SYSTEM_TIMESTAMP" FROM "CADIS"."VW_Master_FX_Rate_Store_Previous_Day" V LEFT OUTER JOIN (SELECT DISTINCT "ISO_CCY_CD" AS JF,"ISO_CCY_CD" AS DF FROM "dbo"."T_REF_CURRENCY")  J4 ON  J4.JF=V."FROM_ISO_CURRENCY_CODE" LEFT OUTER JOIN (SELECT DISTINCT "ISO_CCY_CD" AS JF,"ISO_CCY_CD" AS DF FROM "dbo"."T_REF_CURRENCY")  J5 ON  J5.JF=V."TO_ISO_CURRENCY_CODE"