﻿

CREATE VIEW dbo.vw_UnquotedFundings AS
SELECT  TUF.ID  AS Funding_ID
      ,CAST(TUF.TradeDate AS DATE) AS TradeDate
      ,IA1.AllocationAmount AS ALLOCATION
	  ,PortfolioCode as FUND_SHORT_NAME
      ,TUF.CADIS_SYSTEM_INSERTED
      ,TUF.CADIS_SYSTEM_UPDATED
      ,TUF.CADIS_SYSTEM_CHANGEDBY
 FROM [Investment].[T_UnquotedFundings] TUF
 LEFT JOIN (SELECT ID, KnownName FROM [Investment].[T_UnquotedIssuers]) TUI ON TUI.ID = TUF.IssuerID
 LEFT JOIN (SELECT ID, FundingID, PortfolioID, AllocationAmount FROM [Investment].[T_UnquotedFundingInitialAllocations] ) IA1 ON IA1.FundingID = TUF.ID
 LEFT JOIN  Investment.mandates M ON IA1.PortfolioID = M.MandateId
  
  





