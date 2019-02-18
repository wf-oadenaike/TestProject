CREATE TABLE [Compliance].[PAAccountsRegister] (
    [PAAccountRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [AccountName]                   VARCHAR (255)    NOT NULL,
    [AccountNumber]                 VARCHAR (255)    NOT NULL,
    [Entity]                        VARCHAR (255)    NOT NULL,
    [OwnerId]                       SMALLINT         NOT NULL,
    [Active]                        BIT              CONSTRAINT [DF_PAAR_A] DEFAULT ((0)) NOT NULL,
    [InActiveDate]                  DATETIME         NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [PAAccountCreationDatetime]     DATETIME         CONSTRAINT [DF_PAAR_CDT] DEFAULT (getdate()) NOT NULL,
    [PAAccountLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PAAR_MDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_PAAR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_PAAR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_PAAR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_PAAR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_PAAR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPAAccountsRegister] PRIMARY KEY CLUSTERED ([PAAccountRegisterId] ASC),
    CONSTRAINT [PAAccountsRegisterOwnerId] FOREIGN KEY ([OwnerId]) REFERENCES [Core].[Persons] ([PersonId])
);

