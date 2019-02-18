﻿CREATE VIEW "CADIS"."DG_FUNCTION700_RESULTS" AS 
SELECT ET."HuddleControlLogRelationshipId",ET."HuddleEventId",ET."EventName",ET."DocumentName",ET."ProcedureId",ET."ProcedureName",ET."CategoryId",ET."Category",ET."SubCategoryId",ET."SubCategory",ET."ControlLogRegisterId",ET."ControlDescription",ET."ControlType",ET."ControlFrequency" FROM "Access.WebDev"."HuddleControlLogRelationshipReadOnlyVw" ET WITH (NOLOCK)