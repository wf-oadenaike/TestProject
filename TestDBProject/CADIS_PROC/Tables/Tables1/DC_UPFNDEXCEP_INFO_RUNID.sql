﻿CREATE TABLE [CADIS_PROC].[DC_UPFNDEXCEP_INFO_RUNID] (
    [SOURCE_TABLE]            VARCHAR (50) NOT NULL,
    [SOURCE_KEY_1]            VARCHAR (50) NOT NULL,
    [SOURCE_KEY_2]            VARCHAR (50) NOT NULL,
    [SOURCE_COLUMN]           VARCHAR (50) NOT NULL,
    [EXCEPTION_CODE]          INT          NOT NULL,
    [EXCEPTION_DATE__RUNID]   INT          NOT NULL,
    [FUND_SHORT_NAME__RUNID]  INT          NOT NULL,
    [ENTITY__RUNID]           INT          NOT NULL,
    [EXCEPTION_NAME__RUNID]   INT          NOT NULL,
    [EXCEPTION_TYPE__RUNID]   INT          NOT NULL,
    [STATUS__RUNID]           INT          NOT NULL,
    [PRIORITY__RUNID]         INT          NOT NULL,
    [COMMENT__RUNID]          INT          NOT NULL,
    [OWNER__RUNID]            INT          NOT NULL,
    [TEAM__RUNID]             INT          NOT NULL,
    [SOURCE_VALUE__RUNID]     INT          NOT NULL,
    [DATA_A_TYPE__RUNID]      INT          NOT NULL,
    [DATA_A_VALUE__RUNID]     INT          NOT NULL,
    [DATA_B_TYPE__RUNID]      INT          NOT NULL,
    [DATA_B_VALUE__RUNID]     INT          NOT NULL,
    [DATA_C_TYPE__RUNID]      INT          NOT NULL,
    [DATA_C_VALUE__RUNID]     INT          NOT NULL,
    [SOURCE__RUNID]           INT          NOT NULL,
    [SOURCE_COMPONENT__RUNID] INT          NOT NULL,
    [RETENTION__RUNID]        INT          NOT NULL,
    [HASVALUECHANGED__RUNID]  INT          NOT NULL,
    [DAYS_VALID__RUNID]       INT          NOT NULL,
    [OCCURRENCE__RUNID]       INT          NOT NULL,
    [EXCEPTION_AGE__RUNID]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SOURCE_TABLE] ASC, [SOURCE_KEY_1] ASC, [SOURCE_KEY_2] ASC, [SOURCE_COLUMN] ASC, [EXCEPTION_CODE] ASC)
);

