﻿CREATE VIEW "CADIS"."DG_FUNCTION399_RESULTS" AS 
SELECT ET."BCPTestPlanRegisterId",ET."TestPlanOwnerPersonId",ET."TestPlanOwner",ET."DepartmentId",ET."DepartmentName",ET."TestRequirement",ET."TestSuccessCriteria",ET."TestStartTime",ET."TestEndTime",ET."TestStatus",ET."RecordedByPersonId",ET."RecordedBy",ET."IsActive",ET."DocumentationFolderLink",ET."JoinGUID",ET."BCPTestPlanRegisterCreationDatetime",ET."BCPTestPlanRegisterLastModifiedDatetime" FROM "Access.ManyWho"."BCPTestPlanRegisterReadOnlyVw" ET WITH (NOLOCK)
