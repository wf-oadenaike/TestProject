
CREATE VIEW [Access.ManyWho].[PortfolioPlacingAllocationsVw]
	AS SELECT   SHORT_NAME
	          , LONG_NAME as [PortfolioName]
			  , 0 as [AllocationAmount]
			  , 0 as [AllocationPercent]
			  , 0 as [AllocationBasisPoints]
			  , 0 as [NumberOfShares]
			  , 0 as [VotingRights]
			  , 'GBP' as [CurrencyCode]
  from [dbo].[T_MASTER_FND]
;
;
