CREATE TABLE [dbo].[T_NT_POS_AUM_ACCOUNT] (
    [FILE_NAME]              VARCHAR (100)   NULL,
    [FILE_TYPE]              VARCHAR (4)     NULL,
    [FILE_DATE]              DATETIME        NULL,
    [NUMBER_OF_RECORDS]      INT             NULL,
    [CONSOLIDATION]          VARCHAR (6)     NULL,
    [ACCOUNT_NUMBER]         VARCHAR (6)     NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (15)    NULL,
    [ACCOUNT_NAME]           VARCHAR (30)    NULL,
    [ERROR_CODE]             VARCHAR (1)     NULL,
    [C_REC_TYPE]             INT             NOT NULL,
    [FROM_DATE]              DATETIME        NULL,
    [THROUGH_DATE]           DATETIME        NULL,
    [C_VALN_TYPE]            VARCHAR (2)     NULL,
    [D_VALN_OUT_DATE]        DATETIME        NOT NULL,
    [A_AMT_TOT]              DECIMAL (20, 5) NULL,
    [A_MKT_BSE_TOT]          DECIMAL (20, 5) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT             DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [C_REC_TYPE] ASC, [D_VALN_OUT_DATE] ASC) WITH (FILLFACTOR = 90)
);

