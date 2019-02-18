﻿CREATE VIEW "CADIS"."DG_FUNCTION248_RESULTS" AS 
SELECT ET."PolicyId",ET."PolicyName",ET."Version",ET."Status",ET."SummaryDescription",ET."ReviewFrequencyId",ET."LastReviewDate",ET."NextReviewDate",ET."IsActive",ET."ModifiedByPersonId",ET."DocumentCategoryId",ET."DocumentationFolderLink",ET."JoinGUID",ET."PolicyRegisterCreationDatetime",ET."PolicyRegisterLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "PolicyProc"."PolicyRegister" ET WITH (NOLOCK)
