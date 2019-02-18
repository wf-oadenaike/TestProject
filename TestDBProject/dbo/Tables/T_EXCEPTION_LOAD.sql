﻿CREATE TABLE [dbo].[T_EXCEPTION_LOAD] (
    [SOURCE_TABLE]              VARCHAR (50)   NOT NULL,
    [SOURCE_KEY]                VARCHAR (50)   NOT NULL,
    [SOURCE_COLUMN]             VARCHAR (50)   NOT NULL,
    [EXCEPTION_CODE]            INT            NOT NULL,
    [EXCEPTION_DATE]            DATETIME       NOT NULL,
    [EDM_ENTITY_ID]             INT            NULL,
    [ENTITY]                    VARCHAR (40)   NULL,
    [EXCEPTION_NAME]            VARCHAR (40)   NULL,
    [EXCEPTION_TYPE]            VARCHAR (50)   NULL,
    [STATUS]                    VARCHAR (20)   CONSTRAINT [DF__T_EXCEPTI__STATU__4F0AFC1D] DEFAULT ('New') NULL,
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
    [CUSIP]                     VARCHAR (20)   NULL,
    [ISIN]                      VARCHAR (20)   NULL,
    [SECURITY_ID]               VARCHAR (50)   NULL,
    [SEDOL]                     VARCHAR (20)   NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF__T_EXCEPTI__CADIS__4FFF2056] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF__T_EXCEPTI__CADIS__50F3448F] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF__T_EXCEPTI__CADIS__51E768C8] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF__T_EXCEPTI__CADIS__52DB8D01] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF__T_EXCEPTI__CADIS__53CFB13A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    CONSTRAINT [PK__T_EXCEPT__94F0DFEE8EFE97F6] PRIMARY KEY CLUSTERED ([SOURCE_TABLE] ASC, [SOURCE_KEY] ASC, [SOURCE_COLUMN] ASC, [EXCEPTION_CODE] ASC) WITH (FILLFACTOR = 90)
);

