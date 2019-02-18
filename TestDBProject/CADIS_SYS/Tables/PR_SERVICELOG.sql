﻿CREATE TABLE [CADIS_SYS].[PR_SERVICELOG] (
    [LOGID]       INT             IDENTITY (1, 1) NOT NULL,
    [INSTANCE]    INT             NOT NULL,
    [COMPONENTID] INT             NOT NULL,
    [GUID]        NCHAR (32)      NULL,
    [LOGTIME]     DATETIME        CONSTRAINT [DF_PR_SERVICELOG_LOGTIME] DEFAULT (getdate()) NOT NULL,
    [MESSAGETYPE] TINYINT         NOT NULL,
    [HEADER]      NVARCHAR (500)  NULL,
    [MESSAGE]     NVARCHAR (1024) NULL,
    [MACHINENAME] NVARCHAR (100)  NULL,
    [USERNAME]    NVARCHAR (100)  NULL,
    CONSTRAINT [PK_PR_SERVICELOG] PRIMARY KEY CLUSTERED ([LOGID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PR_SERVICELOG]
    ON [CADIS_SYS].[PR_SERVICELOG]([COMPONENTID] ASC, [GUID] ASC);
