CREATE TABLE [dbo].[T_TCA_Exceptions_BenchmarkData] (
    [BenchmarkName]         VARCHAR (20)     NOT NULL,
    [BenchmarkField]        VARCHAR (20)     NULL,
    [LowerThreshold]        DECIMAL (24, 10) NULL,
    [UpperThreshold]        DECIMAL (24, 10) NULL,
    [LowerExceptionMessage] VARCHAR (20)     NULL,
    [UpperExceptionMessage] VARCHAR (20)     NULL,
    CONSTRAINT [PK_T_TCA_Exceptions_BenchmarkData] PRIMARY KEY CLUSTERED ([BenchmarkName] ASC) WITH (FILLFACTOR = 90)
);

