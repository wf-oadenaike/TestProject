CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION18_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ProxyVotingRegisterId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @SecurityName VARCHAR (128), @SecurityName_UPDATE BIT, @ISIN CHAR (12), @ISIN_UPDATE BIT, @VoterPersonId SMALLINT, @VoterPersonId_UPDATE BIT, @VoterRoleId SMALLINT, @VoterRoleId_UPDATE BIT, @RecorderPersonId SMALLINT, @RecorderPersonId_UPDATE BIT, @DateFiled DATETIME, @DateFiled_UPDATE BIT, @CoveredByIVISYesNo BIT, @CoveredByIVISYesNo_UPDATE BIT, @ProxyVotingCategory VARCHAR (25), @ProxyVotingCategory_UPDATE BIT, @ProxyVotingStatus VARCHAR (50), @ProxyVotingStatus_UPDATE BIT, @MeetingDate DATETIME, @MeetingDate_UPDATE BIT, @DeadlineDate DATETIME, @DeadlineDate_UPDATE BIT, @SuggestedDecision VARCHAR (2048), @SuggestedDecision_UPDATE BIT, @ActualDecision VARCHAR (2048), @ActualDecision_UPDATE BIT, @OperationsNotes VARCHAR (MAX), @OperationsNotes_UPDATE BIT, @InvestmentNotes VARCHAR (MAX), @InvestmentNotes_UPDATE BIT, @CompletedProxyVoteYesNo BIT, @CompletedProxyVoteYesNo_UPDATE BIT, @IrrevocableUndertakingYesNo BIT, @IrrevocableUndertakingYesNo_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ProxyVotingCreationDatetime DATETIME, @ProxyVotingCreationDatetime_UPDATE BIT, @ProxyVotingLastModifiedDatetime DATETIME, @ProxyVotingLastModifiedDatetime_UPDATE BIT, @VoterJiraKey VARCHAR (20), @VoterJiraKey_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


