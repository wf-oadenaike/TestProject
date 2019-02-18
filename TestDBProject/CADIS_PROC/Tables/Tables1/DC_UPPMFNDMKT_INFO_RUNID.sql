CREATE TABLE [CADIS_PROC].[DC_UPPMFNDMKT_INFO_RUNID] (
    [SOURCE]                                 VARCHAR (50)   NOT NULL,
    [POSITION_TYPE]                          VARCHAR (50)   NOT NULL,
    [FUND_SHORT_NAME]                        VARCHAR (8000) NOT NULL,
    [POSITION_DATE]                          DATETIME       NOT NULL,
    [TOTAL_MARKET_VALUE_LOCAL__RUNID]        INT            NOT NULL,
    [TOTAL_MARKET_VALUE_BASE__RUNID]         INT            NOT NULL,
    [STATUS__RUNID]                          INT            NOT NULL,
    [TOTAL_ACCRUED_MARKET_VALUE_BASE__RUNID] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC)
);

