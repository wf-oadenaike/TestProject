CREATE FUNCTION [Access.WebDev].[ufn_CashLadderSummaryFundTotalRec]
(
    @TDate	DATE
)
RETURNS TABLE
AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_CashLadderSummaryFundTotalRec]
-- 
-- Params:	@TDate DATE - Trade date for which the function is to be run for.
-------------------------------------------------------------------------------------- 
-- History:
-- R.Dixon: 15/02/2018 JIRA: DAP-1648 - Created
-------------------------------------------------------------------------------------- 

RETURN (
		SELECT	BB.[Fund], 
				BB.[AsOfDate], 
				BB.[TMinus1] - NT.[TMinus1] AS [TMinus1], 
				BB.[T] - NT.[T] AS [T], 
				BB.[Tplus1] - NT.[Tplus1] AS [Tplus1],
				BB.[Tplus2] - NT.[Tplus2] AS [Tplus2], 
				BB.[Tplus3] - NT.[Tplus3] AS [Tplus3], 
				BB.[Tplus4] - NT.[Tplus4] AS [Tplus4], 
				BB.[Tplus5] - NT.[Tplus5] AS [Tplus5] 
		FROM	[Access.WebDev].[ufn_CashLadderSummaryFundTotal](@TDate) BB
		INNER	JOIN [Access.WebDev].[ufn_NTCashLadderSummaryFundTotal](@TDate) NT
		ON		BB.[Fund] = NT.[Fund]
		AND		BB.[Asofdate] = NT.[Asofdate]
		)

