CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION118_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ClientBillingId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @MandateId INT, @MandateId_UPDATE BIT, @InvoiceDueDate DATE, @InvoiceDueDate_UPDATE BIT, @InvoiceReceivedDate DATE, @InvoiceReceivedDate_UPDATE BIT, @Amount DECIMAL (19, 2), @Amount_UPDATE BIT, @VATAmount DECIMAL (19, 2), @VATAmount_UPDATE BIT, @GrossAmountReceived DECIMAL (19, 2), @GrossAmountReceived_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @SubmittedDate DATETIME, @SubmittedDate_UPDATE BIT, @ReviewedByPersonId SMALLINT, @ReviewedByPersonId_UPDATE BIT, @ReviewedDate DATETIME, @ReviewedDate_UPDATE BIT, @StatusId SMALLINT, @StatusId_UPDATE BIT, @PaymentDueDate DATETIME, @PaymentDueDate_UPDATE BIT, @PaymentReceivedDate DATETIME, @PaymentReceivedDate_UPDATE BIT, @OpsTaskJiraKey VARCHAR (128), @OpsTaskJiraKey_UPDATE BIT, @ReconTaskJiraKey VARCHAR (128), @ReconTaskJiraKey_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ClientBillingCreationDatetime DATETIME, @ClientBillingCreationDatetime_UPDATE BIT, @ClientBillingLastModifiedDatetime DATETIME, @ClientBillingLastModifiedDatetime_UPDATE BIT, @ReconParentJiraKey VARCHAR (128), @ReconParentJiraKey_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


