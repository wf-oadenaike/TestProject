CREATE TABLE [CADIS_PROC].[DC_UPPREMSTIN_INFO_RULE] (
    [FUND_SHORT_NAME]         VARCHAR (50) NOT NULL,
    [EDM_SEC_ID]              INT          NOT NULL,
    [FUND_FISCAL_YEAR]        INT          NOT NULL,
    [FUND_FISCAL_QUARTER]     INT          NOT NULL,
    [EX_DATE__RULEID]         INT          NULL,
    [DVD_CCY__RULEID]         INT          NULL,
    [WITHHOLDING_TAX__RULEID] INT          NULL,
    [SPOT_RATE__RULEID]       INT          NULL,
    [DECLARED_DATE__RULEID]   INT          NULL,
    [POSITION_DATE__RULEID]   INT          NULL,
    [BID_PRICE__RULEID]       INT          NULL,
    [POSITION__RULEID]        INT          NULL,
    [MARKET_VALUE__RULEID]    INT          NULL,
    [RATE__RULEID]            INT          NULL,
    [NET_INCOME__RULEID]      INT          NULL,
    [TO_PAY__RULEID]          INT          NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC, [FUND_FISCAL_QUARTER] ASC) WITH (FILLFACTOR = 80)
);

