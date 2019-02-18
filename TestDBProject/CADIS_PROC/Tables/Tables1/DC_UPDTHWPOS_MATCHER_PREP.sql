CREATE TABLE [CADIS_PROC].[DC_UPDTHWPOS_MATCHER_PREP] (
    [CADIS Id]               INT            NOT NULL,
    [INSTRUMENT_UII]         VARCHAR (12)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL,
    [CADIS Inserted]         DATETIME       NOT NULL,
    [CADIS Updated]          DATETIME       NOT NULL,
    [CADIS Changed By]       NVARCHAR (100) NOT NULL,
    [CADIS Row Id]           INT            NOT NULL,
    [CADIS Revision]         INT            NOT NULL
);

