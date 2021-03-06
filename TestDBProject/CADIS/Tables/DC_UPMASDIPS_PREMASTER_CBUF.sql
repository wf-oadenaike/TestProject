﻿CREATE TABLE [CADIS].[DC_UPMASDIPS_PREMASTER_CBUF] (
    [ASSET]              VARCHAR (10) NOT NULL,
    [ORDER_REF]          INT          NOT NULL,
    [VALUATION_POINT]    DATETIME     NOT NULL,
    [ESTIMATED?]         BIT          NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([ASSET] ASC, [ORDER_REF] ASC, [VALUATION_POINT] ASC, [ESTIMATED?] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID119]
    ON [CADIS].[DC_UPMASDIPS_PREMASTER_CBUF]([CADIS_SYSTEM_RUNID] ASC);

