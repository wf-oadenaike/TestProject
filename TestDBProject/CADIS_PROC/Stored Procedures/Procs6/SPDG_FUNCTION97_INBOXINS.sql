CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION97_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @BrokerCompanyName NVARCHAR (128), @BrokerCompanyName_UPDATE BIT, @BloombergId VARCHAR (25), @BloombergId_UPDATE BIT, @BrokerServiceTypeId INT, @BrokerServiceTypeId_UPDATE BIT, @UnderCSAControl BIT, @UnderCSAControl_UPDATE BIT, @ServiceCost DECIMAL (19, 2), @ServiceCost_UPDATE BIT, @ResearchCostWIMFundsPercent DECIMAL (5, 2), @ResearchCostWIMFundsPercent_UPDATE BIT, @ResearchCostWIMLLPPercent DECIMAL (5, 2), @ResearchCostWIMLLPPercent_UPDATE BIT, @PaymentFrequencyId INT, @PaymentFrequencyId_UPDATE BIT, @PaymentTerms VARCHAR (25), @PaymentTerms_UPDATE BIT, @ServiceDescription NVARCHAR (MAX), @ServiceDescription_UPDATE BIT, @InitialBudgetAmount DECIMAL (19, 2), @InitialBudgetAmount_UPDATE BIT, @InitialBudgetDate DATETIME, @InitialBudgetDate_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @BrokerRelationshipPersonId SMALLINT, @BrokerRelationshipPersonId_UPDATE BIT, @ResearchAccountSalesforceId VARCHAR (18), @ResearchAccountSalesforceId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ResearchBrokerLastModifiedDatetime DATETIME, @ResearchBrokerLastModifiedDatetime_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


