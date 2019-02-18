
CREATE VIEW [Investment].[V_UnquotedFundings]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Schema].[ViewName]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- J bRENNAN : 19/07/2018 JIRA: DAP-2212 [Change PortfolioID from  2 TO 1 ]
--
-- 
-------------------------------------------------------------------------------------- 




SELECT  TUF.ID
      ,TUF.IssuerID
      ,TUI.KnownName As Issuer
      ,TUF.TypeID
      ,REF1.FieldValue AS [Type]
      ,TUF.SubtypeID
      ,REF2.FieldValue AS [Subtype]
      ,TUF.StatusID
      ,REF3.FieldValue AS [Status]
      ,CAST(TUF.TradeDate AS DATE) AS TradeDate
      ,CAST(TUF.SettlementDate AS DATE) AS SettlementDate
      ,TUF.IsLegalCommitment
      ,TUF.IsReputationalCommitment
      ,TUF.JiraIssueKey
      ,TUF.FlexBackUnit
      ,TUF.FlexBackMagnitude
      ,TUF.FlexForwardUnit
      ,TUF.FlexForwardMagnitude
      ,IA1.ID AS WIMEIFInitialAllocationID
      ,IA1.AllocationAmount AS WIMEIFInitialAllocationAmount
      ,IA2.ID AS WIMPCTInitialAllocationID
      ,IA2.AllocationAmount AS WIMPCTInitialAllocationAmount
      ,IA3.ID AS OMNISInitialAllocationID
      ,IA3.AllocationAmount AS OMNISInitialAllocationAmount    
      ,(IA1.AllocationAmount + IA2.AllocationAmount + IA3.AllocationAmount) AS TotalInitialAllocations
      ,TUF.FullAllocationsProvided
	  ,M.PortfolioCode
	  ,CASE WHEN TUF.FullAllocationsProvided = '0' THEN (CASE WHEN IA1.AllocationAmount IS NULL THEN '0' ELSE (IA1.AllocationAmount) END) ELSE (SELECT SUM(WIMEIFPortfolioAllocationAmount) FROM [Investment].[V_UnquotedFundingSecurityAllocations] WHERE FundingID = TUF.ID) END AS WIMEIFTotalAllocationAmount
      ,CASE WHEN TUF.FullAllocationsProvided = '0' THEN (CASE WHEN IA2.AllocationAmount IS NULL THEN '0' ELSE (IA2.AllocationAmount) END) ELSE (SELECT SUM(WIMPCTPortfolioAllocationAmount) FROM [Investment].[V_UnquotedFundingSecurityAllocations] WHERE FundingID = TUF.ID) END AS WIMPCTTotalAllocationAmount
      ,CASE WHEN TUF.FullAllocationsProvided = '0' THEN (CASE WHEN IA3.AllocationAmount IS NULL THEN '0' ELSE (IA3.AllocationAmount) END) ELSE (SELECT SUM(OMNISPortfolioAllocationAmount) FROM [Investment].[V_UnquotedFundingSecurityAllocations] WHERE FundingID = TUF.ID) END AS OMNISTotalAllocationAmount
      ,CASE WHEN TUF.FullAllocationsProvided = '0' THEN (CASE WHEN (IA1.AllocationAmount IS NULL OR IA3.AllocationAmount IS NULL OR IA2.AllocationAmount IS NULL) THEN '0' ELSE (IA1.AllocationAmount + IA2.AllocationAmount + IA3.AllocationAmount) END) ELSE (SELECT SUM(AllocationAmount) FROM [Investment].[T_UnquotedFundingPortfolioAllocations]) END AS TotalAllocations
      ,TUF.CADIS_SYSTEM_INSERTED
      ,TUF.CADIS_SYSTEM_UPDATED
      ,TUF.CADIS_SYSTEM_CHANGEDBY
 FROM [Investment].[T_UnquotedFundings] TUF
  LEFT JOIN (SELECT ID, KnownName FROM [Investment].[T_UnquotedIssuers]) TUI ON TUI.ID = TUF.IssuerID
  LEFT JOIN (SELECT ID, FieldValue FROM [Investment].[T_ReferenceData]) REF1 ON REF1.ID = TUF.TypeID
  LEFT JOIN (SELECT ID, FieldValue FROM [Investment].[T_ReferenceData]) REF2 ON REF2.ID = TUF.SubtypeID
  LEFT JOIN (SELECT ID, FieldValue FROM [Investment].[T_ReferenceData]) REF3 ON REF3.ID = TUF.StatusID
  LEFT JOIN (SELECT ID, FundingID, PortfolioID, AllocationAmount FROM [Investment].[T_UnquotedFundingInitialAllocations] WHERE PortfolioID = 8) IA1 ON IA1.FundingID = TUF.ID
  LEFT JOIN (SELECT ID, FundingID, PortfolioID, AllocationAmount FROM [Investment].[T_UnquotedFundingInitialAllocations] WHERE PortfolioID = 9) IA2 ON IA2.FundingID = TUF.ID
  LEFT JOIN (SELECT ID, FundingID, PortfolioID, AllocationAmount FROM [Investment].[T_UnquotedFundingInitialAllocations] WHERE PortfolioID = 1) IA3 ON IA3.FundingID = TUF.ID
  LEFT JOIN Investment.mandates M ON IA1.PortfolioID = M.MandateId and IA2.PortfolioID = M.MandateId and  IA3.PortfolioID = M.MandateId
  







