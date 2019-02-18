﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFFLOW_SS_PREP] (
    [FILE_NAME]                 VARCHAR (50)    NULL,
    [FILE_TYPE]                 VARCHAR (20)    NULL,
    [FILE_DATE]                 DATETIME        NULL,
    [FLOW_TYPE]                 VARCHAR (40)    NOT NULL,
    [NUMBER_OF_RECORDS]         VARCHAR (20)    NULL,
    [MCID]                      INT             NULL,
    [TRUSTEE]                   VARCHAR (50)    NULL,
    [VALUATION_POINT_DATE]      DATETIME        NOT NULL,
    [VALUATION_POINT_TIME]      VARCHAR (8000)  NULL,
    [FUND_LONG_NAME]            VARCHAR (100)   NOT NULL,
    [EXTERNAL_FUND_CODE]        VARCHAR (50)    NOT NULL,
    [FUND_REFERENCE]            VARCHAR (20)    NOT NULL,
    [BROUGHT_FORWARD_POSITION]  DECIMAL (20, 4) NULL,
    [NET_UNIT_MOVEMENT]         DECIMAL (20, 4) NULL,
    [BOOK_CONVERSION_IN]        DECIMAL (20, 4) NULL,
    [BOOK_CONVERSION_OUT]       DECIMAL (20, 4) NULL,
    [CONVERSION_FACTOR]         DECIMAL (20, 4) NULL,
    [ESTIMATED_CLOSING_BALANCE] DECIMAL (20, 4) NULL,
    [UNIT_DECISION]             DECIMAL (20, 4) NULL,
    [CASH_DECISION]             DECIMAL (20, 4) NULL,
    [CARRIED_FORWARD_BALANCE]   DECIMAL (20, 4) NULL,
    [BOOK_BASIS]                VARCHAR (5)     NULL,
    [DECISION_VALUE]            DECIMAL (20, 2) NULL,
    [INSPECIE_FLAG]             VARCHAR (20)    NULL,
    [NARRATIVE]                 VARCHAR (20)    NULL,
    [SIGNATORY]                 VARCHAR (20)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [FUND_SHORT_NAME]           VARCHAR (6)     NOT NULL,
    PRIMARY KEY CLUSTERED ([FLOW_TYPE] ASC, [VALUATION_POINT_DATE] ASC, [FUND_SHORT_NAME] ASC)
);
