CREATE TABLE [Unquoted].[RevaluationInstructions] (
    [BloombergUniqueId]         VARCHAR (30)   NOT NULL,
    [EffectiveDate]             DATE           NOT NULL,
    [SecurityName]              NVARCHAR (127) NOT NULL,
    [CurrencyCode]              CHAR (3)       NOT NULL,
    [PreviousPrice]             FLOAT (53)     NULL,
    [UpdatedPrice]              FLOAT (53)     NOT NULL,
    [Source]                    VARCHAR (63)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_ri_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_ri_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF_ri_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_ri_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_ri_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKRevaluationInstructions] PRIMARY KEY NONCLUSTERED ([BloombergUniqueId] ASC, [EffectiveDate] ASC)
);

