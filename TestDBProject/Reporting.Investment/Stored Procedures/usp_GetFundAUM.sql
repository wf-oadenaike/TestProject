CREATE PROCEDURE [Reporting.Investment].[usp_GetFundAUM]
	@ReportDate DATE = NULL
AS
	SET NOCOUNT ON
	SELECT * FROM [Reporting.Investment].ufn_GetAUMs(@ReportDate)
