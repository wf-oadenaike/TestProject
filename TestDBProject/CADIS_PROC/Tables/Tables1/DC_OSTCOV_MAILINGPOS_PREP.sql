CREATE TABLE [CADIS_PROC].[DC_OSTCOV_MAILINGPOS_PREP] (
    [sfContactId]         VARCHAR (18)   NOT NULL,
    [sf_FCAId]            VARCHAR (18)   NULL,
    [sf_ContractMatrixId] VARCHAR (18)   NULL,
    [sf_Value]            VARCHAR (2000) NULL,
    [mx_Value]            VARCHAR (2000) NULL,
    [OverrideChoice]      VARCHAR (10)   NULL,
    [OverrideValue]       VARCHAR (2000) NULL,
    [OverrideStatus]      VARCHAR (10)   NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC) WITH (FILLFACTOR = 80)
);

