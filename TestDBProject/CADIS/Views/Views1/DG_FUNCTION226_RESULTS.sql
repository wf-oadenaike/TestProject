﻿CREATE VIEW "CADIS"."DG_FUNCTION226_RESULTS" AS 
SELECT ET."CompanyKeyBusinessDateEventId",ET."CompanyKeyBusinessDateId",ET."FinancialYear",ET."SubmittedByPersonId",ET."EventDate",ET."DueDate",ET."ClosedDate",ET."DocumentationFolderLink",ET."JoinGUID",ET."CompanyKeyBusinessDateEventCreationDatetime",ET."CompanyKeyBusinessDateEventLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."CompanyKeyBusinessDateEvents" ET WITH (NOLOCK)