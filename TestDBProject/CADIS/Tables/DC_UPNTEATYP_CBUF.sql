﻿CREATE TABLE [CADIS].[DC_UPNTEATYP_CBUF] (
    [ACCOUNT_NUMBER]  VARCHAR (255) NOT NULL,
    [SECURITY_NUMBER] VARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [SECURITY_NUMBER] ASC) WITH (FILLFACTOR = 80)
);

