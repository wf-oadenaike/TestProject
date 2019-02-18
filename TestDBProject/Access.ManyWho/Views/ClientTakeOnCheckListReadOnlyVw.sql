CREATE VIEW [Access.ManyWho].[ClientTakeOnCheckListReadOnlyVw]
	AS 
SELECT
	   ctocl.ClientTakeOnCheckListId
	 , ctocl.CheckListTemplateId
	 , ctoclt.CheckListItemName
	 , ctoclt.EventType
	 , ctocl.ClientTakeOnId
	 , ctr.ClientTakeOnName
	 , CASE ctocl.CheckItemTrueFalse WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE NULL END as CheckItemTrueFalse
	 , ctocl.RecordedByPersonId
	 , rp.PersonsName as SubmittedBy
	 , ctocl.DocumentationFolderLink
     , ctocl.JoinGUID
     , ctocl.ClientTakeOnCheckListCreationDatetime
     , ctocl.ClientTakeOnCheckListLastModifiedDatetime
  FROM  [Sales].[ClientTakeOnCheckList] ctocl
  INNER JOIN [Sales].[ClientTakeOnCheckListTemplate] ctoclt
  ON ctocl.CheckListTemplateId = ctoclt.CheckListTemplateId
  INNER JOIN [Sales].[ClientTakeOnRegister] ctr
  ON ctr.ClientTakeOnId = ctocl.ClientTakeOnId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON ctocl.RecordedByPersonId = rp.PersonId
  ;
