CREATE TABLE [CADIS_PROC].[DI_VTMASSEC_PRELIM_RESULTS] (
    [EDM_SEC_ID]                              INT            NOT NULL,
    [SECURITY_DESCRIPTION Populated?]         BIT            NULL,
    [SECURITY_NAME Populated?]                BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME       DEFAULT (getdate()) NULL,
    [SECURITY_DESCRIPTION Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [SECURITY_NAME Populated?__RULEID]        INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                     NVARCHAR (MAX) NOT NULL,
    [MASTER EXISTS]                           BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);

