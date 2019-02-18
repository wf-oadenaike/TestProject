create view [Access.ManyWho].[ClientPricingApprovalReadOnlyVw]
as
SELECT [ClientPricingApprovalId]
      ,[MyApprovalsId]
      ,[ClientName]
      ,[InvestmentType]
      ,[InitialInvestment]
      ,[PotentialInvestment]
      ,[TimelineForPotentialInvestment]
      ,[ShareclassOffering]
      ,[RebateOffering]
      ,[SegregatedFeeProposalDetails]
      ,y.PersonsName as 'Submitted By'
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Sales].[ClientPricingApproval] x
		inner join core.persons y
			on x.submittedbypersonid = y.PersonId
