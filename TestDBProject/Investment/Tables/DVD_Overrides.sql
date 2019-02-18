CREATE TABLE [Investment].[DVD_Overrides] (
    [DVD_Overrides_ID]       INT             IDENTITY (1, 1) NOT NULL,
    [EDM_SEC_ID]             INT             NULL,
    [BBG_EX_DATE]            DATETIME        NULL,
    [OVERRIDE_EX_DATE]       DATETIME        NULL,
    [OVERRIDE_DVD_VALUE]     DECIMAL (18, 4) NULL,
    [OVERRIDE_COMMENTARY]    VARCHAR (50)    NULL,
    [OVERRIDE_REASON]        VARCHAR (50)    NULL,
    [IsActive]               BIT             NULL,
    [LAST_UPDATED_BY]        VARCHAR (50)    NULL,
    [LAST_UPDATED]           DATETIME        NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_DO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_DO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF_DO_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKDVD_Overrides] PRIMARY KEY CLUSTERED ([DVD_Overrides_ID] ASC)
);

