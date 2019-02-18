﻿CREATE VIEW "CADIS"."DG_FUNCTION65_RESULTS" AS 
SELECT ET."GUID",ET."COMPONENTID",ET."IDENTIFIER",ET."NAME",ET."CODE",ET."OBSOLETE",ET."INSERTED",ET."UPDATED",ET."CHANGEDBY",ET."DEFINITION",ET."CRC",ET."Info1",ET."Info2",ET."ENABLED",ET."TIMECODE",ET."COMPONENT_NAME" FROM "CADIS"."VW_ManyWho_DataGeneratorInbox" ET WITH (NOLOCK)