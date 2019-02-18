CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION101_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @UnquotedCompanyCommentaryId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @UnquotedCompanyStage VARCHAR (5), @UnquotedCompanyStage_UPDATE BIT, @UnquotedCompanyId INT, @UnquotedCompanyId_UPDATE BIT, @Commentary NVARCHAR (MAX), @Commentary_UPDATE BIT, @CommentaryByPersonId SMALLINT, @CommentaryByPersonId_UPDATE BIT, @CommentaryByRoleId SMALLINT, @CommentaryByRoleId_UPDATE BIT, @CommentaryLastModifiedDate DATETIME, @CommentaryLastModifiedDate_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


