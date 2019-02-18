CREATE TABLE [CADIS_PROC].[DC_UPPREMSTIN_BBG_PREP] (
    [FUND_SHORT_NAME]     VARCHAR (50)     NOT NULL,
    [EDM_SEC_ID]          INT              NOT NULL,
    [FUND_FISCAL_YEAR]    INT              NOT NULL,
    [FUND_FISCAL_QUARTER] INT              NOT NULL,
    [EX_DATE]             DATE             NULL,
    [DVD_CCY]             VARCHAR (10)     NULL,
    [WITHHOLDING_TAX]     DECIMAL (26, 6)  NOT NULL,
    [SPOT_RATE]           DECIMAL (24, 16) NOT NULL,
    [DECLARED_DATE]       DATE             NULL,
    [POSITION_DATE]       DATE             NULL,
    [POSITION]            DECIMAL (20, 6)  NULL,
    [RATE]                DECIMAL (20, 6)  NULL,
    [NET_INCOME]          DECIMAL (38, 6)  NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC, [FUND_FISCAL_QUARTER] ASC) WITH (FILLFACTOR = 80)
);

