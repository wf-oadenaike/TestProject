﻿CREATE TABLE [CADIS_PROC].[DC_UPMASCFLOW_INFO_RULE] (
    [FUND_SHORT_NAME__RULEID]           INT          NULL,
    [FLOW_TYPE__RULEID]                 INT          NULL,
    [MCID__RULEID]                      INT          NULL,
    [TRUSTEE__RULEID]                   INT          NULL,
    [VALUATION_POINT_DATE]              DATETIME     NOT NULL,
    [VALUATION_POINT_TIME__RULEID]      INT          NULL,
    [FUND_LONG_NAME__RULEID]            INT          NULL,
    [EXTERNAL_FUND_CODE]                VARCHAR (50) NOT NULL,
    [FUND_REFERENCE]                    VARCHAR (20) NOT NULL,
    [BROUGHT_FORWARD_POSITION__RULEID]  INT          NULL,
    [NET_UNIT_MOVEMENT__RULEID]         INT          NULL,
    [BOOK_CONVERSION_IN__RULEID]        INT          NULL,
    [BOOK_CONVERSION_OUT__RULEID]       INT          NULL,
    [CONVERSION_FACTOR__RULEID]         INT          NULL,
    [ESTIMATED_CLOSING_BALANCE__RULEID] INT          NULL,
    [UNIT_DECISION__RULEID]             INT          NULL,
    [CASH_DECISION__RULEID]             INT          NULL,
    [CARRIED_FORWARD_BALANCE__RULEID]   INT          NULL,
    [BOOK_BASIS__RULEID]                INT          NULL,
    [DECISION_VALUE__RULEID]            INT          NULL,
    [INSPECIE_FLAG__RULEID]             INT          NULL,
    [NARRATIVE__RULEID]                 INT          NULL,
    [SIGNATORY__RULEID]                 INT          NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_POINT_DATE] ASC, [EXTERNAL_FUND_CODE] ASC, [FUND_REFERENCE] ASC)
);
