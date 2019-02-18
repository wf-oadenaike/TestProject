CREATE proc [Organisation].[usp_NewProjectRAGStatusDailyUpdate]
as
-- Date 2017/05/04 
-- Changed logic as per DAP 1001  
-- Joe Tapper 
begin

	declare @todaysDate as date = getdate()

	update [Organisation].[NewProjectsRegister]

	set RAGStatus =

	case [ProjectStatus]

		when 'Approved' then

			case
				when [ProposedStartDate] >= @todaysDate then 'Green'
			--	when (@todaysDate > dateadd(m,-1,[ProposedStartDate])) and (@todaysDate < [ProposedStartDate]) then 'Amber'
				when (@todaysDate > [ProposedStartDate]) then 'Red'
			end

		when 'Live' then

			case
			--	when (@todaysDate > [ActualStartDate]) and (@todaysDate < dateadd(ww,-2,[ActualEndDate])) then 'Green'
			when (@todaysDate >= [ActualStartDate]) and (@todaysDate <= [ActualEndDate]) then 'Green'
			--	when (@todaysDate > dateadd(ww,-2,[ActualEndDate])) and (@todaysDate < [ActualEndDate]) then 'Amber'
				when (@todaysDate > [ActualEndDate]) then 'Red'
			end

		when 'Completed' then 'White'
		--when 'Descoped' then 'White'
		-- when 'Descoped' then 'Blue'
		when 'Cancelled' then 'Blue'

	end

end
