﻿CREATE TABLE [dbo].[T_MATRIX_PRINCIPALLINK] (
    [PRINCIPAL_SIV_ID]          VARCHAR (100) NOT NULL,
    [AR_SIV_ID]                 VARCHAR (100) NOT NULL,
    [AS_AT_DATE]                DATETIME      NOT NULL,
    [RELATIONSHIP_TYPE]         VARCHAR (20)  NULL,
    [SOURCE]                    VARCHAR (20)  NULL,
    [FILE_NAME]                 VARCHAR (100) NOT NULL,
    [FILE_DATE]                 DATETIME      NOT NULL,
    [FILE_TYPE]                 VARCHAR (20)  NOT NULL,
    [STATUS]                    VARCHAR (10)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_T_MATRIX_PRINCIPALLINK_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_T_MATRIX_PRINCIPALLINK_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)  CONSTRAINT [DF_T_MATRIX_PRINCIPALLINK_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_T_MATRIX_PRINCIPALLINK_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_T_MATRIX_PRINCIPALLINK_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_MATRIX_PRINCIPALLINK] PRIMARY KEY CLUSTERED ([PRINCIPAL_SIV_ID] ASC, [AR_SIV_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 90)
);
