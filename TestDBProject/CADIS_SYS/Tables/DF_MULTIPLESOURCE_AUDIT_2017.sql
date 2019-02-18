CREATE TABLE [CADIS_SYS].[DF_MULTIPLESOURCE_AUDIT_2017] (
    [ID]                    INT           IDENTITY (1, 1) NOT NULL,
    [PROCESSNAME]           VARCHAR (260) NULL,
    [SOURCENAME]            VARCHAR (200) NULL,
    [RUNID]                 INT           NULL,
    [RUNTIME]               DATETIME      NULL,
    [STATUS]                INT           NULL,
    [CADIS_SYSTEM_ARCHIVED] DATETIME      NOT NULL
);

