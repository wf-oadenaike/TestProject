﻿CREATE TABLE [CADIS_PROC].[DC_UPFNDEXCEP_EXISTING_PREP] (
    [SOURCE_TABLE]              VARCHAR (50)   NOT NULL,
    [SOURCE_KEY_1]              VARCHAR (50)   NOT NULL,
    [SOURCE_KEY_2]              VARCHAR (50)   NOT NULL,
    [SOURCE_COLUMN]             VARCHAR (50)   NOT NULL,
    [EXCEPTION_CODE]            INT            NOT NULL,
    [EXCEPTION_DATE]            DATETIME       NOT NULL,
    [FUND_SHORT_NAME]           VARCHAR (50)   NULL,
    [ENTITY]                    VARCHAR (40)   NULL,
    [EXCEPTION_NAME]            VARCHAR (100)  NULL,
    [EXCEPTION_TYPE]            VARCHAR (50)   NULL,
    [STATUS]                    VARCHAR (20)   NULL,
    [PRIORITY]                  VARCHAR (20)   NULL,
    [COMMENT]                   VARCHAR (100)  NULL,
    [OWNER]                     VARCHAR (50)   NULL,
    [TEAM]                      VARCHAR (50)   NULL,
    [SOURCE_VALUE]              VARCHAR (1000) NULL,
    [DATA_A_TYPE]               VARCHAR (100)  NULL,
    [DATA_A_VALUE]              VARCHAR (1000) NULL,
    [DATA_B_TYPE]               VARCHAR (100)  NULL,
    [DATA_B_VALUE]              VARCHAR (1000) NULL,
    [DATA_C_TYPE]               VARCHAR (100)  NULL,
    [DATA_C_VALUE]              VARCHAR (1000) NULL,
    [SOURCE]                    VARCHAR (50)   NULL,
    [SOURCE_COMPONENT]          VARCHAR (50)   NULL,
    [RETENTION]                 INT            NULL,
    [HASVALUECHANGED]           INT            NULL,
    [DAYS_VALID]                INT            NULL,
    [OCCURRENCE]                INT            NULL,
    [EXCEPTION_AGE]             INT            NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([SOURCE_TABLE] ASC, [SOURCE_KEY_1] ASC, [SOURCE_KEY_2] ASC, [SOURCE_COLUMN] ASC, [EXCEPTION_CODE] ASC) WITH (FILLFACTOR = 80)
);
