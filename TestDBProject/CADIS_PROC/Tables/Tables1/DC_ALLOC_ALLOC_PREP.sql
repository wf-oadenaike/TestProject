﻿CREATE TABLE [CADIS_PROC].[DC_ALLOC_ALLOC_PREP] (
    [FileName]               VARCHAR (256)  NOT NULL,
    [Sector]                 VARCHAR (20)   NULL,
    [Port]                   VARCHAR (8000) NULL,
    [Bench]                  VARCHAR (8000) NULL,
    [PlusMinus]              VARCHAR (8000) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT            NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([FileName] ASC) WITH (FILLFACTOR = 80)
);

