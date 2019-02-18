﻿CREATE VIEW "CADIS"."DG_FUNCTION52_RESULTS" AS 
SELECT ET."MeetingNameBK",ET."MeetingRegisterId",ET."MeetingTypeId",ET."MeetingSummary",ET."MeetingOwnerRoleId",ET."AssigneeRoleId",ET."JIRAProjectKey",ET."LagDays",ET."ActiveFlag",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."MeetingRegisterCreationDatetime",ET."MeetingRegisterLastModifiedDatetime",ET."MeetingDay" FROM "Organisation"."MeetingsRegister" ET WITH (NOLOCK)
