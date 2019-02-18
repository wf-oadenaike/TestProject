﻿CREATE VIEW "CADIS"."DG_FUNCTION317_RESULTS" AS 
SELECT ET."CommentaryId",ET."CommentaryDate",ET."WEIFCOD",ET."BenchMarkCOD",ET."WPCTCOD",ET."WIMIFFCOD",ET."WIMIFFBenchmarkCOD",ET."SharePriceClose",ET."NAVClose",ET."Commentary",ET."SubmittedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CommentaryType",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Investment"."MarketCommentary" ET WITH (NOLOCK)
