
CREATE FUNCTION [Access.WebDev].[ufn_RegulatoryDetails]
(
	@ReportDate DATE = NULL
)
RETURNS @Output TABLE (
		[Effective_date] [datetime] NULL,
		[FundCode] [varchar](20) NULL,
		[RuleId] [varchar] (50) NULL,
		[Ticker] [varchar](50) NULL,
		[Identifier] [varchar](50) NULL,
		[Quantity][decimal] (19,5) NULL,
		[Price][decimal] (19,5) NULL,
		[MarketValue][decimal] (19,5) NULL,
		[InViolation][Varchar](5) NULL,
		[Weighting] [decimal] (19,5) NULL
		
)

AS
BEGIN

IF @ReportDate IS NULL
	SET @ReportDate = (SELECT ISNULL(MAX (CAST(cast(Report_date as varchar(8)) as date)),GetDate()) FROM [Investment].[RegulatoryRuleDetail]);


Insert into @Output (
		[Effective_date],
		[FundCode],
		[RuleId] ,
		[Ticker],
		[Identifier],
		[Quantity],
		[Price],
		[MarketValue],
		[InViolation],
		[Weighting])
select cast(cast(EFFECTIVE_DATE as varchar(8)) as date) as EFFECTIVE_DATE,Fundcode,Ruleid,Ticker,Identifier,Quantity,Price,MarketValue, Inviolation,
(MarketValue/Value) *100
as Weighting
from  [Investment].[RegulatoryRuledetail] D
join  [Access.WebDev].[ufn_GetAUMs] (@ReportDate) 
on Fundcode=FUND_SHORT_NAME
where cast(cast(EFFECTIVE_DATE as varchar(8)) as date) =@ReportDate
						  
	  
  RETURN
   
END


