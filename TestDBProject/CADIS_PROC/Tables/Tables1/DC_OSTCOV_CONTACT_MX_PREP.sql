CREATE TABLE [CADIS_PROC].[DC_OSTCOV_CONTACT_MX_PREP] (
    [SfContactId]     VARCHAR (18)  NOT NULL,
    [SfAccountId]     VARCHAR (18)  NULL,
    [FcaId]           VARCHAR (20)  NULL,
    [ContactMatrixId] VARCHAR (20)  NULL,
    [AccountFcaId]    VARCHAR (20)  NULL,
    [ContactOwnerId]  VARCHAR (18)  NULL,
    [Salutation]      VARCHAR (20)  NULL,
    [LastName]        VARCHAR (100) NULL,
    [FirstName]       VARCHAR (100) NULL,
    [Phone]           VARCHAR (50)  NULL,
    [Mobile]          VARCHAR (50)  NULL,
    [EmailAddress]    VARCHAR (128) NULL,
    [MfidStatus]      VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([SfContactId] ASC) WITH (FILLFACTOR = 80)
);

