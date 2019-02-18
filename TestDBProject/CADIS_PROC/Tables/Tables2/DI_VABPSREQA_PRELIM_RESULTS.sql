CREATE TABLE [CADIS_PROC].[DI_VABPSREQA_PRELIM_RESULTS] (
    [SOURCE]                 VARCHAR (50)   NOT NULL,
    [SOURCE_ID]              VARCHAR (50)   NOT NULL,
    [Valid ISIN?]            BIT            NULL,
    [Valid SEDOL?]           BIT            NULL,
    [Valid CUSIP?]           BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [Valid ISIN?__RULEID]    INT            DEFAULT ((0)) NOT NULL,
    [Valid SEDOL?__RULEID]   INT            DEFAULT ((0)) NOT NULL,
    [Valid CUSIP?__RULEID]   INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]    NVARCHAR (MAX) NOT NULL,
    [REQUEST EXISTS]         BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [SOURCE_ID] ASC)
);

