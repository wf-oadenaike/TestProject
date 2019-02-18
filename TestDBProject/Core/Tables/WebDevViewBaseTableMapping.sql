CREATE TABLE [Core].[WebDevViewBaseTableMapping] (
    [ViewName]          VARCHAR (100) NOT NULL,
    [BaseTable]         VARCHAR (100) NOT NULL,
    [DataGeneratorName] VARCHAR (100) NULL,
    [HasUI]             BIT           CONSTRAINT [df_wdvbtm_hui] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PKWebDevViewBaseTableMapping] PRIMARY KEY CLUSTERED ([ViewName] ASC, [BaseTable] ASC)
);

