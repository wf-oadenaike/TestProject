﻿CREATE TABLE [CADIS_PROC].[DC_OWNTEATYP_INFO_RULE] (
    [ACCOUNT_NUMBER]                     VARCHAR (255) NOT NULL,
    [SECURITY_NUMBER]                    VARCHAR (255) NOT NULL,
    [SECURITY_DESCRIPTION__RULEID]       INT           NULL,
    [SEDOL__RULEID]                      INT           NULL,
    [CUSIP__RULEID]                      INT           NULL,
    [COUNTRY_OF_TAXATION__RULEID]        INT           NULL,
    [STATE_CODE__RULEID]                 INT           NULL,
    [ASSET_GROUP__RULEID]                INT           NULL,
    [EX_DATE_SHARES__RULEID]             INT           NULL,
    [EX_DATE__RULEID]                    INT           NULL,
    [ACCRUED_INCOME__RULEID]             INT           NULL,
    [INCOME_RECEIVED__RULEID]            INT           NULL,
    [PRIOR_INC_ACCRUED__RULEID]          INT           NULL,
    [INCOME_EARNED__RULEID]              INT           NULL,
    [AMORT_ACCRUED__RULEID]              INT           NULL,
    [AMORT_SOLD__RULEID]                 INT           NULL,
    [PRIOR_AMORT_ACCRUED__RULEID]        INT           NULL,
    [AMORT_EARNED__RULEID]               INT           NULL,
    [TOTAL_INC_AND_AMORT_EARNED__RULEID] INT           NULL,
    [UNITS__RULEID]                      INT           NULL,
    [FUND_NET_INCOME__RULEID]            INT           NULL,
    [RATE__RULEID]                       INT           NULL,
    [FUND_FISCAL_YEAR__RULEID]           INT           NULL,
    [FUND_FISCAL_QUARTER__RULEID]        INT           NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [SECURITY_NUMBER] ASC) WITH (FILLFACTOR = 80)
);

