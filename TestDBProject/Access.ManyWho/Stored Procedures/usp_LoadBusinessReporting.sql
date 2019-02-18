create proc [Access.ManyWho].[usp_LoadBusinessReporting] (@NumRowsToProcess int = null)
as
begin

	-- declare the number of rows to process in a single batch
	declare @Now datetime
	declare @RowCount int
	declare @TotalRowCount int

	set @RowCount = 0
	set @TotalRowCount = 0

while (select count(*) FROM [Staging.ManyWho].[ManyWhoValues]) > 0
begin


	IF OBJECT_ID('tempdb.dbo.#RowsToProcess', 'U') IS NOT NULL
	  DROP TABLE #RowsToProcess


	-- Create the temp table with the appropriate structure
	select * INTO #RowsToProcess FROM [Staging.ManyWho].[ManyWhoValues] where 1=2

	-- Prepare the rows for this batch.
	if @NumRowsToProcess is null
		-- If no parameter passed then do all the rows in the table in a single batch
		INSERT INTO #RowsToProcess
		SELECT StateId, Elementid, [key], value, CreatedDate
		FROM [Staging.ManyWho].[ManyWhoValues]
		order by CreatedDate asc
	else
		-- Parameter has been passed so do all the rows in the table in multiple batches
		-- where each batch is the number of rows passed as the parameter
		INSERT INTO #RowsToProcess
		SELECT TOP (@NumRowsToProcess) StateId, Elementid, [key], value, CreatedDate
		FROM [Staging.ManyWho].[ManyWhoValues]
		order by CreatedDate asc

	set @RowCount = @@rowcount

	begin tran

		begin try

			-- First update the lookups with new elements in this batch
			set @now = getdate();
			insert into [Access.ManyWho].[DimBusinessReportingElements] (ElementId,ElementName,Created)
			select distinct mws.elementid, isnull(mws.elementname,''),@now
			from [Staging.ManyWho].[ManyWhoStates] mws join #RowsToProcess rtp
					on mws.ElementId = rtp.ElementId
			where rtp.ElementId not in
			(select distinct elementid from [Access.ManyWho].[DimBusinessReportingElements])


			-- Update the lookups with new flows in this batch
			set @now = getdate();
			insert into [Access.ManyWho].[DimBusinessReportingFlows] (FlowId, FlowName, Created)
			select distinct mws.FlowId, isnull(mws.FlowName,''),@now
			from [Staging.ManyWho].[ManyWhoStates] mws join #RowsToProcess rtp
					on mws.ElementId = rtp.ElementId
			where mws.FlowId not in
			(select distinct FlowId from [Access.ManyWho].[DimBusinessReportingFlows])


			-- Load the business reporting fact table
			set @now = getdate();
			with DuplicateKeyValuePairs_CTE
			as
			(
				SELECT StateId, Elementid, [key], value, CreatedDate, DENSE_RANK() over(partition by [key],value order by createddate asc) as Instance
				  FROM #RowsToProcess
					where 1=1
			--			and StateId = '0AA1D5FB-D664-4C6E-BACA-BA23349E676E'
						and ((not [key] like '%List:%') and (isnull(Value,'') <> ''))
			)
			insert into [Access.ManyWho].[FactBusinessReporting]
				([UserId],[FlowId],[StateId],[ElementId],[CalendarId],[Time],[Key],[Value],[Iscompleted],Created)
				select distinct y.Email,y.FlowId,x.StateId,x.ElementId, z.CalendarId, cast(x.createddate as time(3)) , x.[Key], x.Value, y.IsCompleted ,@now
				from  DuplicateKeyValuePairs_CTE x
						inner join [Staging.ManyWho].[ManyWhoStates] y
							on x.StateId = y.stateid and x.elementId = y.ElementId
						inner join [core].calendar z
							on year(x.createddate) = z.CalYear and month(x.createddate) = z.CalMonth and day(x.CreatedDate) = z.caldayofmonth
				where Instance = 1
				-- order by x.CreatedDate asc


			-- Populate the events table with JIRA notifications
			set @now = getdate();
			with RowsProcessed_CTE1(StateId,[ElementId],[key],[Value],CreatedDate) as
				( SELECT TOP (@RowCount) StateId,[ElementId],[Key],Value,CreatedDate FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			insert [Access.ManyWho].[EventBusinessReporting]
			select distinct 'JIRA Notification','JIRA Notification Value: ' + [Value], a.CreatedDate, a.StateId, a.ElementId, null, @now
				from RowsProcessed_CTE1 a
				where a.[key] like 'Jira Issue.key%'


			-- Populate the events table with Slack notifications
			set @now = getdate();
			with RowsProcessed_CTE1(StateId,[ElementId],[key],[Value],CreatedDate) as
				( SELECT TOP (@RowCount) StateId,[ElementId],[Key],Value,CreatedDate FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			insert [Access.ManyWho].[EventBusinessReporting]
			select distinct 'Slack Notification','Slack Notification Value: ' + [Value], a.CreatedDate, a.StateId, a.ElementId, null, @now
				from RowsProcessed_CTE1 a
				  where [key] like 'New Slack Message _.message%'


			-- Populate the events table with Email notifications
			set @now = getdate();
			with RowsProcessed_CTE1(StateId,[ElementId],[key],[Value],CreatedDate) as
				( SELECT TOP (@RowCount) StateId,[ElementId],[Key],Value,CreatedDate FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			insert [Access.ManyWho].[EventBusinessReporting]
			select distinct 'Email Notification','Email Notification Value: ' + [Value], a.CreatedDate, a.StateId, a.ElementId, null, @now
				from RowsProcessed_CTE1 a
				  where [key] like 'Email content%'


			-- Populate the events table with all user entries into flows for this batch
			set @now = getdate();
			with RowsProcessed_CTE1(StateId) as
				( SELECT TOP (@RowCount) StateId FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			insert [Access.ManyWho].[EventBusinessReporting]
			select distinct 'User Enters Flow','User Enters Flow', b.CreatedDate, b.StateId, b.ElementId, b.Email, @now
				from RowsProcessed_CTE1 a left join [Staging.ManyWho].[ManyWhoStates] b
						on a.StateId = b.StateId
				where not b.StateId is null



			-- Archive the states for the source rows
			set @now = getdate();
			insert [Staging.ManyWho].[ManyWhoStatesArchive]
			select b.*, @now
				from [Staging.ManyWho].[ManyWhoStates] b
				where b.stateid in (SELECT TOP (1000000) StateId FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
				order by createddate asc;


			-- Archive the source rows (values) loaded
			set @now = getdate();
			with RowsProcessed_CTE1(StateId, Elementid, [key], value, CreatedDate) as
				( SELECT TOP (@RowCount) StateId, Elementid, [key], value, CreatedDate FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			insert [Staging.ManyWho].[ManyWhoValuesArchive]
			select a.*, @now from RowsProcessed_CTE1 a order by createddate asc;

/*
			select a.*,getdate()
			from [Staging.ManyWho].[ManyWhoValues] a join #RowsToProcess b
					on a.stateid = b.stateid
					and a.Elementid = b.Elementid
					and a.[key] = b.[Key]
					and a.value = b.value
					and a.CreatedDate = b.CreatedDate
*/

/*
			-- Delete the loaded rows from the main source
			delete a
			from [Staging.ManyWho].[ManyWhoValues] a join #RowsToProcess b
					on a.stateid = b.stateid
					and a.Elementid = b.Elementid
					and a.[key] = b.[Key]
					and a.value = b.value
					and a.CreatedDate = b.CreatedDate;
*/


			-- delete the states for the values loaded
			delete from [Staging.ManyWho].[ManyWhoStates]
			where StateId IN (SELECT TOP (@RowCount) StateId FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc);


			-- delete the source rows (values)
			with RowsProcessed_CTE2(StateId, Elementid, [key], value, CreatedDate) as
				( SELECT TOP (@RowCount) StateId, Elementid, [key], value, CreatedDate FROM [Staging.ManyWho].[ManyWhoValues] ORDER BY createddate asc)
			delete from rowsprocessed_CTE2

	end try

	begin catch

		SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE() AS ErrorState, ERROR_PROCEDURE() AS ErrorProcedure, ERROR_LINE() AS ErrorLine, ERROR_MESSAGE() AS ErrorMessage
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION

		break

	end catch

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION

	set @TotalRowCount = @TotalRowCount + @RowCount

Print 'Total Rows Processed so far: ' + cast(@TotalRowCount as varchar(20))

end

/*
	-- show the rows processed
	select * from #RowsToProcess
		order by CreatedDate asc
	drop table #RowsToProcess
*/

end
