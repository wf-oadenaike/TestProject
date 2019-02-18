CREATE VIEW [Access.WebDev].[NewProjectsRegisterReadOnlyVw]
	AS 
SELECT
	   npr.ProjectId
	 , npr.ProjectName
	 , npr.RequestorPersonId
	 , rp.PersonsName as ProjectRequestor
	 , npr.OwnerPersonId
	 , op.PersonsName as ProjectOwner 
	 , npr.OversightPersonId
	 , ovp.PersonsName as ProjectOverseer	
     , npr.DepartmentId
     , d.DepartmentName	 
	 , npr.ProposedStartDate
	 , npr.EstimatedDuration
	 , npr.EstimatedCost
	 , npr.TechnologyInvolvedYesNo
	 , npr.NewResourcesYesNo
	 , npr.NewTechnology
	 , npr.AdditionalDetails
	 , npr.ProjectStatus
	 , npr.ProjectType
	 , npr.ProjectPurpose
	 , npr.ProjectScope
	 , npr.Dependences
	 , npr.ExternalResources
	 , npr.CreateNewEpic
	 , npr.IsClientTakeOn
	 , npr.JiraEpicKey
	 , npr.DueDate
      ,[RAGStatus]
      ,[ActualStartDate]
      ,[ActualEndDate]
      ,[NewResourceNumber]
      ,[NewResourceCost]
      ,[ITResourceYesNo]
      ,[ITResourceNumber]
      ,[ITResourceCost]
      ,[OtherCostYesNo]
      ,[OtherCost]
      ,[Rescoped]
      ,[InternalAudit]
      ,[ExternalComms]
      ,[ProjectBillingCode]
	  ,[NewResourceDetails]
	  ,[ITResourceDetails]
	  ,[NewTechnologyCost]
	  ,[PreviousProjectId]
	  ,[LegalCostYesNo]
	  ,[LegalCosts]
	  ,[LegalCostDetails] 
	 , npr.DocumentationFolderLink
	 , npr.NewProjectsRegisterCreationDatetime
	 , npr.NewProjectsRegisterLastModifiedDatetime	  
	  ,[CADIS_SYSTEM_INSERTED]
	  ,[CADIS_SYSTEM_UPDATED]
	  ,[CADIS_SYSTEM_CHANGEDBY]
	  ,[CADIS_SYSTEM_PRIORITY]
	  ,[CADIS_SYSTEM_TIMESTAMP]
	  ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Organisation].[NewProjectsRegister] npr
  INNER JOIN [Core].[Persons] rp
  ON npr.RequestorPersonId = rp.PersonId
  LEFT OUTER JOIN [Core].[Persons] op
  ON npr.OwnerPersonId = op.PersonId
  LEFT OUTER JOIN [Core].[Persons] ovp
  ON npr.OversightPersonId = ovp.PersonId
  LEFT OUTER JOIN [Core].[Departments] d
  ON npr.DepartmentId = d.DepartmentId
