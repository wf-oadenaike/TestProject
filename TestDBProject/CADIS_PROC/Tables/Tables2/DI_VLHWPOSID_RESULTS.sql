CREATE TABLE [CADIS_PROC].[DI_VLHWPOSID_RESULTS] (
    [Is Valid Sedol?]        BIT           NULL,
    [Is Valid Currency?]     BIT           NULL,
    [Is Valid Asset Class?]  BIT           NULL,
    [MODEL_CODE]             VARCHAR (20)  NOT NULL,
    [MODEL_DATE]             DATETIME      NOT NULL,
    [INSTRUMENT_UII]         VARCHAR (12)  NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_RUNID]     INT           DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT           DEFAULT ((0)) NOT NULL,
    [Is Valid PK?]           BIT           NULL,
    [All Tests Passed?]      BIT           NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [MODEL_DATE] ASC, [INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80)
);

