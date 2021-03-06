﻿CREATE TABLE [CADIS_SYS].[TMPDI_CUSIPVALIDATOR_IDATA] (
    [CALLID]  INT            NOT NULL,
    [ROWKEY]  NVARCHAR (200) NOT NULL,
    [CUSIP]   NVARCHAR (20)  NULL,
    [RESULT]  INT            DEFAULT ((1)) NOT NULL,
    [DIGITS_] CHAR (16)      NULL,
    CONSTRAINT [PK_TMPDI_CUSIPVALIDATOR_IDATA] PRIMARY KEY CLUSTERED ([CALLID] ASC, [ROWKEY] ASC) WITH (FILLFACTOR = 80)
);

