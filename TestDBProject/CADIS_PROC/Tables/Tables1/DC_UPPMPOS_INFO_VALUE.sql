﻿CREATE TABLE [CADIS_PROC].[DC_UPPMPOS_INFO_VALUE] (
    [SOURCE]                    VARCHAR (50)    NOT NULL,
    [POSITION_TYPE]             VARCHAR (50)    NOT NULL,
    [EDM_SEC_ID]                INT             NOT NULL,
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [LONG_SHORT_IND]            VARCHAR (8)     NOT NULL,
    [POSITION_DATE]             DATETIME        NOT NULL,
    [QUANTITY]                  DECIMAL (20, 6) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [EDM_SEC_ID] ASC, [FUND_SHORT_NAME] ASC, [LONG_SHORT_IND] ASC, [POSITION_DATE] ASC)
);

