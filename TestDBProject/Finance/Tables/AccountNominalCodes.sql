CREATE TABLE [Finance].[AccountNominalCodes] (
    [NominalCode]                    INT           NOT NULL,
    [AccountCategoryId]              SMALLINT      NULL,
    [AccountName]                    VARCHAR (128) NULL,
    [AccountNominalCodesCreatedDate] DATETIME      CONSTRAINT [df_anc_anccd] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKNominalCode] PRIMARY KEY CLUSTERED ([NominalCode] ASC),
    CONSTRAINT [AccountNominalCodesAccountCategoryId] FOREIGN KEY ([AccountCategoryId]) REFERENCES [Finance].[AccountCategories] ([AccountCategoryId])
);

