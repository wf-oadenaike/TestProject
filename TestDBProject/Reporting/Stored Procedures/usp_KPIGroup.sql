CREATE PROCEDURE [Reporting].[usp_KPIGroup]
	@RetrievalDate datetime = NULL
AS

	Set NoCount on
	SELECT * FROM [KPI].[ufn_KPIGroups](@RetrievalDate)
