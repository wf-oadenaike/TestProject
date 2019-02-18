CREATE TABLE [Core].[StaticSpreadsheetConfig] (
    [ReportName]    VARCHAR (255) NOT NULL,
    [SourceFolder]  VARCHAR (500) NOT NULL,
    [DataStartsAt]  INT           NOT NULL,
    [REportDateRow] INT           NOT NULL,
    [REportDateCol] INT           NOT NULL,
    [F1]            VARCHAR (MAX) NULL,
    [F2]            VARCHAR (MAX) NULL,
    [F3]            VARCHAR (MAX) NULL,
    [F4]            VARCHAR (MAX) NULL,
    [F5]            VARCHAR (MAX) NULL,
    [F6]            VARCHAR (MAX) NULL,
    [F7]            VARCHAR (MAX) NULL,
    [F8]            VARCHAR (MAX) NULL,
    [F9]            VARCHAR (MAX) NULL,
    [F10]           VARCHAR (MAX) NULL,
    CONSTRAINT [PKStaticSpreadsheetConfig] PRIMARY KEY CLUSTERED ([ReportName] ASC)
);

