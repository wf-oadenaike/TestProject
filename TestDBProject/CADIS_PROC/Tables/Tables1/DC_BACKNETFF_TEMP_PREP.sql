﻿CREATE TABLE [CADIS_PROC].[DC_BACKNETFF_TEMP_PREP] (
    [ROW_NUMBER]                                    INT             NOT NULL,
    [FILE_NAME]                                     VARCHAR (50)    NULL,
    [FILE_TYPE]                                     VARCHAR (20)    NULL,
    [FILE_DATE]                                     DATETIME        NULL,
    [NUMBER_OF_RECORDS]                             VARCHAR (20)    NULL,
    [CONSOLIDATION]                                 VARCHAR (50)    NULL,
    [ACCOUNT_NUMBER]                                VARCHAR (50)    NOT NULL,
    [FUND_SHORT_NAME]                               VARCHAR (15)    NULL,
    [FROM_DATE]                                     DATETIME        NULL,
    [THROUGH_DATE]                                  DATETIME        NULL,
    [TASTDESCMED]                                   VARCHAR (50)    NULL,
    [TNARRLONG]                                     VARCHAR (50)    NULL,
    [ABASBSE]                                       VARCHAR (50)    NULL,
    [NET_AMOUNT__BASE]                              DECIMAL (20, 6) NOT NULL,
    [AMKTVAL]                                       VARCHAR (50)    NULL,
    [ARLSDGAIN]                                     VARCHAR (50)    NULL,
    [AEXCHGNLS]                                     VARCHAR (50)    NULL,
    [RECOGNITION_DATE]                              DATETIME        NOT NULL,
    [NTRANCATG]                                     VARCHAR (100)   NOT NULL,
    [ASSET_IDENTIFIER]                              VARCHAR (50)    NULL,
    [CTEMPLTYPE]                                    VARCHAR (50)    NULL,
    [CVALNTYPEO]                                    VARCHAR (50)    NULL,
    [TSHAREPAR]                                     VARCHAR (50)    NULL,
    [REVERSAL_INDICATOR]                            VARCHAR (50)    NULL,
    [ALOTCOSTGNLS]                                  VARCHAR (50)    NULL,
    [DTRANPROC]                                     VARCHAR (50)    NULL,
    [CSORTCDE3]                                     VARCHAR (50)    NULL,
    [ERROR_CODE]                                    VARCHAR (50)    NULL,
    [CONSOLIDATION_AUDIT_INDICATOR_FLAG]            VARCHAR (50)    NULL,
    [IEXTLREF]                                      VARCHAR (50)    NULL,
    [CASSETLIAB]                                    VARCHAR (50)    NULL,
    [ACCRUED_INTEREST]                              VARCHAR (50)    NULL,
    [DSET]                                          VARCHAR (50)    NULL,
    [ACCRUAL_CHANGE_FROM_SECURITY_MOVEMENTS_OFFSET] VARCHAR (50)    NULL,
    [CADIS_SYSTEM_INSERTED]                         DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]                          DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]                        NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]                         INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                     DATETIME        NULL,
    [IEXTLREF2]                                     VARCHAR (50)    NOT NULL,
    [tnarrlong2]                                    VARCHAR (50)    NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [NET_AMOUNT__BASE] ASC, [RECOGNITION_DATE] ASC, [NTRANCATG] ASC, [IEXTLREF2] ASC, [tnarrlong2] ASC) WITH (FILLFACTOR = 80)
);

