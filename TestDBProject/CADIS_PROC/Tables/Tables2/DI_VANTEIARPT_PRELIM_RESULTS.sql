CREATE TABLE [CADIS_PROC].[DI_VANTEIARPT_PRELIM_RESULTS] (
    [Primary Key Unique?]                     BIT            NULL,
    [Fund Short Name Mapping Exists?]         BIT            NULL,
    [EDM_SEC_ID Mapping Exists?]              BIT            NULL,
    [ID]                                      INT            NOT NULL,
    [FUND_FISCAL_YEAR Populated?]             BIT            NULL,
    [FUND_FISCAL_QUARTER Populated?]          BIT            NULL,
    [All Tests Passed?]                       BIT            NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME       DEFAULT (getdate()) NULL,
    [Primary Key Unique?__RULEID]             INT            DEFAULT ((0)) NOT NULL,
    [Fund Short Name Mapping Exists?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [EDM_SEC_ID Mapping Exists?__RULEID]      INT            DEFAULT ((0)) NOT NULL,
    [FUND_FISCAL_YEAR Populated?__RULEID]     INT            DEFAULT ((0)) NOT NULL,
    [FUND_FISCAL_QUARTER Populated?__RULEID]  INT            DEFAULT ((0)) NOT NULL,
    [All Tests Passed?__RULEID]               INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                     NVARCHAR (MAX) NOT NULL,
    [STAGE EXISTS]                            BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

