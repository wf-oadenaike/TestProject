CREATE TABLE [Staging].[Accruals] (
    [Date]                  VARCHAR (50)  NULL,
    [Supplier]              VARCHAR (50)  NULL,
    [NominalCode]           VARCHAR (50)  NULL,
    [DepartmentNumber]      VARCHAR (50)  NULL,
    [ShortDescription]      VARCHAR (50)  NULL,
    [Balance]               VARCHAR (250) NULL,
    [BalanceBroughtForward] VARCHAR (250) NULL,
    [Apr]                   VARCHAR (250) NULL,
    [May]                   VARCHAR (250) NULL,
    [June]                  VARCHAR (250) NULL,
    [July]                  VARCHAR (250) NULL,
    [August]                VARCHAR (50)  NULL,
    [September]             VARCHAR (50)  NULL,
    [October]               VARCHAR (50)  NULL,
    [November]              VARCHAR (50)  NULL,
    [December]              VARCHAR (50)  NULL,
    [January]               VARCHAR (50)  NULL,
    [February]              VARCHAR (50)  NULL,
    [March]                 VARCHAR (50)  NULL,
    [RowId]                 INT           IDENTITY (1, 1) NOT NULL
);

