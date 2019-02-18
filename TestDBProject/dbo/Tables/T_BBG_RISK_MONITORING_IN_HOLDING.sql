CREATE TABLE [dbo].[T_BBG_RISK_MONITORING_IN_HOLDING] (
    [Fund]                   NVARCHAR (256) NULL,
    [Sector]                 NVARCHAR (256) NULL,
    [SubSector]              NVARCHAR (256) NULL,
    [Ticker]                 NVARCHAR (256) NULL,
    [Port]                   NVARCHAR (256) NULL,
    [Bench]                  NVARCHAR (256) NULL,
    [WgtPort]                NVARCHAR (256) NULL,
    [WgtBench]               NVARCHAR (256) NULL,
    [Wgt]                    NVARCHAR (256) NULL,
    [Market_Value]           NVARCHAR (256) NULL,
    [Position]               NVARCHAR (256) NULL,
    [ClosingPrice]           NVARCHAR (256) NULL,
    [Currency]               NVARCHAR (256) NULL,
    [Active_Share]           NVARCHAR (256) NULL,
    [FileName]               NVARCHAR (256) NULL,
    [FILE_DATE]              NVARCHAR (256) NULL,
    [FILE_TYPE]              VARCHAR (20)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL
);

