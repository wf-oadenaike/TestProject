﻿CREATE TABLE [CADIS_SYS].[CO_PROCESSMONITOR] (
    [RUNTOKEN]     INT             IDENTITY (1, 1) NOT NULL,
    [PROCESSTYPE]  INT             NOT NULL,
    [GUID]         NCHAR (32)      NOT NULL,
    [WORKFLOWDATA] XML             NULL,
    [CRC]          NCHAR (64)      NULL,
    [STATUS]       INT             NOT NULL,
    [RUNID]        INT             NULL,
    [HIDDEN]       BIT             NOT NULL,
    [PARENTTOKEN]  INT             NULL,
    [CHANGEDBY]    NVARCHAR (100)  NOT NULL,
    [INSERTED]     DATETIME        NOT NULL,
    [UPDATED]      DATETIME        NOT NULL,
    [TIMESTAMP]    ROWVERSION      NOT NULL,
    [CMDLINE]      NVARCHAR (2000) NULL,
    [PLGUID]       NVARCHAR (32)   NULL,
    CONSTRAINT [PK_CO_PROCESSMONITOR] PRIMARY KEY CLUSTERED ([RUNTOKEN] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CO_PROCESSMONITOR_BY]
    ON [CADIS_SYS].[CO_PROCESSMONITOR]([CHANGEDBY] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CO_PROCESSMONITOR_RUNID]
    ON [CADIS_SYS].[CO_PROCESSMONITOR]([RUNID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CO_PROCESSMONITOR_PARENTTOKEN]
    ON [CADIS_SYS].[CO_PROCESSMONITOR]([PARENTTOKEN] ASC)
    INCLUDE([RUNTOKEN], [RUNID]);

