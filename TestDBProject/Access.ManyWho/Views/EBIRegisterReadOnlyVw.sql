CREATE VIEW [Access.ManyWho].[EBIRegisterReadOnlyVw]
AS
SELECT ebir.EBIRegisterId
, ebir.EBIExternalReference
, ebir.DateIdentified
, ebir.ReportedByPersonId
, rep.PersonsName as ReportedBy
, rep.EmployeeBK as ReportedSalesforceUserId
, ebir.RecordedByPersonId
, rp.PersonsName as RecordedBy
, rp.EmployeeBK as RecordedSalesforceUserId
, ebir.EBITypeCode
, ebir.EBIBreachTypeId
, ebt.EBIBreachName
, ebir.EBIImpactTypeId
, eit.EBIImpactName
, ebir.EBICategorisationId
, ec.EBICategorisationName
, ebir.EBISummary
, ebir.EBIStartDate
, ebir.EBIEndDate
, ebir.EBIClosureDate
, ebir.EBIResolvedYesNo
, ebir.RemedyAction
, ebir.MitigationSteps
, ebir.IncidentReportFinalizationDate
, ebir.ExternalNotificationRequiredYesNo
, ebir.ExternalNotificationDetails
, ebir.ExternalBodyId
, exb.EBIExternalBodyDescription
, ebir.NotifiedDepartmentHeadId
, nr.RoleName as NotifiedDepartmentHead
, ebir.ReimbursementRequiredYesNo
, ebir.ReimbursementAmount
, ebir.ReimbursementComments
, ebir.ReimbursementDate
, ebir.SentBackYesNo
, ebir.DisputedPendingLitigationYesNo
, ebir.InvestmentRelatedYesNo
, ebir.ActiveInvestmentBreachYesNo
, ebir.DataProtectionRelatedYesNo
, ebir.RegulatoryRelatedYesNo
, ebir.ReportableYesNo
, ebir.ServiceIssueID
, ebir.ServiceProviderName
, ebir.ClientsNotifiedYesNo
, ebir.Status
, ebir.JIRAIssueKey
, ebir.WorkflowVersionGUID
, ebir.JoinGUID
, ebir.EBIRegisterCreationDatetime
, ebir.EBIRegisterLastModifiedDatetime
, ebir.RiskSubcategoryID 
, rsc.SubCategory as RiskSubcategoryName
, rc.CategoryID
, rc.Category as RiskCategoryName
FROM [Compliance].[EBIRegister] ebir
INNER JOIN Core.Persons rp
ON (ebir.RecordedByPersonId = rp.PersonId)
INNER JOIN Core.Persons rep
ON (ebir.ReportedByPersonId = rep.PersonId)
LEFT OUTER JOIN [Compliance].[EBIBreachTypes] ebt
ON (ebir.EBIBreachTypeId = ebt.EBIBreachTypeId)
LEFT OUTER JOIN [Compliance].[EBIImpactTypes] eit
ON (ebir.EBIImpactTypeId = eit.EBIImpactTypeId)
LEFT OUTER JOIN [Compliance].[EBIExternalBodies] exb
ON (ebir.ExternalBodyId = exb.[EBIExternalBodyId])
LEFT OUTER JOIN [Compliance].[EBICategorisations] ec
ON (ebir.EBICategorisationId = ec.EBICategorisationId)
LEFT OUTER JOIN [Core].[Roles] nr
ON (ebir.NotifiedDepartmentHeadId = nr.RoleId)
LEFT OUTER JOIN [Risk].[Subcategories] rsc
ON (ebir.RiskSubcategoryID = rsc.SubCategoryId)
LEFT OUTER JOIN [Risk].[Categories] rc
ON (rsc.CategoryID = rc.CategoryId)
;

