﻿CREATE TABLE [CADIS_SYS].[TMPDI_ISINVALIDATOR_IDATA] (
    [CALLID]  INT            NOT NULL,
    [ROWKEY]  NVARCHAR (200) NOT NULL,
    [ISIN]    NVARCHAR (20)  NULL,
    [RESULT]  INT            DEFAULT ((1)) NOT NULL,
    [DIGITS_] CHAR (22)      NULL,
    CONSTRAINT [PK_TMPDI_ISINVALIDATOR_IDATA] PRIMARY KEY CLUSTERED ([CALLID] ASC, [ROWKEY] ASC) WITH (FILLFACTOR = 80)
);

