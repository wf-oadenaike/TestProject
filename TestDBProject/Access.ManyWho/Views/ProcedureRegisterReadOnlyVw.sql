CREATE VIEW [Access.ManyWho].[ProcedureRegisterReadOnlyVw]
	AS 
	SELECT pr.ProcedureId
		 , pr.ProcedureName
		 , pr.Version
		 , pr.Status
		 , pr.SummaryDescription
		 , pd.ProcDocumentId
		 , pd.DocumentName
		 , pr.IsActive
		 , pr.ModifiedByPersonId
		 , mp.PersonsName as ModifiedByPerson
		 , pr.DocumentationFolderLink
		 , pr.JoinGUID
		 , pr.ProcedureRegisterCreationDatetime
		 , pr.ProcedureRegisterLastModifiedDatetime
	FROM [PolicyProc].[ProcedureRegister] pr
	LEFT OUTER JOIN  [PolicyProc].[ProceduresDocument] pd
	ON pr.ProcDocumentId = pd.ProcDocumentId
	LEFT OUTER JOIN [Core].[Persons] mp
	ON pr.ModifiedByPersonId = mp.PersonId
;
