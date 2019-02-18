﻿CREATE VIEW "CADIS"."DG_FUNCTION515_RESULTS" AS 
SELECT ET."VisitorAccessID",ET."VisitorAccessEventID",ET."Version",ET."IsActive",ET."ChangeStatusName",ET."EventTitle",ET."EventDetails",ET."Comments",ET."VisitorCompany",ET."VisitorName",ET."EventStartDateTime",ET."EventEndDateTime",ET."LastModifiedDateTime",ET."Approver",ET."Supervisor",ET."SubmittedBy",ET."VisitorAccessRegisterCreationDateTime",ET."JIRAIssueKey",ET."SupervisorJIRAIssueKey",ET."CommentsBy" FROM "Access.ManyWho"."VisitorAccessRegisterVw" ET WITH (NOLOCK)