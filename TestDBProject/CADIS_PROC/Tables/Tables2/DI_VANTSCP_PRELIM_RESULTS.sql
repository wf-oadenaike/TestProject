CREATE TABLE [CADIS_PROC].[DI_VANTSCP_PRELIM_RESULTS] (
    [ID]                                   INT            NOT NULL,
    [EDM_SHARECLASS_ID Populated?]         BIT            NULL,
    [Primary Key Unique?]                  BIT            NULL,
    [All Tests Passed?]                    BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY]               NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                 DATETIME       DEFAULT (getdate()) NULL,
    [EDM_SHARECLASS_ID Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [Primary Key Unique?__RULEID]          INT            DEFAULT ((0)) NOT NULL,
    [All Tests Passed?__RULEID]            INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                  NVARCHAR (MAX) NOT NULL,
    [STAGE EXISTS]                         BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

