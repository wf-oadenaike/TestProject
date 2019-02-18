CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION305_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @BrokerAttestationEventId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @BrokerAttestationId INT, @BrokerAttestationId_UPDATE BIT, @BrokerAttestationEventType VARCHAR (100), @BrokerAttestationEventType_UPDATE BIT, @EventDetails VARCHAR (MAX), @EventDetails_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @BrokerAttestationEventLastModifiedDatetime DATETIME, @BrokerAttestationEventLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


