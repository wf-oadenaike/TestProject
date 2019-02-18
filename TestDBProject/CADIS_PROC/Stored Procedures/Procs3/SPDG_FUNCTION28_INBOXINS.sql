CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION28_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ProjectNameBK NVARCHAR (128), @ProjectNameBK_UPDATE BIT, @RequestorRoleId SMALLINT, @RequestorRoleId_UPDATE BIT, @RequestorPersonId SMALLINT, @RequestorPersonId_UPDATE BIT, @ProjectOwnerRoleId SMALLINT, @ProjectOwnerRoleId_UPDATE BIT, @ProjectOwnerPersonId SMALLINT, @ProjectOwnerPersonId_UPDATE BIT, @OversightRoleId SMALLINT, @OversightRoleId_UPDATE BIT, @OversightPersonId SMALLINT, @OversightPersonId_UPDATE BIT, @RequestDate DATETIME, @RequestDate_UPDATE BIT, @ProposedStartDate DATE, @ProposedStartDate_UPDATE BIT, @EstimatedDuration SMALLINT, @EstimatedDuration_UPDATE BIT, @EstimatedDurationUnits VARCHAR (25), @EstimatedDurationUnits_UPDATE BIT, @EstimatedDurationDays SMALLINT, @EstimatedDurationDays_UPDATE BIT, @EstimatedCost DECIMAL (19, 5), @EstimatedCost_UPDATE BIT, @TechnologyInvolved BIT, @TechnologyInvolved_UPDATE BIT, @ProjectApproved BIT, @ProjectApproved_UPDATE BIT, @StrategicProject BIT, @StrategicProject_UPDATE BIT, @ProjectPurpose VARCHAR (2048), @ProjectPurpose_UPDATE BIT, @ProjectScope VARCHAR (2048), @ProjectScope_UPDATE BIT, @Dependences VARCHAR (2048), @Dependences_UPDATE BIT, @ExternalResources VARCHAR (2048), @ExternalResources_UPDATE BIT, @AdditionalDetails VARCHAR (2048), @AdditionalDetails_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ProjectCreationDate DATETIME, @ProjectCreationDate_UPDATE BIT, @ProjectLastModifiedDate DATETIME, @ProjectLastModifiedDate_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


