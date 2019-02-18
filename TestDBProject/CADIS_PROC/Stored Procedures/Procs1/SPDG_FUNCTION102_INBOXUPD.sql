﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION102_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @UnquotedCompanyDecisionId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @UnquotedCompanyStage VARCHAR (5), @UnquotedCompanyStage_UPDATE BIT, @InvestmentDecisionType CHAR (3), @InvestmentDecisionType_UPDATE BIT, @UnquotedCompanyId INT, @UnquotedCompanyId_UPDATE BIT, @DecisionByPersonId SMALLINT, @DecisionByPersonId_UPDATE BIT, @DecisionByRoleId SMALLINT, @DecisionByRoleId_UPDATE BIT, @DecisionLastModifiedDate DATETIME, @DecisionLastModifiedDate_UPDATE BIT, @DeferDecisionDate DATETIME, @DeferDecisionDate_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


