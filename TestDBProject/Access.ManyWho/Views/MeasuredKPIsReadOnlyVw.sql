
CREATE VIEW  [Access.ManyWho].[MeasuredKPIsReadOnlyVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[MeasuredKPIsReadOnlyVw]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- OLU: Added FundShortName
--
-- 
-------------------------------------------------------------------------------------- 

-- View logic goes here

 SELECT mk.KPIId 
		, mk.KPIName
		, mk.KPINameAlias
		, mk.fund_short_name
		, mk.KPIDescription
		, mk.KPIBK 
		, mk.GreenThresholdValue 
		, mk.AmberThresholdValue 
		, mk.RedThresholdValue 
		, mk.TargetValue 
		, mk
.Operator
		, mk.IsPercentage 
		, mk.IsActive 
		, mk.RefreshFrequencyId
		, rf.FrequencyName
		, mk.AggrFunction
		, mk.OwnerRoleId
		, r.RoleName
		, mmde.DataEntryPersonId
		, p.PersonsName as DataEntryName
		, mmde.JiraProjectKey
		, mmde.JiraEpicKey

		, mmde.DataEntryFrequencyId
		, def.FrequencyName as DataEntryFrequency
		, (SELECT DATEADD(DAY, CASE (DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST) % 7 
                        WHEN 1 THEN -2 
                        WHEN 2 THEN -3 
                    
    ELSE -1 
                    END, DATEDIFF(DAY, 0, GETDATE()))) as DummyDate
		, ISNULL(mmde.DefaultValue,0) as DummyValue
        , mmde.Notes
        , (	SELECT	TOP 1 kf.MeasureValue 
			FROM	[Fact].[KPIFact] kf 
			WHERE	kf.KPIId = mk.KPIId 
			AND		kf.LastUpdatedDatetime =	(SELECT	MAX(kf1.LastUpdatedDatetime) 
												FROM	[Fact].[KPIFact] kf1 
												WHERE	kf1.KPIId = mk.KPIId)) AS PreviousMeasureValue
	    , ( SELECT	MAX(kf.LastUpdatedDatetime)
			FROM	[Fact].[KPIFact] kf 
			WHERE	kf.KPIId = mk.KPIId) AS LastUpdatedDatetime
FROM	[KPI].[MeasuredKPIs] mk
INNER	JOIN Core.Roles r
ON		mk.OwnerRoleId = r.RoleId
INNER	JOIN KPI.RefreshFrequency rf
ON		mk.RefreshFrequencyId = rf.RefreshFrequencyId
INNER	JOIN [KPI].[MeasuredKPIManualDataEntry] mmde
ON		mk.KPIId = mmde.KPIId
AND		mmde.[IsActive] = 1
INNER	JOIN [Core].[Persons] p
ON		mmde.DataEntryPersonId = p.PersonId
LEFT	OUTER JOIN KPI.RefreshFrequency def
ON		mmde.DataEntryFrequencyId = def.RefreshFrequencyId
WHERE	mmde.[IsActive] = 1


