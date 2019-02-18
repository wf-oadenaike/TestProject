CREATE VIEW [Access.ManyWho].[ConflictsRegisterEventsVw]
	AS
	SELECT ConflictsRegisterEventId, ConflictRegisterIdBK
			, et.[ConflictEventTypeBK], re.[ConflictEventTypeId], EventDetails, EventTrueFalse
			, EventDate, DocumentationFolderLink, JoinGUID
	FROM [Compliance].[ConflictsRegisterEvents] re
		INNER JOIN [Compliance].[ConflictEventTypes] et
			ON re.[ConflictEventTypeId] = et.ConflictEventTypeId
	;

GO
CREATE  TRIGGER [Access.ManyWho].[ConflictsRegisterEventsTri]
ON [Access.ManyWho].[ConflictsRegisterEventsVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Compliance].[ConflictsRegisterEventsTri]';

	MERGE INTO [Compliance].[ConflictsRegisterEvents] Tar
		USING (SELECT ISNULL( i.ConflictRegisterIdBK, cr.[ConflictRegisterIdBK]) as ConflictRegisterIdBK, i.EventDetails, i.EventDate, i.EventTrueFalse, i.DocumentationFolderLink
				, IsNull( i.ConflictEventTypeId, et.ConflictEventTypeId) as ConflictEventTypeId, cr.WorkflowVersionGUID
						, ISNULL( i.JoinGUID, cr.JoinGUID) as JoinGUID
						, GetDate() as ConflictCreationDate, GetDate() as ConflictLastModifiedDate
				FROM inserted i
				INNER JOIN [Compliance].[ConflictsRegister] cr
					ON i.ConflictRegisterIdBK = cr.[ConflictRegisterIdBK]
					OR (i.JoinGUID = cr.JoinGUID and i.ConflictRegisterIdBK IS NULL)
				LEFT OUTER JOIN [Compliance].[ConflictEventTypes] et
					ON i.ConflictEventTypeBK = et.ConflictEventTypeBK
				) Src
		ON (Tar.JoinGUID = Src.JoinGUID
		AND Tar.ConflictRegisterIdBK = Src.ConflictRegisterIdBK)
		AND Tar.ConflictEventTypeId = Src.ConflictEventTypeId
		WHEN NOT MATCHED 
			THEN INSERT (ConflictRegisterIdBK, EventDetails, EventDate, EventTrueFalse, DocumentationFolderLink
						, ConflictEventTypeId, WorkflowVersionGUID, JoinGUID, ConflictEventCreationDate, ConflictEventLastModifiedDate)
				VALUES (Src.ConflictRegisterIdBK, Src.EventDetails, Src.EventDate, Src.EventTrueFalse, Src.DocumentationFolderLink
						, Src.ConflictEventTypeId, Src.WorkflowVersionGUID, Src.JoinGUID, Src.ConflictCreationDate, Src.ConflictLastModifiedDate)
		WHEN MATCHED AND (Tar.EventDetails <> Src.EventDetails
						OR Tar.EventDate <> Src.EventDate
						OR Tar.EventTrueFalse <> Src.EventTrueFalse
						OR Tar.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET Tar.EventDetails = Src.EventDetails
						, Tar.EventDate = Src.EventDate
						, Tar.EventTrueFalse = Src.EventTrueFalse
						, Tar.DocumentationFolderLink = Src.DocumentationFolderLink
						, Tar.ConflictEventLastModifiedDate = Src.ConflictLastModifiedDate
						, Tar.JoinGUID = Src.JoinGUID
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
