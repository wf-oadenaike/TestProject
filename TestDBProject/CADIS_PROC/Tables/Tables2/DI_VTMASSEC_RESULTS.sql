CREATE TABLE [CADIS_PROC].[DI_VTMASSEC_RESULTS] (
    [EDM_SEC_ID]                      INT           NOT NULL,
    [SECURITY_DESCRIPTION Populated?] BIT           NULL,
    [SECURITY_NAME Populated?]        BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);

