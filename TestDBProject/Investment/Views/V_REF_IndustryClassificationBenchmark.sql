CREATE VIEW [Investment].[V_REF_IndustryClassificationBenchmark] AS
	SELECT
		Sub.ID AS SubsectorID
		,Ind.Name AS Industry
		,Sup.Name AS Supersector
		,Sec.Name AS Sector
		,Sub.Name AS Subsector
		,Sub.[Description] AS SubsectorDescription
		,FM.PersonsName AS FundManagerName
		,FM.PersonID AS FundManagerPersonID
		,IA.Personsname AS InvestmentAnalystName
		,IA.PersonID AS InvestmentAnalystPersonID
	FROM Investment.T_REF_ICBSubsectors Sub
		LEFT JOIN Investment.T_REF_ICBSectors Sec ON Sub.SectorID = Sec.ID
		LEFT JOIN Investment.T_REF_ICBSupersectors Sup ON Sec.SupersectorID = Sup.ID
		LEFT JOIN Investment.T_REF_ICBIndustries Ind ON Sup.IndustryID = Ind.ID
		LEFT JOIN Core.Persons FM ON Ind.FundManagerID = FM.PersonID
		LEFT JOIN Core.Persons IA ON Ind.InvestmentAnalystID = IA.PersonID
	WHERE Sub.Active = 1

