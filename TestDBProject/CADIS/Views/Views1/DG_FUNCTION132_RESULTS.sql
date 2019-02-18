﻿CREATE VIEW "CADIS"."DG_FUNCTION132_RESULTS" AS 
SELECT ET."TraderAuthorisationId",ET."TraderName",ET."TrainedByPersonId",ET."TrainedBy",ET."TrainingCompletedDate",ET."ApprovedByPersonId",ET."ApprovedBy",ET."ApprovalDate",ET."DecisionDate",ET."FCAResponseDate",ET."ReasonForRequest",ET."RequestedByPersonId",ET."RequestedBy",ET."RequiredByDate",ET."ReviewerNotes",ET."Status",ET."JiraParentKey",ET."DocumentationFolderLink",ET."JoinGUID",ET."TraderAuthorisationCreationDatetime",ET."TraderAuthorisationLastModifiedDatetime" FROM "Access.ManyWho"."TraderAuthorisationReadOnlyVw" ET WITH (NOLOCK)
