﻿CREATE TABLE [CADIS_PROC].[DC_UPMASNFF_EXPIRY_PREP] (
    [FILE_NAME]                                     VARCHAR (50)    NULL,
    [FILE_TYPE]                                     VARCHAR (20)    NULL,
    [FILE_DATE]                                     DATETIME        NULL,
    [NUMBER_OF_RECORDS]                             VARCHAR (20)    NULL,
    [CONSOLIDATION]                                 DATETIME        NULL,
    [ACCOUNT_NUMBER]                                VARCHAR (50)    NOT NULL,
    [FUND_SHORT_NAME]                               DATETIME        NULL,
    [FROM_DATE]                                     DATETIME        NULL,
    [THROUGH_DATE]                                  DATETIME        NULL,
    [TASTDESCMED]                                   DATETIME        NULL,
    [TNARRLONG]                                     VARCHAR (255)   NOT NULL,
    [ABASBSE]                                       DATETIME        NULL,
    [NET_AMOUNT__BASE]                              DECIMAL (20, 6) NOT NULL,
    [AMKTVAL]                                       DATETIME        NULL,
    [ARLSDGAIN]                                     DATETIME        NULL,
    [AEXCHGNLS]                                     DATETIME        NULL,
    [RECOGNITION_DATE]                              DATETIME        NOT NULL,
    [NTRANCATG]                                     VARCHAR (100)   NOT NULL,
    [ASSET_IDENTIFIER]                              DATETIME        NULL,
    [CTEMPLTYPE]                                    DATETIME        NULL,
    [CVALNTYPEO]                                    DATETIME        NULL,
    [TSHAREPAR]                                     DATETIME        NULL,
    [REVERSAL_INDICATOR]                            DATETIME        NULL,
    [ALOTCOSTGNLS]                                  DATETIME        NULL,
    [DTRANPROC]                                     DATETIME        NULL,
    [CSORTCDE3]                                     DATETIME        NULL,
    [ERROR_CODE]                                    DATETIME        NULL,
    [CONSOLIDATION_AUDIT_INDICATOR_FLAG]            DATETIME        NULL,
    [IEXTLREF]                                      VARCHAR (50)    NOT NULL,
    [CASSETLIAB]                                    DATETIME        NULL,
    [ACCRUED_INTEREST]                              DATETIME        NULL,
    [DSET]                                          DATETIME        NULL,
    [ACCRUAL_CHANGE_FROM_SECURITY_MOVEMENTS_OFFSET] DATETIME        NULL,
    [CADIS_SYSTEM_INSERTED]                         DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]                          DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]                        NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]                         INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                     DATETIME        NULL,
    [CADIS_SYSTEM_TIMESTAMP]                        ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [TNARRLONG] ASC, [NET_AMOUNT__BASE] ASC, [RECOGNITION_DATE] ASC, [NTRANCATG] ASC, [IEXTLREF] ASC) WITH (FILLFACTOR = 80)
);
