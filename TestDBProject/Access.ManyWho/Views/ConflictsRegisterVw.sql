CREATE VIEW [Access.ManyWho].[ConflictsRegisterVw]
	AS
	SELECT cr.ConflictRegisterIdBK
	, p.PersonsName as NotifyingPersonName
	, cr.NotifyingPersonId as NotifyingPersonId
	, p.EmployeeBK as NotifyingSalesforceUserId
	, p.PersonsName as NotifyingPersonsName
	, cr.ConflictClosed	
	, cr.ConflictInactive
	, cr.ConflictTitle
	, cr.ConflictSummary
	, CAST( cr.ConflictCreationDate as Date) as RecordedDate
	--, cr.ConflictCreationDate
	--, cr.ConflictLastModifiedDate
	, cr.DocumentationFolderLink
	, cr.WorkflowVersionGUID
	, cr.JoinGUID
	FROM [Compliance].[ConflictsRegister] cr
		INNER JOIN Core.Persons p
		ON (cr.NotifyingPersonId = p.PersonId)
	;

GO
CREATE TRIGGER [Access.ManyWho].[ConflictsRegisterTri]
ON [Access.ManyWho].[ConflictsRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Compliance].[ConflictsRegisterTri]';

	MERGE INTO [Compliance].[ConflictsRegister] Tar
		USING (SELECT i.ConflictRegisterIdBK, COALESCE( i.NotifyingPersonId, p.PersonId, -1) as notifingPersonId, i.ConflictTitle, i.ConflictSummary, i.DocumentationFolderLink
				, i.WorkflowVersionGUID, i.JoinGUID, GetDate() as ConflictCreationDate, i.ConflictClosed, i.ConflictInactive
				, GetDate() as ConflictLastModifiedDate
				FROM inserted i
					LEFT OUTER JOIN Core.Persons p
					ON LEFT(i.NotifyingSalesforceUserId, 15) = p.EmployeeBK
					AND p.ActiveFlag = 1
					) Src
		ON Tar.ConflictRegisterIdBK = Src.ConflictRegisterIdBK
		WHEN NOT MATCHED 
			THEN INSERT ([NotifyingPersonId], [ConflictTitle], [ConflictSummary],[DocumentationFolderLink]
							,[WorkflowVersionGUID],[JoinGUID],[ConflictCreationDate]
							,[ConflictLastModifiedDate], ConflictClosed, ConflictInactive)
				VALUES (Src.NotifingPersonId, Src.ConflictTitle, Src.ConflictSummary, Src.DocumentationFolderLink
						, Src.WorkflowVersionGUID, Src.JoinGUID, Src.ConflictCreationDate, Src.ConflictLastModifiedDate
						, Src.ConflictClosed, Src.ConflictInactive)
		WHEN MATCHED AND (Tar.[NotifyingPersonId] <> Src.[NotifingPersonId]
						OR Tar.[ConflictTitle] <> Src.[ConflictTitle]
						OR Tar.[ConflictSummary] <> Src.[ConflictSummary]
						OR Tar.[DocumentationFolderLink] <> Src.[DocumentationFolderLink]
						OR Tar.ConflictClosed <> Src.ConflictClosed
						OR Tar.ConflictInactive <> Src.ConflictInactive)
			THEN UPDATE SET Tar.[NotifyingPersonId] = Src.[NotifingPersonId]
						, Tar.[ConflictTitle] = Src.[ConflictTitle]
						, Tar.[ConflictSummary] = Src.[ConflictSummary]
						, Tar.[DocumentationFolderLink] = Src.[DocumentationFolderLink]
						, Tar.ConflictLastModifiedDate = Src.ConflictLastModifiedDate
						, Tar.JoinGUID = Src.JoinGUID
						, Tar.ConflictClosed = Src.ConflictClosed
						, Tar.ConflictInactive = Src.ConflictInactive
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
