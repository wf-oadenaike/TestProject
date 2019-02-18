CREATE TABLE [Investment].[T_REF_UnquotedCompanyReferralStatus] (
    [ID]     SMALLINT     NOT NULL,
    [Status] VARCHAR (50) NOT NULL,
    [Order]  SMALLINT     NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

