CREATE VIEW [Access.ManyWho].[MeetingOccurrenceVw]
	AS
	SELECT mo.MeetingOccurrenceId, mo.MeetingRegisterId, mr.MeetingNameBK, mo.MeetingDateTime as MeetingDateTime, mo.MeetingNotes, mo.JIRAEpicKey, mo.DocumentationFolderLink, mo.ActiveFlag
             , CAST(CASE WHEN mo.MeetingDateTime = (SELECT MIN(mo1.MeetingDateTime) FROM Organisation.MeetingOccurrence mo1 WHERE mo1.MeetingRegisterId = mo.MeetingRegisterId AND mo1.MeetingDateTime > GetDate()) THEN 1 ELSE 0 END as bit) as NextMeetingOccurrence 
             , CAST(CASE WHEN mo.MeetingDateTime < GetDate() THEN 1 ELSE 0 END as bit) as ExpiredMeetingOccurrence
	     , mo.WorkflowVersionGUID, mo.JoinGUID, mo.MeetingOccurrenceCreationDatetime, MeetingOccurrenceLastModifiedDatetime
	FROM Organisation.MeetingOccurrence mo
		INNER JOIN Organisation.MeetingsRegister mr
			ON mo.MeetingRegisterId = mr.MeetingRegisterId
	;

GO
CREATE TRIGGER [Access.ManyWho].[MeetingOccurrenceTri]
ON [Access.ManyWho].[MeetingOccurrenceVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[MeetingOccurrenceTri]';

	MERGE INTO [Organisation].[MeetingOccurrence] mo
		USING (SELECT i.MeetingOccurrenceId, ISNULL(i.MeetingRegisterId, mr.MeetingRegisterId) as MeetingRegisterId
                , i.MeetingDateTime
				, i.MeetingNotes
				, i.JIRAEpicKey
                , ISNULL(i.ActiveFlag, 1) as ActiveFlag
                , i.DocumentationFolderLink
				, ISNULL( i.WorkflowVersionGUID, mr.WorkflowVersionGUID) as WorkflowVersionGUID
				, ISNULL( i.JoinGUID, mr.JoinGUID) as JoinGUID
		        , GetDate() as MeetingOccurrenceCreationDatetime
                , GetDate() as MeetingOccurrenceLastModifiedDatetime
				FROM inserted i
					INNER JOIN Organisation.MeetingsRegister mr
					ON i.MeetingNameBK = mr.MeetingNameBK
					OR (i.JoinGUID = mr.JoinGUID and i.MeetingNameBK IS NULL)
					) Src
		ON mo.MeetingOccurrenceId = Src.MeetingOccurrenceId
		WHEN NOT MATCHED 
			THEN INSERT (MeetingRegisterId, MeetingDateTime, MeetingNotes, JIRAEpicKey, ActiveFlag,
                         DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, MeetingOccurrenceCreationDatetime, MeetingOccurrenceLastModifiedDatetime)
				VALUES (Src.MeetingRegisterId, Src.MeetingDateTime, Src.MeetingNotes, Src.JIRAEpicKey, Src.ActiveFlag, 
                        Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, Src.MeetingOccurrenceCreationDatetime, Src.MeetingOccurrenceLastModifiedDatetime)
	   	WHEN MATCHED AND ((mo.MeetingNotes IS NULL AND Src.MeetingNotes IS NOT NULL)
						OR (mo.MeetingNotes IS NOT NULL AND Src.MeetingNotes IS NULL)
						OR mo.MeetingNotes <> Src.MeetingNotes
						OR (mo.JIRAEpicKey IS NULL AND Src.JIRAEpicKey IS NOT NULL)
						OR (mo.JIRAEpicKey IS NOT NULL AND Src.JIRAEpicKey IS NULL)
						OR mo.JIRAEpicKey <> Src.JIRAEpicKey
						OR mo.ActiveFlag <> Src.ActiveFlag
						OR (mo.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
						OR (mo.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)
						OR mo.DocumentationFolderLink <> Src.DocumentationFolderLink
						OR mo.MeetingDateTime <> Src.MeetingDateTime)
			THEN UPDATE SET mo.MeetingDateTime = Src.MeetingDateTime
			            , mo.MeetingNotes = Src.MeetingNotes
						, mo.JIRAEpicKey = Src.JIRAEpicKey
						, mo.ActiveFlag = Src.ActiveFlag
						, mo.DocumentationFolderLink = Src.DocumentationFolderLink
						, mo.MeetingOccurrenceLastModifiedDatetime = Src.MeetingOccurrenceLastModifiedDatetime
			;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strTriggerName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;
