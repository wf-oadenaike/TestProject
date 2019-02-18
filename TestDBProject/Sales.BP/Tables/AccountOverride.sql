CREATE TABLE [Sales.BP].[AccountOverride] (
    [sf_SfAccountId]         VARCHAR (18)   NOT NULL,
    [DataField]              VARCHAR (50)   NOT NULL,
    [sf_FCAId]               VARCHAR (100)  NULL,
    [sf_OutletId]            VARCHAR (50)   NULL,
    [sf_Value]               VARCHAR (2000) NULL,
    [mx_Value]               VARCHAR (2000) NULL,
    [OverrideValue]          VARCHAR (2000) NULL,
    [OverrideChoice]         VARCHAR (10)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF_SBAO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF_SBAO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF_SBAO_CSCB] DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([sf_SfAccountId] ASC, [DataField] ASC)
);

