﻿CREATE VIEW "CADIS"."DG_FUNCTION100_RESULTS" AS 
SELECT ET."MonitoringCategoryId",ET."MonitoringType",ET."CategoryName",ET."MonitoringFrequency",ET."FrequencyMonths",ET."FrequencyStartMonth",ET."DueDateOffSet",ET."DocumentationURL",ET."SubmittedByPersonId",ET."JoinGUID",ET."MonitoringCategoryCreationDate",ET."MonitoringCategoryLastModifiedDate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Compliance"."MonitoringCategories" ET WITH (NOLOCK)