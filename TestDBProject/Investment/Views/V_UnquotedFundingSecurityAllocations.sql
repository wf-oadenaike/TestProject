CREATE VIEW [Investment].[V_UnquotedFundingSecurityAllocations] AS
SELECT SA.ID AS SecurityAllocationID
	  ,SA.FundingID
	  ,UF.IssuerID
	  ,UI.KnownName AS Issuer
	  ,SA.SecurityID
	  ,US.Name AS [Security]
	  ,PA1.ID AS WIMEIFPortfolioAllocationID
	  ,PA1.AllocationAmount AS WIMEIFPortfolioAllocationAmount
	  ,PA2.ID AS WIMPCTPortfolioAllocationID
	  ,PA2.AllocationAmount AS WIMPCTPortfolioAllocationAmount
	  ,PA3.ID AS OMNISPortfolioAllocationID
	  ,PA3.AllocationAmount AS OMNISPortfolioAllocationAmount
FROM  [Investment].[T_UnquotedFundingSecurityAllocations] SA
	LEFT JOIN (SELECT ID, Name FROM [Investment].[T_UnquotedSecurities]) US ON US.ID = SA.SecurityID
	LEFT JOIN (SELECT ID, IssuerID FROM [Investment].[T_UnquotedFundings]) UF ON UF.ID = SA.FundingID
	LEFT JOIN (SELECT ID, KnownName FROM [Investment].[T_UnquotedIssuers]) UI ON UI.ID = UF.IssuerID
    LEFT JOIN (SELECT AllocationAmount, ID, SecurityAllocationID, PortfolioID FROM [Investment].[T_UnquotedFundingPortfolioAllocations] WHERE PortfolioID = 8) PA1 ON PA1.SecurityAllocationID = SA.ID
    LEFT JOIN (SELECT AllocationAmount, ID, SecurityAllocationID, PortfolioID FROM [Investment].[T_UnquotedFundingPortfolioAllocations] WHERE PortfolioID = 9) PA2 ON PA2.SecurityAllocationID = SA.ID
    LEFT JOIN (SELECT AllocationAmount, ID, SecurityAllocationID, PortfolioID FROM [Investment].[T_UnquotedFundingPortfolioAllocations] WHERE PortfolioID = 1) PA3 ON PA3.SecurityAllocationID = SA.ID






