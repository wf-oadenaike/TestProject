CREATE PROCEDURE [Organisation].[usp_CompleteMeetingAgendaitem]
		@MeetingOccurrenceId INT, 
		@MeetingAgendaItemId SMALLINT 
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Organisation].[usp_CompleteMeetingAgendaitem]
-- 
-- Note:			
-- 
-- Author:			I Pearson
-- Date:			30/07/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN
	IF NOT EXISTS ( SELECT 1 FROM [Organisation].[MeetingOccurrenceJiraIssueCreationLog] WHERE @MeetingOccurrenceId = MeetingOccurrenceId AND @MeetingAgendaItemId = MeetingAgendaItemId )
	BEGIN
		INSERT INTO [Organisation].[MeetingOccurrenceJiraIssueCreationLog] (MeetingOccurrenceId, MeetingAgendaItemId) VALUES (@MeetingOccurrenceId, @MeetingAgendaItemId)
	END
END
