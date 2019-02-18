CREATE TABLE [Core].[ThirdParties] (
    [ThirdPartyId]                   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ThirdPartyName]                 VARCHAR (128) NOT NULL,
    [ActiveFlag]                     BIT           CONSTRAINT [DF_TP_AF] DEFAULT ((1)) NOT NULL,
    [ControlId]                      BIGINT        NULL,
    [SourceSystemId]                 SMALLINT      NULL,
    [DisplayOrder]                   SMALLINT      NULL,
    [ThirdPartyCreationDatetime]     DATETIME      CONSTRAINT [DF_TP_TPCDT] DEFAULT (getdate()) NOT NULL,
    [ThirdPartyLastModifiedDatetime] DATETIME      CONSTRAINT [DF_TP_TPLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKThirdParties] PRIMARY KEY CLUSTERED ([ThirdPartyName] ASC),
    CONSTRAINT [ThirdPartiesSourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXThirdParties]
    ON [Core].[ThirdParties]([ThirdPartyId] ASC);

