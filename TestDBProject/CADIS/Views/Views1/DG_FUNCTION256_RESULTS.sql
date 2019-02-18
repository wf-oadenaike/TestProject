﻿CREATE VIEW "CADIS"."DG_FUNCTION256_RESULTS" AS 
SELECT ET."SignatoryReviewEventId",ET."EventId",ET."SignatoryRoleId",ET."SignatoryPersonId",ET."EventDetails",ET."EventDate",ET."EventStatus",ET."EventTrueFalse",ET."JiraTaskKey",ET."SubmittedByPersonId",ET."LastModifiedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."SignatoryReviewEventCreationDatetime",ET."SignatoryReviewEventLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "PolicyProc"."SignatoryReviewEvents" ET WITH (NOLOCK)