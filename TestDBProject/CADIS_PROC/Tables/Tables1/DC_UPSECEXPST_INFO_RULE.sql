﻿CREATE TABLE [CADIS_PROC].[DC_UPSECEXPST_INFO_RULE] (
    [SOURCE_TABLE]             VARCHAR (50) NOT NULL,
    [SOURCE_KEY]               VARCHAR (50) NOT NULL,
    [SOURCE_COLUMN]            VARCHAR (50) NOT NULL,
    [EXCEPTION_CODE]           INT          NOT NULL,
    [SOURCE_DATE]              DATETIME     NOT NULL,
    [PROCESS_STATUS__RULEID]   INT          NULL,
    [ENTITY__RULEID]           INT          NULL,
    [SOURCE__RULEID]           INT          NULL,
    [SOURCE_COMPONENT__RULEID] INT          NULL,
    [EDM_SEC_ID__RULEID]       INT          NULL,
    [SOURCE_VALUE__RULEID]     INT          NULL,
    [DATA_A_TYPE__RULEID]      INT          NULL,
    [DATA_A_VALUE__RULEID]     INT          NULL,
    [DATA_B_TYPE__RULEID]      INT          NULL,
    [DATA_B_VALUE__RULEID]     INT          NULL,
    [DATA_C_TYPE__RULEID]      INT          NULL,
    [DATA_C_VALUE__RULEID]     INT          NULL,
    PRIMARY KEY CLUSTERED ([SOURCE_TABLE] ASC, [SOURCE_KEY] ASC, [SOURCE_COLUMN] ASC, [EXCEPTION_CODE] ASC, [SOURCE_DATE] ASC)
);

