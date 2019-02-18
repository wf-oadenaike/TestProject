CREATE VIEW [Compliance].[EBIExtractReadOnlyVw]
	AS
	
	SELECT 	
		Register.EBIRegisterId
		, Register.EBIExternalReference
		, Register.DateIdentified
		, Reported.PersonsName as ReportedBy
		, Recorded.PersonsName as RecorderByPerson
		, Register.EBITypeCode
		, BreachTypes.EBIBreachName
		, ImpactTypes.EBIImpactName
		, Categori.EBICategorisationName
		, Register.EBISummary
		, Register.EBIStartDate
		, Register.EBIEndDate
		, Register.EBIClosureDate
		, Register.RemedyAction
		, Register.MitigationSteps
		, Register.IncidentReportFinalizationDate
		, CASE WHEN Register.ExternalNotificationRequiredYesNo =1 THEN 'Yes'
				ELSE 'No'
				END AS ExternalNotificationRequired
		, Register.ExternalNotificationDetails
		, exb.EBIExternalBodyDescription
		, NotifyRoles.RoleName as NotifiedDepartmentHead
		, CASE WHEN Register.ReimbursementRequiredYesNo =1 THEN 'Yes'
				ELSE 'No'
				END AS ReimbursementRequired
		, Register.ReimbursementAmount
		, Register.ReimbursementComments
		, Register.ReimbursementDate
		, EBIEvents.EventDetails
		, EBIEvents.EventDate
		,EventTypes.EBIEventTypeBK
		, EBIEvents.DocumentationFolderLink
		, CASE WHEN Register.EBIResolvedYesNo =1 THEN 'Yes'
				ELSE 'No'
				END AS EBIResolvedYesNo
		, CASE WHEN Register.SentBackYesNo =1 THEN 'Yes'
				ELSE 'No'
				END AS SentBackYesNo
        , CASE WHEN Register.[DisputedPendingLitigationYesNo]=1 THEN 'Yes'
				ELSE 'No'
				END AS DisputedPendingLitigationYesNo
		, CASE WHEN Register.[InvestmentRelatedYesNo]=1 THEN 'Yes'
				ELSE 'No'
				END AS InvestmentRelatedYesNo 
		, CASE WHEN Register.[RegulatoryRelatedYesNo]=1 THEN 'Yes'
				ELSE 'No'
				END AS RegulatoryRelatedYesNoYesNo				
		, CASE WHEN Register.[ReportableYesNo]=1 THEN 'Yes'
				ELSE 'No'
				END AS ReportableYesNo		
		,Register.EBIRegisterCreationDatetime
		,Register.EBIRegisterLastModifiedDatetime
	FROM [Compliance].[EBIRegister] Register
	INNER JOIN Core.Persons Recorded
		ON (Register.RecordedByPersonId = Recorded.PersonId)
	INNER JOIN Core.Persons Reported
		ON (Register.ReportedByPersonId = Reported.PersonId)
	LEFT OUTER JOIN [Compliance].[EBIBreachTypes] BreachTypes
		ON (Register.EBIBreachTypeId = BreachTypes.EBIBreachTypeId)
	LEFT OUTER JOIN [Compliance].[EBIImpactTypes] ImpactTypes
		ON (Register.EBIImpactTypeId = ImpactTypes.EBIImpactTypeId)
	LEFT OUTER JOIN [Compliance].[EBIExternalBodies] exb
		ON (Register.ExternalBodyId = exb.[EBIExternalBodyId])
	LEFT OUTER JOIN [Compliance].[EBICategorisations] Categori
		ON (Register.EBICategorisationId = Categori.EBICategorisationId)
	LEFT OUTER JOIN [Core].[Roles] NotifyRoles
		ON Register.NotifiedDepartmentHeadId = NotifyRoles.RoleId
	LEFT OUTER JOIN [Compliance].[EBIRegisterEvents] EBIEvents
		ON EBIEvents.EBIRegisterId=Register.EBIRegisterId
	LEFT OUTER JOIN [Compliance].[EBIRegisterEventTypes] EventTypes
		ON EBIEvents.EBIEventTypeId = EventTypes.EBIEventTypeId
	;
