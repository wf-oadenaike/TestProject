
CREATE VIEW  [Reporting].[vw_FundAUM]

AS


select * from [Access.WebDev].ufn_GetAUMs(null)
