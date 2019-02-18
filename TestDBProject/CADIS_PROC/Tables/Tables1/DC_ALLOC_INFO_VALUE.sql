CREATE TABLE [CADIS_PROC].[DC_ALLOC_INFO_VALUE] (
    [FileName]               VARCHAR (256)  NOT NULL,
    [Sector]                 VARCHAR (20)   NULL,
    [Port]                   VARCHAR (8000) NULL,
    [Bench]                  VARCHAR (8000) NULL,
    [PlusMinus]              VARCHAR (8000) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_RUNID]     INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([FileName] ASC) WITH (FILLFACTOR = 80)
);

