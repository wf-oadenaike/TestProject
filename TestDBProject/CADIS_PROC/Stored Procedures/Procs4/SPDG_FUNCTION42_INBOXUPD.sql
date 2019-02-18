CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION42_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @PlacingAllocationId SMALLINT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @PlacingRegisterId INT, @PlacingRegisterId_UPDATE BIT, @PortfolioCode VARCHAR (20), @PortfolioCode_UPDATE BIT, @PortfolioName VARCHAR (128), @PortfolioName_UPDATE BIT, @AllocationAmount DECIMAL (19, 2), @AllocationAmount_UPDATE BIT, @AllocationPercent DECIMAL (19, 2), @AllocationPercent_UPDATE BIT, @AllocationDescription VARCHAR (2048), @AllocationDescription_UPDATE BIT, @AllocationBasisPoints DECIMAL (19, 2), @AllocationBasisPoints_UPDATE BIT, @NumberOfShares DECIMAL (19, 2), @NumberOfShares_UPDATE BIT, @CurrencyCode CHAR (3), @CurrencyCode_UPDATE BIT, @VotingRights DECIMAL (19, 2), @VotingRights_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @PlacingAllocationCreationDatetime DATETIME, @PlacingAllocationCreationDatetime_UPDATE BIT, @PlacingAllocationLastModifiedDatetime DATETIME, @PlacingAllocationLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


