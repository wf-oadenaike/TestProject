CREATE PROCEDURE [ETL].[usp_IsFileAlreadyProcessed]
	 @Filename VARCHAR(1024)
AS
SET NOCOUNT ON

-- If the file already exists return nothing.  If the file does not exists then return back the name so Boomi can carry on.
IF NOT EXISTS (
SELECT 1 FROM 
[Audit].[FilesArchiveLog]
WHERE [FileName] = @Filename
)
SELECT @Filename
