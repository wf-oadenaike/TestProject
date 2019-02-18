﻿CREATE VIEW "CADIS"."DG_FUNCTION227_RESULTS" AS 
SELECT ET."CompanyKeyBusinessDateId",ET."BusinessActivity",ET."BusinessActivityTypeId",ET."FinancialYearReference",ET."ReporterRoleId",ET."AssigneeRoleId",ET."DocumentationFolderLink",ET."JoinGUID",ET."CompanyKeyBusinessDateRegisterCreationDatetime",ET."CompanyKeyBusinessDateRegisterLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."CompanyKeyBusinessDateRegister" ET WITH (NOLOCK)