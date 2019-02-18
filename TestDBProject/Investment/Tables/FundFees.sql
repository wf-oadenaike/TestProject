CREATE TABLE [Investment].[FundFees] (
    [FUND_SHORT_NAME]           VARCHAR (7)   NOT NULL,
    [StartDate]                 DATE          NOT NULL,
    [EndDate]                   DATE          NULL,
    [ManagementFee]             FLOAT (53)    NULL,
    [PerformanceFee]            FLOAT (53)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_ff_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_ff_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_ff_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_ff_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_ff_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKFundFees] PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [StartDate] ASC)
);

