CREATE TABLE [dbo].[T_BBG_RISK_MONITORING_IN_ALLOCATION] (
    [FileName]               VARCHAR (256)  NULL,
    [Fund]                   VARCHAR (256)  NULL,
    [Sector]                 VARCHAR (20)   NULL,
    [Port]                   VARCHAR (8000) NULL,
    [Bench]                  VARCHAR (8000) NULL,
    [PlusMinus]              VARCHAR (8000) NULL,
    [File Date]              VARCHAR (256)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT            NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT            NOT NULL
);

