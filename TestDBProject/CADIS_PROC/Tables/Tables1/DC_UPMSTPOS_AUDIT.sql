﻿CREATE TABLE [CADIS_PROC].[DC_UPMSTPOS_AUDIT] (
    [SOURCE]                 VARCHAR (50)   NOT NULL,
    [POSITION_TYPE]          VARCHAR (50)   NOT NULL,
    [EDM_SEC_ID]             INT            NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (15)   NOT NULL,
    [LONG_SHORT_IND]         VARCHAR (8)    NOT NULL,
    [POSITION_DATE]          DATETIME       NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT            NOT NULL,
    [CADIS_SYSTEM_FIELDNAME] NVARCHAR (128) NOT NULL,
    [CADIS_SYSTEM_RULEID]    INT            NULL,
    [CADIS_SYSTEM_NEWVAL]    SQL_VARIANT    NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [EDM_SEC_ID] ASC, [FUND_SHORT_NAME] ASC, [LONG_SHORT_IND] ASC, [POSITION_DATE] ASC, [CADIS_SYSTEM_RUNID] ASC, [CADIS_SYSTEM_FIELDNAME] ASC)
);

