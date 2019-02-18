﻿CREATE VIEW "CADIS"."DG_FUNCTION235_RESULTS" AS 
SELECT ET."PADealingEventId",ET."PADealingRegisterId",ET."PADealingEventTypeId",ET."PADealingEventType",ET."SubmittedByPersonId",ET."PersonsName",ET."EventTrueFalse",ET."EventDetails",ET."EventDate",ET."DocumentationFolderLink",ET."JoinGUID",ET."JiraIssueKey",ET."PADealingEventCreationDatetime",ET."PADealingEventLastModifiedDatetime" FROM "Access.ManyWho"."PADealingEventsReadOnlyVw" ET WITH (NOLOCK)
