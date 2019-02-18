﻿CREATE VIEW "CADIS"."DG_FUNCTION639_RESULTS" AS 
SELECT ET."WatchListRegisterId",ET."Description",ET."Identifier",ET."IdentifierTypeName",ET."IdentifierTypeId",ET."WatchlistCode",ET."WatchlistId",ET."Status",ET."StatusId",ET."ReasonName",ET."ReasonTypeId",ET."SubmittedBy",ET."SubmittedByPersonId",ET."ReviewedBy",ET."ReviewedByPersonId",ET."AnticipatedRemovalDate",ET."DateSubmitted",ET."JIRAIssueKey",ET."BoxLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."WatchListRegisterVw" ET WITH (NOLOCK)