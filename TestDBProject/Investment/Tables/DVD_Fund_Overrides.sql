CREATE TABLE [Investment].[DVD_Fund_Overrides] (
    [DVD_Fund_Overrides_ID]    INT             IDENTITY (1, 1) NOT NULL,
    [FUND_SHORT_NAME]          VARCHAR (50)    NOT NULL,
    [OVERRIDE_DATE]            DATETIME        NULL,
    [OVERRIDE_UNITS]           DECIMAL (18, 2) NULL,
    [OVERRIDE_GROSS_DVD_VALUE] DECIMAL (18, 2) NULL,
    [OVERRIDE_NET_DVD_VALUE]   DECIMAL (18, 2) NULL,
    [OVERRIDE_COMMENTARY]      VARCHAR (50)    NULL,
    [OVERRIDE_REASON]          VARCHAR (50)    NULL,
    [IsActive]                 BIT             NULL,
    [Qtr]                      INT             NULL,
    [Yr]                       INT             NULL,
    [LAST_UPDATED_BY]          VARCHAR (50)    NULL,
    [LAST_UPDATED]             DATETIME        NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME        CONSTRAINT [DF_DFO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME        CONSTRAINT [DF_DFO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50)   CONSTRAINT [DF_DFO_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKDVD_Fund_Overrides] PRIMARY KEY CLUSTERED ([DVD_Fund_Overrides_ID] ASC) WITH (FILLFACTOR = 80)
);

