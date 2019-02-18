CREATE TABLE [CADIS_PROC].[DC_OSTCOV_INFO_RULE] (
    [sfContactId]             VARCHAR (18) NOT NULL,
    [sfAccountId__RULEID]     INT          NULL,
    [FcaId__RULEID]           INT          NULL,
    [ContactMatrixId__RULEID] INT          NULL,
    [AccountFCAid__RULEID]    INT          NULL,
    [ContactOwnerId__RULEID]  INT          NULL,
    [Salutation__RULEID]      INT          NULL,
    [LastName__RULEID]        INT          NULL,
    [FirstName__RULEID]       INT          NULL,
    [Phone__RULEID]           INT          NULL,
    [Mobile__RULEID]          INT          NULL,
    [emailAddress__RULEID]    INT          NULL,
    [ActiveStatus__RULEID]    INT          NULL,
    [MailingStreet__RULEID]   INT          NULL,
    [MailingCity__RULEID]     INT          NULL,
    [MailingPostcode__RULEID] INT          NULL,
    [MailingCountry__RULEID]  INT          NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC)
);

