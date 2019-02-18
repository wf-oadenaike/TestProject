﻿CREATE VIEW "CADIS"."DG_FUNCTION636_RESULTS" AS 
SELECT ET."WatchListRegisterId",ET."Identifier",ET."WatchlistId",ET."ReasonTypeId",ET."StatusId",ET."SubmittedByPersonId",ET."ReviewedByPersonId",ET."AnticipatedRemovalDate",ET."DateSubmitted",ET."JIRAIssueKey",ET."BoxLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."Description",ET."IdentifierTypeId" FROM "dbo"."Compliance_WatchListRegister" ET WITH (NOLOCK)