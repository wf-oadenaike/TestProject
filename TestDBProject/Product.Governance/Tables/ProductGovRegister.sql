CREATE TABLE [Product.Governance].[ProductGovRegister] (
    [ProductGovRegisterId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ProductName]                            VARCHAR (128)    NOT NULL,
    [ProductGovStatus]                       VARCHAR (128)    NOT NULL,
    [ProductLaunchedYesNo]                   BIT              CONSTRAINT [DF_PGR_PLYN] DEFAULT ((0)) NOT NULL,
    [DocumentationFolderLink]                VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                    UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NOT NULL,
    [ProductGovRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_PGR_PGRCDT] DEFAULT (getdate()) NOT NULL,
    [ProductGovRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PGR_PGRLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKProductGovRegister] PRIMARY KEY CLUSTERED ([ProductName] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovRegister]
    ON [Product.Governance].[ProductGovRegister]([ProductGovRegisterId] ASC);

