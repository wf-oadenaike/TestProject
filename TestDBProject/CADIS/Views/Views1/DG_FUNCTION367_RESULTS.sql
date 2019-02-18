﻿CREATE VIEW "CADIS"."DG_FUNCTION367_RESULTS" AS 
SELECT ET."CompanyEventId",ET."CompanyId",ET."CompanyName",ET."CompanyStage",ET."CompanyStageDescription",ET."CompanyEventTypeId",ET."CompanyEventType",ET."SubmittedByPersonId",ET."PersonsName",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."JoinGUID",ET."CompanyEventCreationDatetime",ET."CompanyEventLastModifiedDatetime" FROM "Access.ManyWho"."UnquotedCompanyEventsReadOnlyVw" ET WITH (NOLOCK)