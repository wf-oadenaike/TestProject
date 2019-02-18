CREATE PROCEDURE [Compliance].[usp_MergeMonitoringRecordNotes]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Compliance.usp_MergeMonitoringThemeNotes
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			10/02/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on
	
	Declare	@strProcedureName		VARCHAR(100)	= '[Compliance].[usp_MergeMonitoringRecordNotes]';
	
	DECLARE @NotesRst TABLE 
			( RstAction varchar(15), MonitoringRecordNoteId int);
			
BEGIN TRANSACTION

	-- merge into the business tables for each monitoring category
	
	-- insert monitoring notes for Conflicts of Interest
	MERGE INTO [Compliance].[ConflictsRegisterActions] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ConflictId, crat.[ActionTypeId] as ActionTypeId, [SubmittedDate] as ActionDate, mn.[EventDetailsNote] as ActionComment, ISNULL(mn.[SubmittedByPersonId],-1) as [CreatedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Conflicts of Interest'
			CROSS JOIN [Compliance].[ConflictsRegisterActionTypes] crat
			WHERE mn.EventDetailsNote IS NOT NULL
			AND crat.[ActionType] = 'Monitoring Event details'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ConflictId, crat.[ActionTypeId] as ActionTypeId, [SubmittedDate] as ActionDate, mn.[ComplianceConcernsNote] as ActionComment, ISNULL(mn.[SubmittedByPersonId],-1) as [CreatedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Conflicts of Interest'
			CROSS JOIN [Compliance].[ConflictsRegisterActionTypes] crat
			WHERE mn.ComplianceConcernsNote IS NOT NULL
			AND crat.[ActionType] = 'Monitoring Compliance Concerns'			
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ConflictId, crat.[ActionTypeId] as ActionTypeId, [SubmittedDate] as ActionDate, mn.[FirstLineResponseNote] as ActionComment, ISNULL(mn.[SubmittedByPersonId],-1) as [CreatedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Conflicts of Interest'
			CROSS JOIN [Compliance].[ConflictsRegisterActionTypes] crat
			WHERE mn.FirstLineResponseNote IS NOT NULL
			AND crat.[ActionType] = 'Monitoring First Line Response'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ConflictId, crat.[ActionTypeId] as ActionTypeId, [SubmittedDate] as ActionDate, mn.[GovernanceNote] as ActionComment, ISNULL(mn.[SubmittedByPersonId],-1) as [CreatedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Conflicts of Interest'
			CROSS JOIN [Compliance].[ConflictsRegisterActionTypes] crat
			WHERE mn.GovernanceNote IS NOT NULL
			AND crat.[ActionType] = 'Monitoring Governance'	

			) as Src
	ON ( Tar.ConflictId = Src.ConflictId
	  AND Tar.ActionTypeId = Src.ActionTypeId
	  AND Tar.ActionDate = Src.ActionDate )
	  --AND Tar.ActionComment = Src.ActionComment )
	WHEN NOT MATCHED
		THEN INSERT (ConflictId, ActionTypeId, ActionDate, ActionComment, CreatedByPersonId, CreationDate)
			 VALUES (Src.ConflictId, Src.ActionTypeId, Src.ActionDate, Src.ActionComment, Src.CreatedByPersonId, Src.ActionDate)
	WHEN MATCHED AND Tar.ActionComment != Src.ActionComment 
		THEN UPDATE SET ActionComment = Src.ActionComment
		              , CreatedByPersonId = Src.CreatedByPersonId
	;
	
	--OUTPUT $ACTION, Src.MonitoringRecordNoteId 
	--INTO @NotesRst( RstAction, MonitoringRecordNoteId );
	
	-- insert monitoring notes for Gifts+Entertainment

	MERGE INTO [Compliance].[GiftEntertainmentExpenseEvents] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ExpenseId, geeet.[ExpenseEventTypeId] as ExpenseEventTypeId, [SubmittedDate] as EventDate, mn.[EventDetailsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Gifts and Entertainment'
			CROSS JOIN [Compliance].[GiftEntertainmentExpenseEventTypes] geeet
			WHERE mn.EventDetailsNote IS NOT NULL
			AND geeet.[ExpenseEventType] = 'Compliance Monitoring Event details Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ExpenseId, geeet.[ExpenseEventTypeId] as ExpenseEventTypeId, [SubmittedDate] as EventDate, mn.[ComplianceConcernsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Gifts and Entertainment'
			CROSS JOIN [Compliance].[GiftEntertainmentExpenseEventTypes] geeet
			WHERE mn.ComplianceConcernsNote IS NOT NULL
			AND geeet.[ExpenseEventType] = 'Compliance Monitoring Compliance Concerns Note'			
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ExpenseId, geeet.[ExpenseEventTypeId] as ExpenseEventTypeId, [SubmittedDate] as EventDate, mn.[FirstLineResponseNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Gifts and Entertainment'
			CROSS JOIN [Compliance].[GiftEntertainmentExpenseEventTypes] geeet
			WHERE mn.FirstLineResponseNote IS NOT NULL
			AND geeet.[ExpenseEventType] = 'Compliance Monitoring First Line Response Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ExpenseId, geeet.[ExpenseEventTypeId] as ExpenseEventTypeId, [SubmittedDate] as EventDate, mn.[GovernanceNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Gifts and Entertainment'
			CROSS JOIN [Compliance].[GiftEntertainmentExpenseEventTypes] geeet
			WHERE mn.GovernanceNote IS NOT NULL
			AND geeet.[ExpenseEventType] = 'Compliance Monitoring Governance Note'	

			) as Src
	ON ( Tar.ExpenseId = Src.ExpenseId
	  AND Tar.ExpenseEventTypeId = Src.ExpenseEventTypeId
	  AND Tar.EventDate = Src.EventDate )
	  --AND Tar.ActionComment = Src.ActionComment )
	WHEN NOT MATCHED
		THEN INSERT (ExpenseId, ExpenseEventTypeId, EventDate, EventDetails, RecordedByPersonId, JoinGUID, ExpenseEventCreationDate)
			 VALUES (Src.ExpenseId, Src.ExpenseEventTypeId, Src.EventDate, Src.EventDetails, Src.RecordedByPersonId, '00000000-0000-0000-0000-000000000000', Src.EventDate)
	WHEN MATCHED AND Tar.EventDetails != Src.EventDetails 
		THEN UPDATE SET EventDetails = Src.EventDetails
		              , RecordedByPersonId = Src.RecordedByPersonId
					  , ExpenseEventLastModifiedDate = GetDate()
	;

	-- insert monitoring notes for EBI

	MERGE INTO [Compliance].[EBIRegisterEvents] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as EBIRegisterId, eret.[EBIEventTypeId] as EBIEventTypeId, [SubmittedDate] as EventDate, mn.[EventDetailsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'EBI'
			CROSS JOIN [Compliance].[EBIRegisterEventTypes] eret
			WHERE mn.EventDetailsNote IS NOT NULL
			AND eret.[EBIEventDescription] = 'Compliance Monitoring Event details Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as EBIRegisterId, eret.[EBIEventTypeId] as EBIEventTypeId, [SubmittedDate] as EventDate, mn.[ComplianceConcernsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'EBI'
			CROSS JOIN [Compliance].[EBIRegisterEventTypes] eret
			WHERE mn.ComplianceConcernsNote IS NOT NULL
			AND eret.[EBIEventDescription] = 'Compliance Monitoring Compliance Concerns Note'			
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as EBIRegisterId, eret.[EBIEventTypeId] as EBIEventTypeId, [SubmittedDate] as EventDate, mn.[FirstLineResponseNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'EBI'
			CROSS JOIN [Compliance].[EBIRegisterEventTypes] eret
			WHERE mn.FirstLineResponseNote IS NOT NULL
			AND eret.[EBIEventDescription] = 'Compliance Monitoring First Line Response Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as EBIRegisterId, eret.[EBIEventTypeId] as EBIEventTypeId, [SubmittedDate] as EventDate, mn.[GovernanceNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'EBI'
			CROSS JOIN [Compliance].[EBIRegisterEventTypes] eret
			WHERE mn.GovernanceNote IS NOT NULL
			AND eret.[EBIEventDescription] = 'Compliance Monitoring Governance Note'		

			) as Src
	ON ( Tar.EBIRegisterId = Src.EBIRegisterId
	  AND Tar.EBIEventTypeId = Src.EBIEventTypeId
	  AND Tar.EventDate = Src.EventDate )
	WHEN NOT MATCHED
		THEN INSERT (EBIRegisterId, EBIEventTypeId, EventDate, EventDetails, RecordedByPersonId, JoinGUID, EBIEventCreationDatetime )
			 VALUES (Src.EBIRegisterId, Src.EBIEventTypeId, Src.EventDate, Src.EventDetails, Src.RecordedByPersonId, '00000000-0000-0000-0000-000000000000', Src.EventDate )
	WHEN MATCHED AND Tar.EventDetails != Src.EventDetails 
		THEN UPDATE SET EventDetails = Src.EventDetails
		              , RecordedByPersonId = Src.RecordedByPersonId
					  , EBIEventLastModifiedDatetime = GetDate()
	;

	-- insert monitoring notes for Complaints

	MERGE INTO [Compliance].[ComplaintsRegisterEvents] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ComplaintRegisterId, cet.[ComplaintEventTypeId] as ComplaintEventTypeId, [SubmittedDate] as EventDate, mn.[EventDetailsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Complaints'
			CROSS JOIN [Compliance].[ComplaintEventTypes] cet
			WHERE mn.EventDetailsNote IS NOT NULL
			AND cet.[ComplaintEventType] = 'Compliance Monitoring Event details Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ComplaintRegisterId, cet.[ComplaintEventTypeId] as ComplaintEventTypeId, [SubmittedDate] as EventDate, mn.[ComplianceConcernsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Complaints'
			CROSS JOIN [Compliance].[ComplaintEventTypes] cet
			WHERE mn.ComplianceConcernsNote IS NOT NULL
			AND cet.[ComplaintEventType] = 'Compliance Monitoring Compliance Concerns Note'			
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ComplaintRegisterId, cet.[ComplaintEventTypeId] as ComplaintEventTypeId, [SubmittedDate] as EventDate, mn.[FirstLineResponseNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Complaints'
			CROSS JOIN [Compliance].[ComplaintEventTypes] cet
			WHERE mn.FirstLineResponseNote IS NOT NULL
			AND cet.[ComplaintEventType] = 'Compliance Monitoring First Line Response Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as ComplaintRegisterId, cet.[ComplaintEventTypeId] as ComplaintEventTypeId, [SubmittedDate] as EventDate, mn.[GovernanceNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [RecordedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Complaints'
			CROSS JOIN [Compliance].[ComplaintEventTypes] cet
			WHERE mn.GovernanceNote IS NOT NULL
			AND cet.[ComplaintEventType] = 'Compliance Monitoring Governance Note'		

			) as Src
	ON ( Tar.ComplaintRegisterId = Src.ComplaintRegisterId
	  AND Tar.ComplaintEventTypeId = Src.ComplaintEventTypeId
	  AND Tar.EventDate = Src.EventDate )
	WHEN NOT MATCHED
		THEN INSERT (ComplaintRegisterId, ComplaintEventTypeId, EventDate, EventDetails, RecordedByPersonId, JoinGUID, ComplaintEventCreationDate)
			 VALUES (Src.ComplaintRegisterId, Src.ComplaintEventTypeId, Src.EventDate, Src.EventDetails, Src.RecordedByPersonId, '00000000-0000-0000-0000-000000000000', Src.EventDate)
	WHEN MATCHED AND Tar.EventDetails != Src.EventDetails 
		THEN UPDATE SET EventDetails = Src.EventDetails
		              , RecordedByPersonId = Src.RecordedByPersonId
					  , ComplaintEventLastModifiedDate = GetDate()
	;

	-- insert monitoring notes for PA Dealing
    -- wait until PADealing v2 flow because PK restricts to a single event type per Register Id currently
	
	/*
	MERGE INTO [Compliance].[PADealingRequestEvents] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as PADealingRequestRegisterId, 'Compliance Monitoring Event details Note' as PADealingRequestEventType, [SubmittedDate] as EventDate, mn.[EventDetailsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [EventPersonId], -1 as [EventRoleId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'PA Dealing'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as PADealingRequestRegisterId, 'Compliance Monitoring Compliance Concerns Note' as PADealingRequestEventType, [SubmittedDate] as EventDate, mn.[ComplianceConcernsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [EventPersonId], -1 as [EventRoleId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'PA Dealing'		
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as PADealingRequestRegisterId, 'Compliance Monitoring First Line Response Note' as PADealingRequestEventType, [SubmittedDate] as EventDate, mn.[FirstLineResponseNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [EventPersonId], -1 as [EventRoleId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'PA Dealing'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as PADealingRequestRegisterId, 'Compliance Monitoring Governance Note'	 as PADealingRequestEventType, [SubmittedDate] as EventDate, mn.[GovernanceNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [EventPersonId], -1 as [EventRoleId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'PA Dealing'	

			) as Src
	ON ( Tar.PADealingRequestRegisterId = Src.PADealingRequestRegisterId
	  AND Tar.PADealingRequestEventType = Src.PADealingRequestEventType
	  AND Tar.EventDate = Src.EventDate )
	WHEN NOT MATCHED
		THEN INSERT (PADealingRequestRegisterId, PADealingRequestEventType, EventDate, EventDetails, EventPersonId, EventRoleId, PADealingRequestEventCreationDate, WorkflowVersionGUID, JoinGUID)
			 VALUES (Src.PADealingRequestRegisterId, Src.PADealingRequestEventType, Src.EventDate, Src.EventDetails, Src.EventPersonId, Src.EventRoleId, Src.EventDate, '00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000')
	WHEN MATCHED AND Tar.EventDetails != Src.EventDetails 
		THEN UPDATE SET EventDetails = Src.EventDetails
		              , EventPersonId = Src.EventPersonId
					  , PADealingRequestEventLastModifiedDate = GetDate()
	;
	
	*/
	
	-- insert monitoring notes for StopList	

	MERGE INTO [Compliance].[StopListEvents] Tar
	USING (SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as StopListId, slet.StopListEventTypeId, [SubmittedDate] as EventDate, mn.[EventDetailsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [SubmittedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Market Abuse'
			AND mc.[CategoryName] = 'Stop list analysis'
			CROSS JOIN [Compliance].[StopListEventTypes] slet
			WHERE mn.EventDetailsNote IS NOT NULL
			AND slet.[StopListEventType] = 'Compliance Monitoring Event details Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as StopListId, slet.StopListEventTypeId, [SubmittedDate] as EventDate, mn.[ComplianceConcernsNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [SubmittedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Market Abuse'
			AND mc.[CategoryName] = 'Stop list analysis'
			CROSS JOIN [Compliance].[StopListEventTypes] slet
			WHERE mn.ComplianceConcernsNote IS NOT NULL
			AND slet.[StopListEventType] = 'Compliance Monitoring Compliance Concerns Note'	
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as StopListId, slet.StopListEventTypeId, [SubmittedDate] as EventDate, mn.[FirstLineResponseNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [SubmittedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Market Abuse'
			AND mc.[CategoryName] = 'Stop list analysis'
			CROSS JOIN [Compliance].[StopListEventTypes] slet
			WHERE mn.FirstLineResponseNote IS NOT NULL
			AND slet.[StopListEventType] = 'Compliance Monitoring First Line Response Note'
			UNION ALL
           SELECT mn.[MonitoringRecordNoteId], mn.[RecordId] as StopListId, slet.StopListEventTypeId, [SubmittedDate] as EventDate, mn.[GovernanceNote] as EventDetails, ISNULL(mn.[SubmittedByPersonId],-1) as [SubmittedByPersonId]
			FROM [Compliance].[MonitoringRecordNotes] mn
			INNER JOIN [Compliance].[MonitoringThemes] mt
			ON mn.MonitoringThemeId = mt.MonitoringThemeId
			INNER JOIN [Compliance].[MonitoringCategories] mc
			ON mt.MonitoringCategoryId = mc.MonitoringCategoryId
			AND mc.[MonitoringType] = 'Market Abuse'
			AND mc.[CategoryName] = 'Stop list analysis'
			CROSS JOIN [Compliance].[StopListEventTypes] slet
			WHERE mn.GovernanceNote IS NOT NULL
			AND slet.[StopListEventType] = 'Compliance Monitoring Governance Note'

			) as Src
	ON ( Tar.StopListId = Src.StopListId
	  AND Tar.StopListEventTypeId = Src.StopListEventTypeId
	  AND Tar.EventDate = Src.EventDate )
	WHEN NOT MATCHED
		THEN INSERT (StopListId, StopListEventTypeId, EventDate, EventDetails, SubmittedByPersonId, StopListEventCreationDatetime, JoinGUID)
			 VALUES (Src.StopListId, Src.StopListEventTypeId, Src.EventDate, Src.EventDetails, Src.SubmittedByPersonId, Src.EventDate, '00000000-0000-0000-0000-000000000000')
	WHEN MATCHED AND Tar.EventDetails != Src.EventDetails 
		THEN UPDATE SET EventDetails = Src.EventDetails
		              , SubmittedByPersonId = Src.SubmittedByPersonId
					  , StopListEventLastModifiedDatetime = GetDate()
	;	
	
	-- now update processed flag to indicate processed notes record
	/*
	UPDATE mn
	SET mn.[IsProcessed]=1
	FROM [Compliance].[MonitoringRecordNotes] mn
	INNER JOIN @NotesRst nr
	ON mn.MonitoringRecordNoteId = nr.MonitoringRecordNoteId
	WHERE mn.IsProcessed =0
	AND nr.RstAction = 'INSERT';
    */
	
	COMMIT TRANSACTION;
	
END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		
		IF @@TRANCOUNT > 0 ROLLBACK;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );

END CATCH
