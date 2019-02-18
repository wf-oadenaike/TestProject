CREATE TABLE [dbo].[zzz_Sales_BP_AccountOverride] (
    [sf_SfAccountId]         VARCHAR (18)   NOT NULL,
    [DataField]              VARCHAR (50)   NOT NULL,
    [sf_FCAId]               VARCHAR (100)  NULL,
    [sf_OutletId]            VARCHAR (50)   NULL,
    [sf_Value]               VARCHAR (2000) NULL,
    [mx_Value]               VARCHAR (2000) NULL,
    [OverrideValue]          VARCHAR (2000) NULL,
    [OverrideChoice]         VARCHAR (10)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL
);

