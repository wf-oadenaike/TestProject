CREATE TABLE [CADIS_PROC].[CO_BAK_PROCESSLOG_ARCHIVE_2015] (
    [RUNID]                 INT            NOT NULL,
    [COMPONENTID]           INT            NOT NULL,
    [GUID]                  NCHAR (32)     NOT NULL,
    [RUNSTART]              DATETIME       NULL,
    [RUNEND]                DATETIME       NULL,
    [RUNSUCCESSFUL]         TINYINT        NOT NULL,
    [LAUNCHEDBY]            VARCHAR (256)  NOT NULL,
    [PARENTRUNID]           INT            NULL,
    [LOGID]                 INT            NOT NULL,
    [LOGTIME]               DATETIME       NOT NULL,
    [LOGMESSAGE]            VARCHAR (1024) NOT NULL,
    [MESSAGETYPE]           TINYINT        NOT NULL,
    [CADIS_SYSTEM_ARCHIVED] DATETIME       NOT NULL
);

