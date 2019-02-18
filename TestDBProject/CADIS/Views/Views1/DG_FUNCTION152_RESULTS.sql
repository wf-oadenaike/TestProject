﻿CREATE VIEW "CADIS"."DG_FUNCTION152_RESULTS" AS 
SELECT ET."ClientTakeOnCheckListId",ET."CheckListTemplateId",ET."ClientTakeOnId",ET."CheckItemTrueFalse",ET."RecordedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."ClientTakeOnCheckListCreationDatetime",ET."ClientTakeOnCheckListLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Sales"."ClientTakeOnCheckList" ET WITH (NOLOCK)