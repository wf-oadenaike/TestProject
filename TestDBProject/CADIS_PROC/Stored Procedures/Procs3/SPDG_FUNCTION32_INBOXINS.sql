﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION32_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @KPIName VARCHAR (128), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @KPINameAlias VARCHAR (128), @KPINameAlias_UPDATE BIT, @OwnerRoleId SMALLINT, @OwnerRoleId_UPDATE BIT, @RedThresholdValue DECIMAL (19, 5), @RedThresholdValue_UPDATE BIT, @AmberThresholdValue DECIMAL (19, 5), @AmberThresholdValue_UPDATE BIT, @GreenThresholdValue DECIMAL (19, 5), @GreenThresholdValue_UPDATE BIT, @RefreshFrequencyId SMALLINT, @RefreshFrequencyId_UPDATE BIT, @Operator VARCHAR (25), @Operator_UPDATE BIT, @IsPercentage BIT, @IsPercentage_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @AggrFunction VARCHAR (3), @AggrFunction_UPDATE BIT, @KPIDescription VARCHAR (128), @KPIDescription_UPDATE BIT, @TargetValue DECIMAL (19, 5), @TargetValue_UPDATE BIT, @KPIDBBK VARCHAR (25), @KPIDBBK_UPDATE BIT, @KPIBK SMALLINT, @KPIBK_UPDATE BIT, @FUND_SHORT_NAME VARCHAR (20), @FUND_SHORT_NAME_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


