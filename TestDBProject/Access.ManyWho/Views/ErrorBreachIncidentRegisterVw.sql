CREATE VIEW [Access.ManyWho].[ErrorBreachIncidentRegisterVw]
	AS
	SELECT EBIRegisterIdBK
			, EBIExternalReference
			, ReportedByPersonId
			, rp.PersonsName as ReportedBy
			, rp.EmployeeBK as ReportedSalesforceUserId
			, RecordedByPersonId
			, rep.PersonsName as RecordedBy
			, rep.EmployeeBK as RecordedSalesforceUserId
			, EBITypeCode
			, EBICategorisation
			, EBISummary
			, ExternalNotificationRequired
			, DateIdentified
			, DocumentationFolderLink
			, WorkflowVersionGUID
			, JoinGUID
	FROM [Compliance].[ErrorBreachIncidentRegister] EBIr
		INNER JOIN Core.Persons rp
		ON (EBIr.RecordedByPersonId = rp.PersonId)
		INNER JOIN Core.Persons rep
		ON (EBIr.ReportedByPersonId = rep.PersonId)
	;

GO

CREATE TRIGGER [Access.ManyWho].[ErrorBreachIncidentRegisterTri]
ON [Access.ManyWho].[ErrorBreachIncidentRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[ErrorBreachIncidentRegisterTri]';

	MERGE INTO [Compliance].[ErrorBreachIncidentRegister] Tar
		USING (SELECT i.EBIRegisterIdBK, i.EBIExternalReference, COALESCE( i.ReportedBy, rp.PersonsName, 'Unkown') as ReportedBy
					, COALESCE( rp.PersonId, i.ReportedByPersonId, -1) as ReportedByPersonId
					, COALESCE( rec.PersonId, i.RecordedByPersonId, -1) as RecordedByPersonId
					, i.EBITypeCode, i.EBICategorisation, i.EBISummary, i.ExternalNotificationRequired
					, i.DateIdentified, i.DocumentationFolderLink, i.WorkflowVersionGUID, i.JoinGUID
					, GetDate() as EBICreationDate, GetDate() as EBILastModifiedDate
				FROM inserted i
					LEFT OUTER JOIN Core.Persons rp
					ON LEFT( i.ReportedSalesforceUserId, 15) = rp.EmployeeBK
					AND rp.ActiveFlag = 1
					LEFT OUTER JOIN Core.Persons rec
					ON LEFT( i.RecordedSalesforceUserId, 15) = rec.EmployeeBK
					AND rec.ActiveFlag = 1
					) Src
		ON Tar.EBIRegisterIdBK = Src.EBIRegisterIdBK
		WHEN NOT MATCHED 
			THEN INSERT (EBIExternalReference, ReportedByPersonId , ReportedBy, RecordedByPersonId, EBITypeCode
						, EBICategorisation, EBISummary, ExternalNotificationRequired, DateIdentified, DocumentationFolderLink
						, WorkflowVersionGUID, JoinGUID, EBICreationDate, EBILastModifiedDate)
				VALUES (Src.EBIExternalReference, Src.ReportedByPersonId, Src.ReportedBy, Src.RecordedByPersonId
						, Src.EBITypeCode, Src.EBICategorisation, Src.EBISummary, Src.ExternalNotificationRequired, Src.DateIdentified
						, Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID
						, Src.EBICreationDate, Src.EBILastModifiedDate)

		WHEN MATCHED AND (Tar.EBIExternalReference <> Src.EBIExternalReference
						OR Tar.ReportedByPersonId <> Src.ReportedByPersonId
						OR Tar.ReportedBy <> Src.ReportedBy
						OR Tar.RecordedByPersonId <> Src.RecordedByPersonId
						OR Tar.EBITypeCode <> Src.EBITypeCode
						OR Tar.EBICategorisation <> Src.EBICategorisation
						OR Tar.ExternalNotificationRequired <> Src.ExternalNotificationRequired
						OR Tar.DateIdentified <> Src.DateIdentified
						Or Tar.DocumentationFolderLink <> Src.DocumentationFolderLink
						OR Tar.EBISummary <> Src.EBISummary)
			THEN UPDATE SET Tar.EBIExternalReference = Src.EBIExternalReference
						, Tar.ReportedByPersonId = Src.ReportedByPersonId
						, Tar.ReportedBy = Src.ReportedBy
						, Tar.RecordedByPersonId = Src.RecordedByPersonId
						, Tar.EBITypeCode = Src.EBITypeCode
						, Tar.EBICategorisation = Src.EBICategorisation
						, Tar.ExternalNotificationRequired = Src.ExternalNotificationRequired
						, Tar.DateIdentified = Src.DateIdentified
						, Tar.DocumentationFolderLink = Src.DocumentationFolderLink
						, Tar.EBILastModifiedDate = Src.EBILastModifiedDate
						, Tar.EBISummary = Src.EBISummary
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
