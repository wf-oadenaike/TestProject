CREATE TABLE [Staging.Matrix].[PrincipalLink] (
    [PRINCIPAL_SIV_ID]          VARCHAR (100) NOT NULL,
    [AR_SIV_ID]                 VARCHAR (100) NOT NULL,
    [AS_AT_DATE]                DATETIME      NOT NULL,
    [RELATIONSHIP_TYPE]         VARCHAR (20)  NULL,
    [SOURCE]                    VARCHAR (20)  NULL,
    [FILE_NAME]                 VARCHAR (100) NOT NULL,
    [FILE_DATE]                 DATETIME      NOT NULL,
    [FILE_TYPE]                 VARCHAR (20)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_staging_Matrix_PrincipalLink_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_staging_Matrix_PrincipalLink_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)  CONSTRAINT [DF_staging_Matrix_PrincipalLink_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_staging_Matrix_PrincipalLink_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_staging_Matrix_PrincipalLink_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__staging_Matrix_PrincipalLink] PRIMARY KEY CLUSTERED ([PRINCIPAL_SIV_ID] ASC, [AR_SIV_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 90)
);

