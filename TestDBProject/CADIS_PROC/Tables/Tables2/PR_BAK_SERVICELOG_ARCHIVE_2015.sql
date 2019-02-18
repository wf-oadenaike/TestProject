CREATE TABLE [CADIS_PROC].[PR_BAK_SERVICELOG_ARCHIVE_2015] (
    [INSTANCE]              INT            NOT NULL,
    [COMPONENTID]           INT            NOT NULL,
    [GUID]                  NCHAR (32)     NULL,
    [LOGTIME]               DATETIME       NULL,
    [MESSAGETYPE]           TINYINT        NOT NULL,
    [HEADER]                NVARCHAR (500) NULL,
    [MESSAGE]               NVARCHAR (MAX) NULL,
    [MACHINENAME]           NVARCHAR (100) NULL,
    [USERNAME]              NVARCHAR (100) NULL,
    [CADIS_SYSTEM_ARCHIVED] DATETIME       NOT NULL
);

