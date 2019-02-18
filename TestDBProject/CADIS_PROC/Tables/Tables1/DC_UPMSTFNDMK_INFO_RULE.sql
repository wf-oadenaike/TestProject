CREATE TABLE [CADIS_PROC].[DC_UPMSTFNDMK_INFO_RULE] (
    [SOURCE]                                  VARCHAR (50)   NOT NULL,
    [POSITION_TYPE]                           VARCHAR (50)   NOT NULL,
    [FUND_SHORT_NAME]                         VARCHAR (8000) NOT NULL,
    [POSITION_DATE]                           DATETIME       NOT NULL,
    [TOTAL_MARKET_VALUE_LOCAL__RULEID]        INT            NULL,
    [TOTAL_MARKET_VALUE_BASE__RULEID]         INT            NULL,
    [STATUS__RULEID]                          INT            NULL,
    [TOTAL_ACCRUED_MARKET_VALUE_BASE__RULEID] INT            NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC)
);

