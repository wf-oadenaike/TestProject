CREATE VIEW "CADIS"."IL_Sales_Force_Postcode_Owner" AS 
SELECT V."POST_CODE" AS "Post Code", J3.DF AS "Owner" FROM "dbo"."T_REF_SALES_FORCE_POST_CODE_OWNER" V LEFT OUTER JOIN (SELECT DISTINCT "FullEmployeeBK" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J3 ON  J3.JF=V."FullEmployeeBK"
