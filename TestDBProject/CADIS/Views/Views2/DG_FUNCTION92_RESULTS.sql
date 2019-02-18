﻿CREATE VIEW "CADIS"."DG_FUNCTION92_RESULTS" AS 
SELECT ET."RFPEventId",ET."RFPId",ET."RFPName",ET."EventTypeId",ET."RFPEventType",ET."SubmittedByPersonId",ET."ReviewedById",ET."SubmittedBy",ET."ReviewedByName",ET."EventDetails",ET."EventDate",ET."ReviewComments",ET."EventTrueFalse",ET."DepartmentId",ET."DepartmentName",ET."JiraSubTaskKey",ET."DocumentationFolderLink",ET."JoinGUID",ET."RFPEventCreationDate",ET."RFPEventLastModifiedDatetime" FROM "Access.ManyWho"."RFPEventsReadOnlyVw" ET WITH (NOLOCK)