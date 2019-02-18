CREATE TABLE [CADIS_PROC].[DC_OSTCOV_INFO_RUNID] (
    [sfContactId]            VARCHAR (18) NOT NULL,
    [sfAccountId__RUNID]     INT          NOT NULL,
    [FcaId__RUNID]           INT          NOT NULL,
    [ContactMatrixId__RUNID] INT          NOT NULL,
    [AccountFCAid__RUNID]    INT          NOT NULL,
    [ContactOwnerId__RUNID]  INT          NOT NULL,
    [Salutation__RUNID]      INT          NOT NULL,
    [LastName__RUNID]        INT          NOT NULL,
    [FirstName__RUNID]       INT          NOT NULL,
    [Phone__RUNID]           INT          NOT NULL,
    [Mobile__RUNID]          INT          NOT NULL,
    [emailAddress__RUNID]    INT          NOT NULL,
    [ActiveStatus__RUNID]    INT          NOT NULL,
    [MailingStreet__RUNID]   INT          NOT NULL,
    [MailingCity__RUNID]     INT          NOT NULL,
    [MailingPostcode__RUNID] INT          NOT NULL,
    [MailingCountry__RUNID]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC) WITH (FILLFACTOR = 80)
);

