


Create view [Unquoted].[InvestmentCompaniesVw]  
As  
  
SELECT IC.CompanyId,   
  IC.SFID,  
  IC.StatusId,  
  ST.StatusCode,
  IC.CompanyName,  
  IC.ReferrerName,  
  IC.StageId,  
  IC.ReferrerContactId,  
  IC.SystemStatusId,  
  IC.InvestmentAnalystPersonId,  
  P1.PersonsName as InvestmentAnalystPersonName,  
  IC.InvestmentOwnerPersonId,  
  P2.PersonsName as InvestmentOwnerPersonName,  
  IC.BoxDocumentLocation,  
  IC.CADIS_SYSTEM_INSERTED,  
  IC.CADIS_SYSTEM_UPDATED,  
  IC.CADIS_SYSTEM_CHANGEDBY  
FROM	[Unquoted].[InvestmentCompanies] IC  
LEFT	OUTER JOIN [Core].[Persons] P1  
ON		IC.InvestmentAnalystPersonId = P1.PersonId
LEFT	OUTER JOIN [Core].[Persons] P2  
ON		IC.InvestmentOwnerPersonId = P2.PersonId  
LEFT	OUTER JOIN [Unquoted].[Status] ST
ON		ST.StatusId = IC.StatusId

