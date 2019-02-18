﻿CREATE VIEW "CADIS"."DG_FUNCTION54_RESULTS" AS 
SELECT ET."MonitoringCategoryId",ET."MonitoringType",ET."CategoryName",ET."MonitoringFrequency",ET."FrequencyMonths",ET."FrequencyStartMonth",ET."DueDateOffSet",ET."DocumentationURL",ET."SubmittedByPersonId",ET."JoinGUID",ET."MonitoringCategoryCreationDate",ET."MonitoringCategoryLastModifiedDate" FROM "Access.ManyWho"."ComplianceMonitoringCategoriesVw" ET WITH (NOLOCK)