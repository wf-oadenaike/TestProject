CREATE VIEW [Access.ManyWho].[PolicyThemeProcedureCategoriesVw]
AS 
SELECT [PTPCategoryId]
      ,[PTPCategoryBK]
      ,[PTPCategoryName]
      ,[PTPRegisterLevel]
      ,[ReviewWithin]
      ,[ValidityPeriod]
  FROM [Organisation].[PolicyThemeProcedureCategories]

GO

CREATE TRIGGER [Access.ManyWho].[PolicyThemeProcedureCategoriesVwTri]
ON [Access.ManyWho].[PolicyThemeProcedureCategoriesVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[PolicyThemeProcedureCategoriesVwTri]';

	MERGE INTO [Organisation].[PolicyThemeProcedureCategories] Tar
	USING ( SELECT i.[PTPCategoryBK], i.[PTPCategoryName], i.[PTPRegisterLevel], i.[ReviewWithin], i.[ValidityPeriod]
			FROM INSERTED i
			) Src
	ON Tar.[PTPCategoryBK] = Src.[PTPCategoryBK]
	WHEN NOT MATCHED 
		THEN INSERT ([PTPCategoryBK], [PTPCategoryName], [PTPRegisterLevel], [ReviewWithin], [ValidityPeriod])
				VALUES (Src.[PTPCategoryBK], Src.[PTPCategoryName], Src.[PTPRegisterLevel], Src.[ReviewWithin], Src.[ValidityPeriod])
	WHEN MATCHED 
		THEN UPDATE SET Tar.[PTPCategoryName] = Src.[PTPCategoryName]
					, Tar.[PTPRegisterLevel] = Src.[PTPRegisterLevel]
					, Tar.[ReviewWithin] = Src.[ReviewWithin]
					, Tar.[ValidityPeriod] = Src.[ValidityPeriod]
	;

END TRY
BEGIN CATCH

		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		IF @@TRANCOUNT > 0 ROLLBACK;

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
