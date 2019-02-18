﻿CREATE TABLE [dbo].[T_OVERRIDE_FND_SHARE_CLASS_FLOW] (
    [FUND_SHORT_NAME]           VARCHAR (15)    NULL,
    [FLOW_TYPE]                 VARCHAR (40)    NULL,
    [MCID]                      INT             NULL,
    [TRUSTEE]                   VARCHAR (50)    NULL,
    [VALUATION_POINT_DATE]      DATETIME        NOT NULL,
    [VALUATION_POINT_TIME]      VARCHAR (8000)  NULL,
    [FUND_LONG_NAME]            VARCHAR (100)   NULL,
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
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF__T_OVERRID__CADIS__38ED0B8C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF__T_OVERRID__CADIS__39E12FC5] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF__T_OVERRID__CADIS__3AD553FE] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF__T_OVERRID__CADIS__3BC97837] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF__T_OVERRID__CADIS__3CBD9C70] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    CONSTRAINT [PK__T_OVERRI__5128527D40D03523] PRIMARY KEY CLUSTERED ([VALUATION_POINT_DATE] ASC, [EXTERNAL_FUND_CODE] ASC, [FUND_REFERENCE] ASC) WITH (FILLFACTOR = 90)
);

