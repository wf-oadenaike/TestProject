
CREATE FUNCTION [Access.WebDev].[ufn_RegulatoryLimits] 
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_RegulatoryLimits]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- DAP-2431:  Olu Removed RUK_005 from the fucntion
--
-- 
-------------------------------------------------------------------------------------- 

(
	@ReportDate DATE = NULL
)
RETURNS @Output TABLE (
		[ReportDate] [datetime] NULL,
		[FundCode] [varchar](20) NULL,
		[RuleId] [varchar] (50) NULL,
		[RuleName] [varchar](50) NULL,
		[RuleLimit] [varchar](50) NULL,
		[Value] [decimal] (19,5) NULL
		
)

AS
BEGIN

IF @ReportDate IS NULL
	SET @ReportDate = (SELECT ISNULL(MAX (CAST(cast(Report_date as varchar(8)) as date)),GetDate()) FROM [Investment].[RegulatoryRuleSummary]);

insert into @Output ([ReportDate],[FundCode],[RuleId],[RuleName],[RuleLimit],[Value])
Select distinct cast(cast(Report_date as varchar(8)) as date) as Report_date, FundCode, RuleID,Rulename,RuleLimit,
cast(replace(replace(a.Value,'%',''),',','') as decimal(19,5))
/
 1.0 as Value from [Investment].[RegulatoryRuleSummary] a
LEFT JOIN [Access.WebDev].[ufn_GetAUMs] (@ReportDate) ga
on ga.FUND_SHORT_NAME = FundCode
where -- FundCode <>'ALL_LIVE' and 
cast(cast(Report_date as varchar(8)) as date)=@ReportDate
						  
	  
  RETURN
   
END
