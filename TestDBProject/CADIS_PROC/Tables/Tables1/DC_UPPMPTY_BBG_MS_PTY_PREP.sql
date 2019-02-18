CREATE TABLE [CADIS_PROC].[DC_UPPMPTY_BBG_MS_PTY_PREP] (
    [ACTIVE]                    INT            NOT NULL,
    [APPROVED]                  INT            NOT NULL,
    [CADIS Id]                  INT            NOT NULL,
    [CADIS Priority]            TINYINT        NOT NULL,
    [MASTER_BROKER_NUMBER]      VARCHAR (40)   NOT NULL,
    [MASTER_BROKER_SHORT_NAME]  VARCHAR (40)   NULL,
    [MASTER_BROKER_LONG_NAME]   VARCHAR (40)   NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       NULL,
    [CADIS Inserted]            DATETIME       NOT NULL,
    [CADIS Updated]             DATETIME       NOT NULL,
    [CADIS Changed By]          NVARCHAR (100) NOT NULL,
    [CADIS Row Id]              INT            NOT NULL,
    [CADIS Revision]            INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([CADIS Id] ASC) WITH (FILLFACTOR = 80)
);

