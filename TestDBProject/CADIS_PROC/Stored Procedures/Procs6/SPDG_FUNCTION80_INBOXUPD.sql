CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION80_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @MandateId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @ClientTakeOnId INT, @ClientTakeOnId_UPDATE BIT, @MandateName VARCHAR (128), @MandateName_UPDATE BIT, @MandateDescription VARCHAR (128), @MandateDescription_UPDATE BIT, @IsWoodfordMandate BIT, @IsWoodfordMandate_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ClientTakeOnMandateLastModifiedDatetime DATETIME, @ClientTakeOnMandateLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


