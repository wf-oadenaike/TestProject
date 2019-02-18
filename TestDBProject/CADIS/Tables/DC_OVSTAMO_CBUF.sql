﻿CREATE TABLE [CADIS].[DC_OVSTAMO_CBUF] (
    [SfAccountId] VARCHAR (18) NOT NULL,
    [Sector]      VARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);
