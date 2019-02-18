CREATE TABLE [dbo].[T_PKGD_FILE_ACTION_AUDIT] (
    [NO]                     INT           NOT NULL,
    [BTNID]                  INT           NOT NULL,
    [ACTION]                 VARCHAR (20)  NULL,
    [FILENAME]               VARCHAR (200) NULL,
    [USER]                   VARCHAR (200) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([NO] ASC, [BTNID] ASC) WITH (FILLFACTOR = 80)
);

