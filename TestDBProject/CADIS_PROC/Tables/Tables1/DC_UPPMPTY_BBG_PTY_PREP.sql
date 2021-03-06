﻿CREATE TABLE [CADIS_PROC].[DC_UPPMPTY_BBG_PTY_PREP] (
    [ACTIVE]                     INT            NOT NULL,
    [APPROVED]                   INT            NOT NULL,
    [CADIS Id]                   INT            NOT NULL,
    [CADIS Priority]             TINYINT        NOT NULL,
    [FILE_NAME]                  VARCHAR (100)  NULL,
    [FILE_TYPE]                  VARCHAR (4)    NULL,
    [FILE_DATE]                  DATETIME       NULL,
    [NUMBER_OF_RECORDS]          VARCHAR (8000) NULL,
    [BROKER]                     VARCHAR (40)   NOT NULL,
    [BROKER_SHORT_NAME]          VARCHAR (40)   NULL,
    [BROKER_LONG_NAME]           VARCHAR (40)   NULL,
    [MASTER_BROKER_NUMBER]       VARCHAR (40)   NULL,
    [MASTER_BROKER_SHORT_NAME]   VARCHAR (40)   NULL,
    [MASTER_BROKER_LONG_NAME]    VARCHAR (40)   NULL,
    [DTC_EXE_#]                  VARCHAR (40)   NULL,
    [DTC_CLR_#]                  VARCHAR (40)   NULL,
    [PTC_#]                      VARCHAR (40)   NULL,
    [FED_ABA_#]                  VARCHAR (40)   NULL,
    [FED_ACCT_#]                 VARCHAR (40)   NULL,
    [FED_ACCT_NAME]              VARCHAR (40)   NULL,
    [SPECIAL_INSTRUCTIONS_1]     VARCHAR (40)   NULL,
    [SPECIAL_INSTRUCTIONS_2]     VARCHAR (40)   NULL,
    [SPECIAL_INSTRUCTIONS_3]     VARCHAR (40)   NULL,
    [FILLER_FILLER]              VARCHAR (40)   NULL,
    [CUSTOMER_TYPE]              VARCHAR (40)   NULL,
    [SEC_ACCT_1]                 VARCHAR (40)   NULL,
    [SEC_ACCT_2]                 VARCHAR (40)   NULL,
    [SEC_ACCT_3]                 VARCHAR (40)   NULL,
    [SEC_ACCT_4]                 VARCHAR (40)   NULL,
    [SEC_ACCT_5]                 VARCHAR (40)   NULL,
    [SEC_DELIVERY_INSTRUCTION_1] VARCHAR (40)   NULL,
    [SEC_DELIVERY_INSTRUCTION_2] VARCHAR (40)   NULL,
    [SEC_DELIVERY_INSTRUCTION_3] VARCHAR (40)   NULL,
    [SEC_DELIVERY_INSTRUCTION_4] VARCHAR (40)   NULL,
    [SEC_DELIVERY_INSTRUCTION_5] VARCHAR (40)   NULL,
    [STATE/COUNTRY_CODE]         VARCHAR (40)   NULL,
    [DATE_OPENED]                DATETIME       NULL,
    [LAST_ACTIVITY]              VARCHAR (40)   NULL,
    [NOTES_1]                    VARCHAR (40)   NULL,
    [NOTES_2]                    VARCHAR (40)   NULL,
    [NOTES_3]                    VARCHAR (40)   NULL,
    [BROKER_STATUS]              VARCHAR (40)   NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_PRIORITY]      INT            NULL,
    [CADIS Inserted]             DATETIME       NOT NULL,
    [CADIS Updated]              DATETIME       NOT NULL,
    [CADIS Changed By]           NVARCHAR (100) NOT NULL,
    [CADIS Row Id]               INT            NOT NULL,
    [CADIS Revision]             INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([CADIS Id] ASC) WITH (FILLFACTOR = 80)
);

