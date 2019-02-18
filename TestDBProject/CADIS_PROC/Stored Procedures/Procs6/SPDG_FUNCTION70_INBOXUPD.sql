﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION70_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ProjectId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @ProjectName VARCHAR (100), @ProjectName_UPDATE BIT, @RequestorPersonId SMALLINT, @RequestorPersonId_UPDATE BIT, @OwnerPersonId SMALLINT, @OwnerPersonId_UPDATE BIT, @OversightPersonId SMALLINT, @OversightPersonId_UPDATE BIT, @ProposedStartDate DATETIME, @ProposedStartDate_UPDATE BIT, @EstimatedDuration VARCHAR (50), @EstimatedDuration_UPDATE BIT, @EstimatedCost DECIMAL (19, 2), @EstimatedCost_UPDATE BIT, @TechnologyInvolvedYesNo BIT, @TechnologyInvolvedYesNo_UPDATE BIT, @ProjectStatus VARCHAR (100), @ProjectStatus_UPDATE BIT, @ProjectType VARCHAR (100), @ProjectType_UPDATE BIT, @ProjectPurpose VARCHAR (MAX), @ProjectPurpose_UPDATE BIT, @ProjectScope VARCHAR (MAX), @ProjectScope_UPDATE BIT, @Dependences VARCHAR (MAX), @Dependences_UPDATE BIT, @ExternalResources VARCHAR (MAX), @ExternalResources_UPDATE BIT, @DepartmentId SMALLINT, @DepartmentId_UPDATE BIT, @NewResourcesYesNo BIT, @NewResourcesYesNo_UPDATE BIT, @NewTechnology VARCHAR (MAX), @NewTechnology_UPDATE BIT, @AdditionalDetails VARCHAR (MAX), @AdditionalDetails_UPDATE BIT, @JiraEpicKey VARCHAR (128), @JiraEpicKey_UPDATE BIT, @DueDate DATETIME, @DueDate_UPDATE BIT, @CreateNewEpic BIT, @CreateNewEpic_UPDATE BIT, @IsClientTakeOn BIT, @IsClientTakeOn_UPDATE BIT, @RAGStatus VARCHAR (20), @RAGStatus_UPDATE BIT, @ActualStartDate DATE, @ActualStartDate_UPDATE BIT, @ActualEndDate DATE, @ActualEndDate_UPDATE BIT, @NewResourceNumber INT, @NewResourceNumber_UPDATE BIT, @NewResourceCost DECIMAL (19, 2), @NewResourceCost_UPDATE BIT, @ITResourceYesNo BIT, @ITResourceYesNo_UPDATE BIT, @ITResourceNumber INT, @ITResourceNumber_UPDATE BIT, @ITResourceCost DECIMAL (19, 2), @ITResourceCost_UPDATE BIT, @OtherCostYesNo BIT, @OtherCostYesNo_UPDATE BIT, @OtherCost DECIMAL (19, 2), @OtherCost_UPDATE BIT, @Rescoped BIT, @Rescoped_UPDATE BIT, @InternalAudit BIT, @InternalAudit_UPDATE BIT, @ExternalComms BIT, @ExternalComms_UPDATE BIT, @ProjectBillingCode VARCHAR (20), @ProjectBillingCode_UPDATE BIT, @NewResourceDetails VARCHAR (MAX), @NewResourceDetails_UPDATE BIT, @ITResourceDetails VARCHAR (MAX), @ITResourceDetails_UPDATE BIT, @NewTechnologyCost DECIMAL (19, 2), @NewTechnologyCost_UPDATE BIT, @PreviousProjectId INT, @PreviousProjectId_UPDATE BIT, @LegalCostYesNo BIT, @LegalCostYesNo_UPDATE BIT, @LegalCosts DECIMAL (19, 2), @LegalCosts_UPDATE BIT, @LegalCostDetails VARCHAR (MAX), @LegalCostDetails_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @NewProjectsRegisterLastModifiedDatetime DATETIME, @NewProjectsRegisterLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


