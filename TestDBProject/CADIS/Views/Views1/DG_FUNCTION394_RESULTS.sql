﻿CREATE VIEW "CADIS"."DG_FUNCTION394_RESULTS" AS 
SELECT ET."BCPTestPlanRegisterId",ET."DepartmentId",ET."TestRequirement",ET."TestSuccessCriteria",ET."TestStartTime",ET."TestEndTime",ET."TestStatus",ET."RecordedByPersonId",ET."IsActive",ET."TestPlanOwnerPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."BCPTestPlanRegisterCreationDatetime",ET."BCPTestPlanRegisterLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "BAU"."BCPTestPlanRegister" ET WITH (NOLOCK)