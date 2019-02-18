CREATE VIEW [Access.ManyWho].[StopListRegisterReadOnlyVw]
AS
SELECT        
	slr.StopListId, 
	slr.StoppedCompanyName,
	slr.Ticker, 
	slst.StoplistStatusName as StatusName, 
	slr.StoppedDate, 
	(select max(AnticipatedCleansedate) from [Compliance].[StopListReasonRegister] where StopListId = slr.StopListId) as AnticipatedCleansedate,	--		slr.AnticipatedCleansedate, 
	slr.JoinGUID, 
	slr.CADIS_SYSTEM_INSERTED, 
	slr.CADIS_SYSTEM_UPDATED, 
	slr.CADIS_SYSTEM_CHANGEDBY
FROM
	[Compliance].[StopListRegister] slr
			
LEFT OUTER JOIN [Compliance].[StopListStatuses] slst ON slr.StopListStatusId = slst.StopListStatusId 
