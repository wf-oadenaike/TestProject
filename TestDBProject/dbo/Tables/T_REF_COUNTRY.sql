CREATE TABLE [dbo].[T_REF_COUNTRY] (
    [ISO_CTY_CD]             VARCHAR (4)   NOT NULL,
    [CTY_NAME]               VARCHAR (255) NULL,
    [ISO3_CTY_CD]            VARCHAR (4)   NULL,
    [CTY_CD_4DIGIT]          VARCHAR (4)   NULL,
    [ISO_CCY_CD]             VARCHAR (3)   NULL,
    [BB_REGION]              VARCHAR (20)  NULL,
    [OTC_EXCH]               VARCHAR (4)   NULL,
    [ACTIVE]                 VARCHAR (1)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    [ISO2Code]               VARCHAR (2)   NULL,
    [ISO3Code]               VARCHAR (3)   NULL,
    [ISONumericCode]         INT           NULL,
    [Order]                  INT           NULL,
    [SalesforceID]           VARCHAR (15)  NULL,
    PRIMARY KEY CLUSTERED ([ISO_CTY_CD] ASC) WITH (FILLFACTOR = 90)
);

