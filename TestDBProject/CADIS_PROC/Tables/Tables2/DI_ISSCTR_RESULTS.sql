CREATE TABLE [CADIS_PROC].[DI_ISSCTR_RESULTS] (
    [IsValidSEDOL]           BIT           NULL,
    [PortfolioGroup]         VARCHAR (250) NOT NULL,
    [ReportDate]             DATETIME      NOT NULL,
    [Security]               VARCHAR (250) NOT NULL,
    [All Tests Passed?]      BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_RUNID]     INT           DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([PortfolioGroup] ASC, [ReportDate] ASC, [Security] ASC) WITH (FILLFACTOR = 80)
);

