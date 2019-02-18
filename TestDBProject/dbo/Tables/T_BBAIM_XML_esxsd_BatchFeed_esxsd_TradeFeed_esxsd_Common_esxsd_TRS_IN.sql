CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_TRS_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__32D8D1C3] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [esxsd:Counterparty]     NVARCHAR (MAX) NULL,
    [esxsd:ResetFrequency]   NVARCHAR (MAX) NULL,
    [esxsd:Benchmark]        NVARCHAR (MAX) NULL,
    [esxsd:BenchmarkSpread]  NVARCHAR (MAX) NULL,
    [esxsd:PayRcvIndicator]  NVARCHAR (MAX) NULL,
    [esxsd:DealId1]          NVARCHAR (MAX) NULL,
    [esxsd:DealId2]          NVARCHAR (MAX) NULL,
    [esxsd:FundingCcy]       NVARCHAR (MAX) NULL,
    [esxsd:FundingFXRate]    NVARCHAR (MAX) NULL,
    [esxsd:OrigTkt]          NVARCHAR (MAX) NULL,
    [esxsd:OrigOrder]        NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__33CCF5FC] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__34C11A35] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__35B53E6E] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__36A962A7] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_TRS_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

