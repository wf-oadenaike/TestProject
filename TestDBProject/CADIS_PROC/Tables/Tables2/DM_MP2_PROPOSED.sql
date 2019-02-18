﻿CREATE TABLE [CADIS_PROC].[DM_MP2_PROPOSED] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [SOURCEID]    INT            NOT NULL,
    [SOURCEROWID] INT            NOT NULL,
    [CADISID]     INT            NOT NULL,
    [PRIORITY]    TINYINT        DEFAULT ((2)) NOT NULL,
    [RULEID]      INT            NOT NULL,
    [INSERTED]    DATETIME       NOT NULL,
    [UPDATED]     DATETIME       NOT NULL,
    [CHANGEDBY]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_DM_MP2_PROPOSED] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_DM_RULE_DM_MP2_PROPOSED] FOREIGN KEY ([RULEID]) REFERENCES [CADIS_SYS].[DM_RULE] ([RULEID]),
    CONSTRAINT [FK_DM_SOURCE_DM_MP2_PROPOSED] FOREIGN KEY ([SOURCEID]) REFERENCES [CADIS_SYS].[DM_SOURCE] ([SOURCEID])
);

