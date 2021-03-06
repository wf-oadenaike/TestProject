﻿CREATE TABLE [dbo].[zzz_T_MATRIX_PROCESS_SALESFORCE_CONTACT] (
    [CntSivId]                  VARCHAR (100)  NOT NULL,
    [CntSalesforceId]           VARCHAR (18)   NULL,
    [AsAtDate]                  DATETIME       NOT NULL,
    [CaseID]                    INT            NOT NULL,
    [Type]                      VARCHAR (20)   NOT NULL,
    [CntAccountSalesforceId]    VARCHAR (18)   NULL,
    [CntFcaId]                  VARCHAR (20)   NULL,
    [CntAccountFcaId]           VARCHAR (20)   NULL,
    [CntOwnerId]                VARCHAR (18)   NULL,
    [CntOwnerName]              VARCHAR (200)  NULL,
    [CntAccountSivId]           VARCHAR (100)  NULL,
    [CntMatrixId]               VARCHAR (20)   NULL,
    [CntSalutation]             VARCHAR (20)   NULL,
    [CntFirstName]              VARCHAR (100)  NULL,
    [CntLastName]               VARCHAR (100)  NULL,
    [CntJobTitle]               VARCHAR (100)  NULL,
    [CntMailingStreet]          VARCHAR (1000) NULL,
    [CntMailingCity]            VARCHAR (100)  NULL,
    [CntMailingState]           VARCHAR (100)  NULL,
    [CntMailingPostcode]        VARCHAR (100)  NULL,
    [CntMailingCountry]         VARCHAR (100)  NULL,
    [CntLandline]               VARCHAR (50)   NULL,
    [CntMobile]                 VARCHAR (50)   NULL,
    [CntFax]                    VARCHAR (50)   NULL,
    [CntEmail]                  VARCHAR (128)  NULL,
    [CntIsCf1]                  VARCHAR (5)    NULL,
    [CntIsCf2]                  VARCHAR (5)    NULL,
    [CntIsCf3]                  VARCHAR (5)    NULL,
    [CntIsCf4]                  VARCHAR (5)    NULL,
    [CntIsCf10]                 VARCHAR (5)    NULL,
    [CntIsCf11]                 VARCHAR (5)    NULL,
    [CntIsCf30]                 VARCHAR (5)    NULL,
    [CntVerifiedBy]             VARCHAR (100)  NULL,
    [FCAStatus]                 VARCHAR (50)   NULL,
    [MfidStatus]                VARCHAR (100)  NULL,
    [IsActive]                  VARCHAR (100)  NULL,
    [AccountIsPriorityClient]   VARCHAR (10)   NULL,
    [AccountIsLocked]           VARCHAR (10)   NULL,
    [ExportStatus]              VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       NULL
);

