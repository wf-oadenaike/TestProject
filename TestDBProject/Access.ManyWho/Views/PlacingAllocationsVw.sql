
CREATE VIEW [Access.ManyWho].[PlacingAllocationsVw]
	AS SELECT pa.PlacingAllocationId
	        , pa.PlacingRegisterId
			, pa.PortfolioCode
	        , pa.PortfolioName
            , pa.AllocationAmount
	        , pa.AllocationPercent
	        , pa.AllocationDescription
	        , pa.AllocationBasisPoints
			, pa.CurrencyCode
			, pa.NumberOfShares
	        , pa.JoinGUID
	        , pa.PlacingAllocationCreationDatetime
	        , pa.PlacingAllocationLastModifiedDatetime
	FROM [Operation].[PlacingAllocations] pa
;
