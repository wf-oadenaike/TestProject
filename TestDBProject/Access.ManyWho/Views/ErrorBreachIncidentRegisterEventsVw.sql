CREATE VIEW [Access.ManyWho].[ErrorBreachIncidentRegisterEventsVw]
	AS
	SELECT EBIRegisterEventId
			, EBIRegisterIdBK
			, EBIre.EBIEventTypeId
			, et.EBIEventTypeBK
			, EventDetails
			, EventDate
			, EventTrueFalse
			, RecordedByPersonId
			, rp.EmployeeBK as RecordedSalesforceUserId
			, EBIEventCreationDate
			, EBIEventLastModifiedDate
			, DocumentationFolderLink
			, JoinGUID
	FROM [Compliance].[ErrorBreachIncidentRegisterEvents] EBIre
		INNER JOIN [Compliance].[ErrorBreachIncidentRegisterEventTypes] et
			ON EBIre.[EBIEventTypeId] = et.EBIEventTypeId
		INNER JOIN Core.Persons rp
			ON (EBIre.RecordedByPersonId = rp.PersonId)
	;

GO
CREATE TRIGGER [Access.ManyWho].[ErrorBreachIncidentRegisterEventsTri]
ON [Access.ManyWho].[ErrorBreachIncidentRegisterEventsVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Compliance].[ErrorBreachIncidentRegisterEventsTri]';

	MERGE INTO [Compliance].[ErrorBreachIncidentRegisterEvents] Tar
		USING (SELECT ISNULL( i.EBIRegisterIdBK, EBI.EBIRegisterIdBK) as EBIRegisterIdBK, COALESCE( i.RecordedByPersonId, p.PersonId, -1) as RecordedByPersonId
					, i.EventDetails, i.EventDate, i.EventTrueFalse
					, i.DocumentationFolderLink, EBIre.EBIEventTypeId,EBI.WorkflowVersionGUID
					, ISNULL( i.JoinGUID, EBI.JoinGUID) as JoinGUID, GetDate() as EBIEventCreationDate, GetDate() as EBIEventLastModifiedDate
				FROM inserted i
				LEFT OUTER JOIN [Compliance].[ErrorBreachIncidentRegister] EBI
					ON i.EBIRegisterIdBK = EBI.EBIRegisterIdBK
					OR (i.JoinGUID = EBI.JoinGUID and i.EBIRegisterIdBK IS NULL)
				LEFT OUTER JOIN [Compliance].[ErrorBreachIncidentRegisterEventTypes] EBIre
					ON i.EBIEventTypeBK = EBIre.EBIEventTypeBK
				LEFT OUTER JOIN Core.Persons p
					ON LEFT(i.RecordedSalesforceUserId, 15) = p.EmployeeBK
					AND p.ActiveFlag = 1
				) Src
		ON (Tar.JoinGUID = Src.JoinGUID
		AND Tar.EBIRegisterIdBK = Src.EBIRegisterIdBK)
		AND Tar.EBIEventTypeId = Src.EBIEventTypeId
		WHEN NOT MATCHED 
			THEN INSERT (EBIRegisterIdBK, EBIEventTypeId, EventDetails, EventDate, EventTrueFalse
						, RecordedByPersonId, DocumentationFolderLink
						, WorkflowVersionGUID, JoinGUID
						, EBIEventCreationDate, EBIEventLastModifiedDate)
				VALUES (EBIRegisterIdBK, src.EBIEventTypeId, EventDetails, EventDate, EventTrueFalse
						, RecordedByPersonId, DocumentationFolderLink
						, src.WorkflowVersionGUID, JoinGUID
						, EBIEventCreationDate, EBIEventLastModifiedDate)
		WHEN MATCHED AND (Tar.EventDetails <> Src.EventDetails
						OR Tar.EventDate <> Src.EventDate
						OR Tar.EventTrueFalse <> Src.EventTrueFalse
						OR Tar.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET Tar.EventDetails = Src.EventDetails
						, Tar.EventDate = Src.EventDate
						, Tar.EventTrueFalse = Src.EventTrueFalse
						, Tar.DocumentationFolderLink = Src.DocumentationFolderLink
						, Tar.EBIEventLastModifiedDate = Src.EBIEventLastModifiedDate
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
