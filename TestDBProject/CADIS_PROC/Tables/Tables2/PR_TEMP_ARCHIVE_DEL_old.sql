CREATE TABLE [CADIS_PROC].[PR_TEMP_ARCHIVE_DEL_old] (
    [LOGID]                 INT             IDENTITY (1, 1) NOT NULL,
    [INSTANCE]              INT             NOT NULL,
    [COMPONENTID]           INT             NOT NULL,
    [GUID]                  NCHAR (32)      NULL,
    [LOGTIME]               DATETIME        NOT NULL,
    [MESSAGETYPE]           TINYINT         NOT NULL,
    [HEADER]                NVARCHAR (500)  NULL,
    [MESSAGE]               NVARCHAR (1024) NULL,
    [MACHINENAME]           NVARCHAR (100)  NULL,
    [USERNAME]              NVARCHAR (100)  NULL,
    [CADIS_SYSTEM_ARCHIVED] DATETIME        NULL
);

