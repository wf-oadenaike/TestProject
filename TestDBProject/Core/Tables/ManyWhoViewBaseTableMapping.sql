CREATE TABLE [Core].[ManyWhoViewBaseTableMapping] (
    [ViewName]          VARCHAR (100) NOT NULL,
    [BaseTable]         VARCHAR (100) NOT NULL,
    [DataGeneratorName] VARCHAR (100) NULL,
    [HasUI]             BIT           CONSTRAINT [df_mwvbtm_hui] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PKManyWhoViewBaseTableMapping] PRIMARY KEY CLUSTERED ([ViewName] ASC, [BaseTable] ASC)
);

