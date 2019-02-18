CREATE TABLE [CADIS_PROC].[DC_OSTCOV_CONTACT_PREP] (
    [SfContactId]     NVARCHAR (1000) NOT NULL,
    [SfAccountId]     NVARCHAR (1000) NULL,
    [FcaId]           NVARCHAR (1000) NULL,
    [ContactMatrixId] NVARCHAR (1000) NULL,
    [AccountFcaId]    NVARCHAR (1000) NULL,
    [ContactOwnerId]  NVARCHAR (1000) NULL,
    [Salutation]      NVARCHAR (1000) NULL,
    [LastName]        NVARCHAR (1000) NULL,
    [FirstName]       NVARCHAR (1000) NULL,
    [Phone]           NVARCHAR (1000) NULL,
    [Mobile]          NVARCHAR (1000) NULL,
    [EmailAddress]    NVARCHAR (1000) NULL,
    [MailingStreet]   NVARCHAR (1000) NULL,
    [MailingCity]     NVARCHAR (1000) NULL,
    [MailingPostcode] NVARCHAR (1000) NULL,
    [MailingCountry]  NVARCHAR (1000) NULL,
    [IsActive]        VARCHAR (10)    NULL,
    PRIMARY KEY CLUSTERED ([SfContactId] ASC) WITH (FILLFACTOR = 80)
);

