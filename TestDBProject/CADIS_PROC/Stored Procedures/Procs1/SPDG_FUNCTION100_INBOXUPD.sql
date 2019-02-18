﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION100_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @MonitoringCategoryId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @MonitoringType VARCHAR (128), @MonitoringType_UPDATE BIT, @CategoryName VARCHAR (128), @CategoryName_UPDATE BIT, @MonitoringFrequency VARCHAR (128), @MonitoringFrequency_UPDATE BIT, @FrequencyMonths VARCHAR (128), @FrequencyMonths_UPDATE BIT, @FrequencyStartMonth VARCHAR (50), @FrequencyStartMonth_UPDATE BIT, @DueDateOffSet SMALLINT, @DueDateOffSet_UPDATE BIT, @DocumentationURL VARCHAR (2000), @DocumentationURL_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @MonitoringCategoryLastModifiedDate DATETIME, @MonitoringCategoryLastModifiedDate_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


