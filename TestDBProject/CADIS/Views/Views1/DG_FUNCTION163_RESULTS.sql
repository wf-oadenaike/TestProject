CREATE VIEW "CADIS"."DG_FUNCTION163_RESULTS" AS 
SELECT ET."CheckListTemplateId",ET."CheckListItemName",ET."CheckListTemplateCreationDatetime",ET."EventType" FROM "Access.ManyWho"."ClientTakeOnCheckListTemplateReadOnlyVw" ET WITH (NOLOCK)
