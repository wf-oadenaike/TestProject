CREATE PROCEDURE [ETL].[usp_SetFileProcessed]
	 @Filename VARCHAR(50),
	 @LoadSource VARCHAR(20)
AS
SET NOCOUNT ON

-- If the file already exists return nothing.  If the file does not exists then return back the name so Boomi can carry on.
IF NOT EXISTS (
SELECT 1 FROM 
[Audit].[FilesArchiveLog]
WHERE [FileName] = @Filename AND LoadSource = @LoadSource
)
INSERT INTO [Audit].[FilesArchiveLog] ([FileName], LoadSource, FileArchiveDateTime)
VALUES (@Filename, @LoadSource, GETDATE())
