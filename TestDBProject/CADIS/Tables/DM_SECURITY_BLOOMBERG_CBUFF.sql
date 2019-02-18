﻿CREATE TABLE [CADIS].[DM_SECURITY_BLOOMBERG_CBUFF] (
    [UNIQUE_IDENTIFIER]  VARCHAR (30) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([UNIQUE_IDENTIFIER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID20]
    ON [CADIS].[DM_SECURITY_BLOOMBERG_CBUFF]([CADIS_SYSTEM_RUNID] ASC);

