CREATE TABLE [CADIS_PROC].[DC_UPPMFX_NT_PREP] (
    [FXRATE_ID]              VARCHAR (40)     NOT NULL,
    [FILE_NAME]              VARCHAR (70)     NOT NULL,
    [FILE_TYPE]              VARCHAR (20)     NULL,
    [FILE_DATE]              DATE             NULL,
    [CONSOLIDATION]          VARCHAR (20)     NULL,
    [ACCOUNT NUMBER]         VARCHAR (20)     NULL,
    [FROM DATE]              DATE             NOT NULL,
    [THROUGH DATE]           DATE             NOT NULL,
    [COUNTRY NAME]           VARCHAR (50)     NOT NULL,
    [CURRENCY NAME - ASSET]  VARCHAR (100)    NOT NULL,
    [C-BSE-CURR]             VARCHAR (20)     NULL,
    [CURRENCY CODE]          VARCHAR (20)     NOT NULL,
    [R-EXCH]                 DECIMAL (20, 10) NULL,
    [P-EXCH-RT-CHG]          DECIMAL (20, 10) NULL,
    [ERROR CODE]             VARCHAR (20)     NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_PRIORITY]  INT              NULL,
    PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [FROM DATE] ASC) WITH (FILLFACTOR = 80)
);

