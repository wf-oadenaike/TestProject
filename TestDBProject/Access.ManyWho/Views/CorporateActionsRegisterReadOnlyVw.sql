
CREATE VIEW [Access.ManyWho].[CorporateActionsRegisterReadOnlyVw]
	AS
SELECT CAR.[CorporateActionsRegisterId]
      ,CAR.[OperationsSalesforceId]
      ,CAR.[SecurityNameBK]
      ,CAR.[OperationRoleId]
      ,Operation.RoleName AS OperationRoleName
      ,CAR.[RecorderNameId]
      ,Recorder.PersonsName AS RecorderName
      ,CAR.[FiledDate]
      ,CAR.[ISIN]
      ,CAR.[CorporateActionDate]
      ,CAR.[RecordDate]	  
      ,CAR.[DeadlineDate]
      ,CAR.[InvestmentRoleId]
      ,Investment.RoleName AS InvestmentRoleName
      ,CAR.[FundManagerSalesforceId]
      ,CAR.[DecisionMakerId]
      ,Decider.PersonsName AS DecisionMakerName
      ,CAR.[Decision]
	  ,CAR.[OperationsNotes]
	  ,CAR.[InvestmentNotes]
	  ,CAR.[NTReportDocumentationLink]
	  ,CAR.[Status]
	  ,CAR.[EventType]
      ,CAR.[DocumentationFolderLink]
      ,CAR.[WorkflowVersionGUID]
      ,CAR.[JoinGUID]
      ,CAR.[CADIS_SYSTEM_INSERTED]
      ,CAR.[CADIS_SYSTEM_UPDATED]
  FROM [Operation].[CorporateActionsRegister] CAR
  LEFT OUTER JOIN CORE.Persons Recorder
	ON Recorder.PersonId = CAR.RecorderNameId
  LEFT OUTER JOIN CORE.Persons Decider
	ON Decider.PersonId = CAR.DecisionMakerId
  LEFT OUTER JOIN CORE.Roles Operation
	ON Operation.RoleId = CAR.OperationRoleId
  LEFT OUTER JOIN CORE.Roles Investment
    	ON Investment.RoleId = CAR.InvestmentRoleId;

