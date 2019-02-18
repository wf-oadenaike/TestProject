CREATE TABLE [CADIS_PROC].[DC_UPMSTDVDFC_RESET_PREP] (
    [Fund Short Name]        VARCHAR (20)  NOT NULL,
    [EDM_SEC_ID]             INT           NOT NULL,
    [Calendar Year]          INT           NOT NULL,
    [Q1 Rate]                BIT           NULL,
    [Q2 Rate]                BIT           NULL,
    [Q3 Rate]                BIT           NULL,
    [Q4 Rate]                BIT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Fund Short Name] ASC, [EDM_SEC_ID] ASC, [Calendar Year] ASC) WITH (FILLFACTOR = 80)
);

