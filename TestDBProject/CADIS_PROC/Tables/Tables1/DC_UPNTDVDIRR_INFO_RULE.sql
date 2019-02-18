CREATE TABLE [CADIS_PROC].[DC_UPNTDVDIRR_INFO_RULE] (
    [ACCOUNT_NUMBER]                  VARCHAR (50) NOT NULL,
    [DATE]                            DATETIME     NOT NULL,
    [CUSIP__RULEID]                   INT          NULL,
    [SEC_DESCRIPTION]                 VARCHAR (50) NOT NULL,
    [TOTAL_EQUITY__RULEID]            INT          NULL,
    [TOTAL_DEBT__RULEID]              INT          NULL,
    [INCOME_EXPENSE_TRANSFER__RULEID] INT          NULL,
    [REALIZED_EXCH_GL__RULEID]        INT          NULL,
    [UNREALIZED_EXCH_GL__RULEID]      INT          NULL,
    [EXCH_GAIN_LOSS__RULEID]          INT          NULL,
    [INCOME_DISTRIBUTIONS__RULEID]    INT          NULL,
    [EQL_CREATIONS__RULEID]           INT          NULL,
    [EQL_LIQUIDATIONS__RULEID]        INT          NULL,
    [CURRENT_NET_INCOME__RULEID]      INT          NULL,
    [UNITS_IN_ISSUE__RULEID]          INT          NULL,
    [SEDOL__RULEID]                   INT          NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [DATE] ASC, [SEC_DESCRIPTION] ASC)
);

