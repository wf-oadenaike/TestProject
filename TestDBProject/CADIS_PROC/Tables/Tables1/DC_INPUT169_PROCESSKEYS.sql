﻿CREATE TABLE [CADIS_PROC].[DC_INPUT169_PROCESSKEYS] (
    [SfAccountId] VARCHAR (18) NOT NULL,
    [Sector]      VARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

