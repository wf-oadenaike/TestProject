CREATE VIEW [Access.ManyWho].[ClientTakeOnCheckListTemplateReadOnlyVw]
	AS 
SELECT
	   ctoclt.CheckListTemplateId
	 , ctoclt.CheckListItemName
	 , ctoclt.CheckListTemplateCreationDatetime
	 , ctoclt.EventType
  FROM [Sales].[ClientTakeOnCheckListTemplate] ctoclt

  ;
