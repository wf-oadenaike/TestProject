CREATE TABLE [CADIS_PROC].[DC_UPNTDVDIRR_INFO_RUNID] (
    [ACCOUNT_NUMBER]                 VARCHAR (50) NOT NULL,
    [DATE]                           DATETIME     NOT NULL,
    [CUSIP__RUNID]                   INT          NOT NULL,
    [SEDOL__RUNID]                   INT          NOT NULL,
    [SEC_DESCRIPTION]                VARCHAR (50) NOT NULL,
    [TOTAL_EQUITY__RUNID]            INT          NOT NULL,
    [TOTAL_DEBT__RUNID]              INT          NOT NULL,
    [INCOME_EXPENSE_TRANSFER__RUNID] INT          NOT NULL,
    [REALIZED_EXCH_GL__RUNID]        INT          NOT NULL,
    [UNREALIZED_EXCH_GL__RUNID]      INT          NOT NULL,
    [EXCH_GAIN_LOSS__RUNID]          INT          NOT NULL,
    [INCOME_DISTRIBUTIONS__RUNID]    INT          NOT NULL,
    [EQL_CREATIONS__RUNID]           INT          NOT NULL,
    [EQL_LIQUIDATIONS__RUNID]        INT          NOT NULL,
    [CURRENT_NET_INCOME__RUNID]      INT          NOT NULL,
    [UNITS_IN_ISSUE__RUNID]          INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [DATE] ASC, [SEC_DESCRIPTION] ASC)
);

