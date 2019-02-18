﻿CREATE TABLE [CADIS_PROC].[DC_OWNTEISTG_VALID_PREP] (
    [FUND_SHORT_NAME]            VARCHAR (20)     NOT NULL,
    [EDM_SEC_ID]                 INT              NOT NULL,
    [Primary Key Unique?]        BIT              NULL,
    [Fund Short Name Exists?]    BIT              NULL,
    [SEDOL Populated?]           BIT              NULL,
    [SEDOL Valid?]               BIT              NULL,
    [EDM_SEC_ID Exists?]         BIT              NULL,
    [EX DATE Populated?]         BIT              NULL,
    [All Tests Passed?]          BIT              NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME         NULL,
    [TARGET_PK_COUNT]            BIGINT           NULL,
    [TARGET_PK_COLUMNS]          VARCHAR (47)     NOT NULL,
    [TARGET_PK_VALUE]            VARCHAR (271)    NULL,
    [SOURCE_COMPONENT]           VARCHAR (31)     NOT NULL,
    [ACCOUNT NUMBER]             VARCHAR (255)    NOT NULL,
    [SECURITY NUMBER]            VARCHAR (255)    NOT NULL,
    [SECURITY DESCRIPTION]       VARCHAR (255)    NULL,
    [SEDOL]                      VARCHAR (7)      NULL,
    [CUSIP]                      VARCHAR (9)      NULL,
    [COUNTRY OF TAXATION]        VARCHAR (2)      NULL,
    [STATE CODE]                 VARCHAR (255)    NULL,
    [ASSET GROUP]                VARCHAR (255)    NULL,
    [EX DATE SHARES]             DECIMAL (18, 4)  NULL,
    [EX DATE]                    DATETIME         NULL,
    [ACCRUED INCOME]             DECIMAL (18, 4)  NULL,
    [INCOME RECEIVED]            DECIMAL (18, 4)  NULL,
    [PRIOR INC ACCRUED]          DECIMAL (18, 4)  NULL,
    [INCOME EARNED]              DECIMAL (18, 4)  NULL,
    [AMORT ACCRUED]              DECIMAL (18, 4)  NULL,
    [AMORT SOLD]                 DECIMAL (18, 4)  NULL,
    [PRIOR AMORT ACCRUED]        DECIMAL (18, 4)  NULL,
    [AMORT EARNED]               DECIMAL (18, 4)  NULL,
    [TOTAL INC AND AMORT EARNED] DECIMAL (18, 4)  NULL,
    [UNITS]                      DECIMAL (18, 4)  NULL,
    [FUND NET INCOME]            DECIMAL (18, 4)  NULL,
    [RATE]                       DECIMAL (23, 15) NULL,
    [EX DATE YEAR]               INT              NOT NULL,
    [EX DATE MONTH]              INT              NOT NULL,
    [CADIS_SYSTEM_INSERTED0]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED0]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY0]    NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_RUNID]         INT              NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]      INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [EX DATE YEAR] ASC, [EX DATE MONTH] ASC) WITH (FILLFACTOR = 80)
);
