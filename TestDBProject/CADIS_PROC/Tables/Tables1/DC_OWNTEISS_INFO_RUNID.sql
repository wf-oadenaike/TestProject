﻿CREATE TABLE [CADIS_PROC].[DC_OWNTEISS_INFO_RUNID] (
    [VALUATION_DATE]                    DATETIME     NOT NULL,
    [FUND_SHORT_NAME]                   VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]                        INT          NOT NULL,
    [FUND_FISCAL_YEAR]                  INT          NOT NULL,
    [FUND_FISCAL_QUARTER]               INT          NOT NULL,
    [ACCOUNT_NUMBER__RUNID]             INT          NOT NULL,
    [SECURITY_NUMBER__RUNID]            INT          NOT NULL,
    [SECURITY_DESCRIPTION__RUNID]       INT          NOT NULL,
    [SEDOL__RUNID]                      INT          NOT NULL,
    [CUSIP__RUNID]                      INT          NOT NULL,
    [COUNTRY_OF_TAXATION__RUNID]        INT          NOT NULL,
    [STATE_CODE__RUNID]                 INT          NOT NULL,
    [ASSET_GROUP__RUNID]                INT          NOT NULL,
    [EX_DATE_SHARES__RUNID]             INT          NOT NULL,
    [EX_DATE__RUNID]                    INT          NOT NULL,
    [ACCRUED_INCOME__RUNID]             INT          NOT NULL,
    [INCOME_RECEIVED__RUNID]            INT          NOT NULL,
    [PRIOR_INC_ACCRUED__RUNID]          INT          NOT NULL,
    [INCOME_EARNED__RUNID]              INT          NOT NULL,
    [AMORT_ACCRUED__RUNID]              INT          NOT NULL,
    [AMORT_SOLD__RUNID]                 INT          NOT NULL,
    [PRIOR_AMORT_ACCRUED__RUNID]        INT          NOT NULL,
    [AMORT_EARNED__RUNID]               INT          NOT NULL,
    [TOTAL_INC_AND_AMORT_EARNED__RUNID] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_DATE] ASC, [FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC, [FUND_FISCAL_QUARTER] ASC) WITH (FILLFACTOR = 80)
);

