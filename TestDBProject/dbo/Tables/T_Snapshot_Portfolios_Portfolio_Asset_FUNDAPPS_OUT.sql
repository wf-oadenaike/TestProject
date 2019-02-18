CREATE TABLE [dbo].[T_Snapshot_Portfolios_Portfolio_Asset_FUNDAPPS_OUT] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_Snapsho__CADIS__2BB86996] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [AssetId]                NVARCHAR (MAX) NULL,
    [AssetName]              NVARCHAR (MAX) NULL,
    [InstrumentId]           NVARCHAR (MAX) NULL,
    [Quantity]               NVARCHAR (MAX) NULL,
    [Asset_InnerText]        NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_Snapsho__CADIS__2CAC8DCF] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_Snapsho__CADIS__2DA0B208] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_Snapsho__CADIS__2E94D641] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_Snapsho__CADIS__2F88FA7A] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_Snapshot_Portfolios_Portfolio_Asset_FUNDAPPS_OUT] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

