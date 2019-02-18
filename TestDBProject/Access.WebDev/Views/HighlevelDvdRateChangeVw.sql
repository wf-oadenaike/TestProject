CREATE VIEW [Access.WebDev].[HighlevelDvdRateChangeVw]
	AS 
	SELECT YEAR(getdate()) as CalendarYear
	     , chlo.PrevDvdRate
	     , chlo.DvdRate
		 , chlo.DvdRate - chlo.PrevDvdRate as Change
		 , chlo.Target
		 , chlo.Target - chlo.DvdRate as Shortfall
		 ,(SELECT MAX([DvdNTCalcHighLevelOverrideLastModifiedDatetime]) FROM [Investment].[DvdNTCalcHighLevelOverride]) as LastUpdatedDate
	FROM (SELECT SUM(hlo.DvdRate) as DvdRate, SUM(hlo.PrevDvdRate) as PrevDvdRate, 
	             (SELECT ISNULL(SUM(DvdRate),4.144) FROM [Investment].[DvdNTCalcHighLevelOverride] WHERE SUBSTRING(CAST(YEAR(getdate())-1 as VARCHAR),3,2) = substring(Qtr,4,2)) as Target
		  FROM [Investment].[DvdNTCalcHighLevelOverride] hlo
		  WHERE SUBSTRING(CAST(YEAR(getdate()) as VARCHAR),3,2) = substring(hlo.Qtr,4,2)) chlo;
