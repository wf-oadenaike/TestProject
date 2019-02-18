﻿CREATE VIEW "CADIS"."IL_Organisation_Policy_Theme_Procedures" AS 
SELECT V."PolicyThemeProcedureId" AS "Policy Theme Procedure ID",V."PolicyThemeRegisterId" AS "Policy Theme Register ID", J2.DF AS "PTP Category ID",V."PolicyThemeProcedureNameBK" AS "Policy Theme Name BK",V."ActiveFlag" AS "Active Flag",V."ActiveFromDatetime" AS "Active From Date",V."ActiveToDatetime" AS "Active To Date" FROM "Organisation"."PolicyThemeProcedures" V LEFT OUTER JOIN (SELECT DISTINCT "PTPCategoryId" AS JF,"PTPCategoryName" AS DF FROM "Organisation"."PolicyThemeProcedureCategories")  J2 ON  J2.JF=V."PTPCategoryId"
