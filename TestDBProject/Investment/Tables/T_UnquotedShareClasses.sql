CREATE TABLE [Investment].[T_UnquotedShareClasses] (
    [ID]                INT             IDENTITY (1, 1) NOT NULL,
    [Name]              VARCHAR (255)   NULL,
    [IssuerID]          INT             NULL,
    [TotalSharesIssued] DECIMAL (18, 2) NULL
);

