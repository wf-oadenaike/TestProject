CREATE TABLE [CADIS_PROC].[DC_UPPLNOTIF_PROCESS_PREP] (
    [RUNID]              INT            NOT NULL,
    [COMPONENTID]        INT            NOT NULL,
    [RUNSTART]           DATETIME       NOT NULL,
    [RUNEND]             DATETIME       NULL,
    [RUNSUCCESSFUL]      BIT            NOT NULL,
    [LAUNCHEDBY]         NVARCHAR (256) NULL,
    [GUID]               NCHAR (32)     NOT NULL,
    [PARENTRUNID]        INT            NULL,
    [TOPLEVELRUNID]      INT            NULL,
    [RETURNCODE]         INT            NULL,
    [RUNPARAMS]          XML            NULL,
    [ITEMID]             NVARCHAR (50)  NULL,
    [FAILEDRUNID]        INT            NULL,
    [PROCESSTYPE]        NVARCHAR (100) NOT NULL,
    [PROCESSNAME]        NVARCHAR (260) NOT NULL,
    [RUNTIME]            DATETIME       NULL,
    [LASTLOGENTRY]       DATETIME       NULL,
    [TIMESINCELASTENTRY] DATETIME       NULL,
    [RUNCOMPLETE]        BIT            NULL,
    PRIMARY KEY CLUSTERED ([RUNID] ASC, [PROCESSTYPE] ASC, [PROCESSNAME] ASC) WITH (FILLFACTOR = 80)
);

