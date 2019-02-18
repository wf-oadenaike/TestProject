CREATE VIEW [Access.ManyWho].[ProjectMeasureUnitsVw]
	AS SELECT pmu.MeasureUnitBK
			, pmu.MeasureDescription
			, pmu.DaysEquivalent
		FROM [Organisation].[ProjectMeasureUnits] pmu
		;
