﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION304_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @AssetTypeId INT, @AssetTypeId_UPDATE BIT, @Supplier VARCHAR (100), @Supplier_UPDATE BIT, @Reference VARCHAR (100), @Reference_UPDATE BIT, @TransactionNo VARCHAR (50), @TransactionNo_UPDATE BIT, @Description VARCHAR (MAX), @Description_UPDATE BIT, @AssetCost DECIMAL (19, 2), @AssetCost_UPDATE BIT, @PurchaseDate DATETIME, @PurchaseDate_UPDATE BIT, @WrittenOffDate DATETIME, @WrittenOffDate_UPDATE BIT, @Status VARCHAR (50), @Status_UPDATE BIT, @WritedownPeriod INT, @WritedownPeriod_UPDATE BIT, @DepreciationType VARCHAR (50), @DepreciationType_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @AssetRegisterLastModifiedDatetime DATETIME, @AssetRegisterLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


