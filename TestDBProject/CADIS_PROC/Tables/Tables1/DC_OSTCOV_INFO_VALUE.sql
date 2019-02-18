CREATE TABLE [CADIS_PROC].[DC_OSTCOV_INFO_VALUE] (
    [sfContactId]            VARCHAR (18)   NOT NULL,
    [sfAccountId]            VARCHAR (18)   NULL,
    [FcaId]                  VARCHAR (100)  NULL,
    [ContactMatrixId]        VARCHAR (100)  NULL,
    [AccountFCAid]           VARCHAR (100)  NULL,
    [ContactOwnerId]         VARCHAR (50)   NULL,
    [Salutation]             VARCHAR (100)  NULL,
    [LastName]               NVARCHAR (100) NULL,
    [FirstName]              NVARCHAR (100) NULL,
    [Phone]                  VARCHAR (50)   NULL,
    [Mobile]                 VARCHAR (50)   NULL,
    [emailAddress]           VARCHAR (128)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [ActiveStatus]           VARCHAR (50)   NULL,
    [MailingStreet]          VARCHAR (1000) NULL,
    [MailingCity]            VARCHAR (100)  NULL,
    [MailingPostcode]        VARCHAR (100)  NULL,
    [MailingCountry]         VARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC)
);

