CREATE TABLE [Staging].[STG_Maturity] (
    [Name]           NVARCHAR (256) NULL,
    [Preferred Name] NVARCHAR (256) NULL,
    [Security Sedol] NVARCHAR (256) NULL,
    [Sector]         NVARCHAR (256) NULL,
    [Country]        NVARCHAR (256) NULL,
    [Maturity stage] NVARCHAR (256) NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_SM_MAT] DEFAULT (getdate()) NOT NULL
);

