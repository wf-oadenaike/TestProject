﻿CREATE VIEW "CADIS"."DG_FUNCTION71_RESULTS" AS 
SELECT ET."ClientId",ET."ClientName",ET."RelationshipManagerId",ET."AccountSalesforceId",ET."PrimaryContactName",ET."ContactSalesforceId",ET."IsActive",ET."RecordedByPersonId",ET."BillingFrequency",ET."FrequencyStartMonth",ET."ReconciliationEmailAddress",ET."DocumentationFolderLink",ET."JoinGUID",ET."ClientRegisterCreationDatetime",ET."ClientRegisterLastModifiedDatetime",ET."BoxFolderID" FROM "Sales"."ClientRegister" ET WITH (NOLOCK)
