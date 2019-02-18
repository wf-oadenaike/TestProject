
CREATE VIEW dbo.vw_UnquotedRevaluation AS
SELECT
  SA.ID AS SecurityAllocationID,
  SA.FundingID AS FUNDING_ID,
  PA1.ID AS PortfolioAllocationID,
  ISNULL(PA1.AllocationAmount, 0) AS PortfolioAllocationAmount,
  R.Revaluation_ID,
  [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS],
  PortfolioCode AS FUND_SHORT_NAME
FROM [Investment].[T_UnquotedFundingSecurityAllocations] SA
LEFT JOIN (SELECT
  ID,
  Name
FROM [Investment].[T_UnquotedSecurities]) US
  ON US.ID = SA.SecurityID
LEFT JOIN (SELECT
  AllocationAmount,
  ID,
  SecurityAllocationID,
  PortfolioID
FROM [Investment].[T_UnquotedFundingPortfolioAllocations]) PA1
  ON PA1.SecurityAllocationID = SA.ID
LEFT JOIN (SELECT
  S.ID,
  s.Name,
  s.Ticker,
  MAX([REVALUATION_ID]) AS [REVALUATION_ID],
  [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS]
FROM Investment.T_UnquotedSecurities s
LEFT JOIN T_MASTER_SEC sm
  ON sm.ticker = s.ticker
LEFT JOIN [dbo].[T_UNQUOTED_REVALUATION] r
  ON R.[EDM_SEC_ID] = SM.[EDM_SEC_ID]
GROUP BY [ACTUAL_ENACTMENT_DATE],
         [EXPECTED_ENACTMENT_DATE],
         s.Name,
         s.Ticker,
         S.ID,
         [TECH_STATUS]) R
  ON SA.SecurityID = R.ID
LEFT JOIN Investment.mandates M
  ON PA1.PortfolioID = M.MandateId


