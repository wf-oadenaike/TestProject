﻿CREATE TABLE [Investment].[LiveFundPerformance] (
    [Id]                        INT             IDENTITY (1, 1) NOT NULL,
    [FundCode]                  VARCHAR (20)    NOT NULL,
    [ReportDate]                DATE            NOT NULL,
    [EndWeightPort]             DECIMAL (19, 5) NULL,
    [EndWeightBench]            DECIMAL (19, 5) NULL,
    [EndWeightDelta]            DECIMAL (19, 5) NULL,
    [RtnDayPort]                DECIMAL (19, 5) NULL,
    [RtnDayBench]               DECIMAL (19, 5) NULL,
    [RtnDayDelta]               DECIMAL (19, 5) NULL,
    [RtnWtdPort]                DECIMAL (19, 5) NULL,
    [RtnWtdBench]               DECIMAL (19, 5) NULL,
    [RtnWtdDelta]               DECIMAL (19, 5) NULL,
    [RtnMtdPort]                DECIMAL (19, 5) NULL,
    [RtnMtdBench]               DECIMAL (19, 5) NULL,
    [RtnMtdDelta]               DECIMAL (19, 5) NULL,
    [RtnQtdPort]                DECIMAL (19, 5) NULL,
    [RtnQtdBench]               DECIMAL (19, 5) NULL,
    [RtnQtdDelta]               DECIMAL (19, 5) NULL,
    [RtnYtdPort]                DECIMAL (19, 5) NULL,
    [RtnYtdBench]               DECIMAL (19, 5) NULL,
    [RtnYtdDelta]               DECIMAL (19, 5) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [df_lfp_csi] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [df_lfp_csu] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [df_lfp_cscb] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [df_lfp_csp] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [df_lfp_csl] DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [unq_lfp] UNIQUE NONCLUSTERED ([FundCode] ASC, [ReportDate] ASC)
);

