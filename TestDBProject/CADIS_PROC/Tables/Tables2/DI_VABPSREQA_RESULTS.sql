CREATE TABLE [CADIS_PROC].[DI_VABPSREQA_RESULTS] (
    [SOURCE]                 VARCHAR (50)  NOT NULL,
    [SOURCE_ID]              VARCHAR (50)  NOT NULL,
    [Valid ISIN?]            BIT           NULL,
    [Valid SEDOL?]           BIT           NULL,
    [Valid CUSIP?]           BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [SOURCE_ID] ASC)
);

