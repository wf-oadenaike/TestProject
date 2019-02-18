CREATE VIEW "CADIS"."DG_FUNCTION151_RESULTS" AS 
SELECT ET."CheckListTemplateId",ET."CheckListItemName",ET."EventType",ET."CheckListTemplateCreationDatetime" FROM "Sales"."ClientTakeOnCheckListTemplate" ET WITH (NOLOCK)
