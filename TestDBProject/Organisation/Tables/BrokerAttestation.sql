CREATE TABLE [Organisation].[BrokerAttestation] (
    [BrokerAttestationId]                   INT              IDENTITY (1, 1) NOT NULL,
    [Year]                                  VARCHAR (10)     NOT NULL,
    [BloombergId]                           VARCHAR (40)     NULL,
    [BrokerServiceType]                     VARCHAR (50)     NOT NULL,
    [AttestationStatus]                     VARCHAR (50)     NOT NULL,
    [FollowUpDetails]                       VARCHAR (255)    NULL,
    [ReviewedByPersonId]                    SMALLINT         CONSTRAINT [DF_BA_BASP] DEFAULT ((-1)) NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [BrokerAttestationCreationDatetime]     DATETIME         CONSTRAINT [DF_BA_BACD] DEFAULT (getdate()) NOT NULL,
    [BrokerAttestationLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BA_BALMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_BA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_BA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_BA_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_BA_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_BA_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKBrokerAttestation] PRIMARY KEY CLUSTERED ([BrokerAttestationId] ASC),
    CONSTRAINT [BrokerAttestationReviewedByPersonId] FOREIGN KEY ([ReviewedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

