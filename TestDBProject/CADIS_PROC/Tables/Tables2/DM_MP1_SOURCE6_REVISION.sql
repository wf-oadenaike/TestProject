﻿CREATE TABLE [CADIS_PROC].[DM_MP1_SOURCE6_REVISION] (
    [MASTER_BROKER_NUMBER] VARCHAR (40) NOT NULL,
    [REVISION]             INT          NOT NULL,
    [REVISIONEFFECTIVE]    DATETIME     NOT NULL,
    [CADISID]              INT          NOT NULL,
    [CADISROWID]           INT          NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IDXDM_MP1_SOURCE6_REVISION]
    ON [CADIS_PROC].[DM_MP1_SOURCE6_REVISION]([MASTER_BROKER_NUMBER] ASC, [REVISION] ASC);
