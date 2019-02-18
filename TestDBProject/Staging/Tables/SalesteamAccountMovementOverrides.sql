CREATE TABLE [Staging].[SalesteamAccountMovementOverrides] (
    [SfAccountId]            VARCHAR (18)    NOT NULL,
    [Sector]                 VARCHAR (10)    NOT NULL,
    [AccountOwnerId]         VARCHAR (18)    NULL,
    [IsPriorityClient]       BIT             NULL,
    [Metrics]                VARCHAR (20)    NULL,
    [MoveValue]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_STAMO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_STAMO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF_STAMO_CSCB] DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

