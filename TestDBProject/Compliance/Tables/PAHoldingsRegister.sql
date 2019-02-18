CREATE TABLE [Compliance].[PAHoldingsRegister] (
    [PAHoldingRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [SecurityName]                  VARCHAR (255)    NOT NULL,
    [SecurityType]                  VARCHAR (255)    NOT NULL,
    [SecurityIdentifier]            VARCHAR (255)    NOT NULL,
    [OwnerId]                       SMALLINT         NOT NULL,
    [Active]                        BIT              CONSTRAINT [DF_PAHR_A] DEFAULT ((0)) NOT NULL,
    [InActiveDate]                  DATETIME         NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [PAHoldingCreationDatetime]     DATETIME         CONSTRAINT [DF_PAHR_CDT] DEFAULT (getdate()) NOT NULL,
    [PAHoldingLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PAHR_LMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_PAHR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_PAHR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_PAHR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_PAHR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_PAHR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPAHoldingsRegister] PRIMARY KEY CLUSTERED ([PAHoldingRegisterId] ASC),
    CONSTRAINT [PAHoldingsRegisterOwnerId] FOREIGN KEY ([OwnerId]) REFERENCES [Core].[Persons] ([PersonId])
);

