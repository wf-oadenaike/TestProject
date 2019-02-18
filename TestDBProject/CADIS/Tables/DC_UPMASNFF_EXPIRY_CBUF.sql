﻿CREATE TABLE [CADIS].[DC_UPMASNFF_EXPIRY_CBUF] (
    [ACCOUNT_NUMBER]     VARCHAR (50)    NOT NULL,
    [TNARRLONG]          VARCHAR (255)   NOT NULL,
    [NET_AMOUNT__BASE]   DECIMAL (20, 6) NOT NULL,
    [RECOGNITION_DATE]   DATETIME        NOT NULL,
    [NTRANCATG]          VARCHAR (100)   NOT NULL,
    [IEXTLREF]           VARCHAR (50)    NOT NULL,
    [CADIS_SYSTEM_RUNID] INT             NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [TNARRLONG] ASC, [NET_AMOUNT__BASE] ASC, [RECOGNITION_DATE] ASC, [NTRANCATG] ASC, [IEXTLREF] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID129]
    ON [CADIS].[DC_UPMASNFF_EXPIRY_CBUF]([CADIS_SYSTEM_RUNID] ASC);

