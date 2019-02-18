



CREATE PROC [CADIS].[SP_AUDIT_ARCHIVE]

AS

DECLARE	@RunId		INTEGER,
	@UserName		NVARCHAR(256),
	@ProcessId		NCHAR(32),
	@ComponentId	INTEGER,
	@ParentId		INTEGER,
    @TopLevelRunID 	INTEGER,
	@DropObsolete	BIT,
	@Token			NVARCHAR(50),
	@RunningStatus	INTEGER,
	@MergedStatus	INTEGER,
	@RunParams		XML,
	@ItemId			NVARCHAR(50),
	@FailedRunID	INTEGER 


SELECT	@ComponentId = ID,
	@UserName = 'Archive',
	@ProcessId = RTRIM(' '),
	@ParentId = 0,
	@DropObsolete = 1,  /* set to 0 if you do NOT want to drop obsolete objects */
    @TopLevelRunID = 0,
    @Token = NULL,	/* NULL unless process is run from a queue */
    @RunningStatus = NULL,
    @MergedStatus = NULL,
	@RunParams = NULL,
	@ItemId = NULL,
	@FailedRunID = NULL

FROM	CADIS_SYS.CO_COMPONENT
WHERE	NAME = 'Archive'

EXEC	@RunId = CADIS_SYS.SPGETRUNID @ComponentId, @ProcessId, @UserName, @ParentId, @TopLevelRunID, @Token, @RunningStatus, @MergedStatus, 
@RunParams, @ItemId, @FailedRunID
--PRINT('RunId = ' + convert(nvarchar,@RunId))

EXEC	CADIS_SYS.SPCO_ARCHIVE @RunId, @DropObsolete



