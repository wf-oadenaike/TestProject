CREATE TABLE [CADIS_PROC].[DI_VANTSCP_RESULTS] (
    [ID]                           INT           NOT NULL,
    [EDM_SHARECLASS_ID Populated?] BIT           NULL,
    [Primary Key Unique?]          BIT           NULL,
    [All Tests Passed?]            BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

