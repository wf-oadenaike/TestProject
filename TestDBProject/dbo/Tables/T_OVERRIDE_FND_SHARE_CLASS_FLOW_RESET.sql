﻿CREATE TABLE [dbo].[T_OVERRIDE_FND_SHARE_CLASS_FLOW_RESET] (
    [FUND_SHORT_NAME]           BIT           NULL,
    [FLOW_TYPE]                 BIT           NULL,
    [MCID]                      BIT           NULL,
    [TRUSTEE]                   BIT           NULL,
    [VALUATION_POINT_DATE]      DATETIME      NOT NULL,
    [VALUATION_POINT_TIME]      BIT           NULL,
    [FUND_LONG_NAME]            BIT           NULL,
    [EXTERNAL_FUND_CODE]        VARCHAR (50)  NOT NULL,
    [FUND_REFERENCE]            VARCHAR (20)  NOT NULL,
    [BROUGHT_FORWARD_POSITION]  BIT           NULL,
    [NET_UNIT_MOVEMENT]         BIT           NULL,
    [BOOK_CONVERSION_IN]        BIT           NULL,
    [BOOK_CONVERSION_OUT]       BIT           NULL,
    [CONVERSION_FACTOR]         BIT           NULL,
    [ESTIMATED_CLOSING_BALANCE] BIT           NULL,
    [UNIT_DECISION]             BIT           NULL,
    [CASH_DECISION]             BIT           NULL,
    [CARRIED_FORWARD_BALANCE]   BIT           NULL,
    [BOOK_BASIS]                BIT           NULL,
    [DECISION_VALUE]            BIT           NULL,
    [INSPECIE_FLAG]             BIT           NULL,
    [NARRATIVE]                 BIT           NULL,
    [SIGNATORY]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__713164AF] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__722588E8] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_OVERRID__CADIS__7319AD21] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_OVERRID__CADIS__740DD15A] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__7501F593] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    CONSTRAINT [PK__T_OVERRI__5128527D17718C70] PRIMARY KEY CLUSTERED ([VALUATION_POINT_DATE] ASC, [EXTERNAL_FUND_CODE] ASC, [FUND_REFERENCE] ASC) WITH (FILLFACTOR = 90)
);

