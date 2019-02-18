﻿CREATE TABLE [CADIS_SYS].[CO_ROLE] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [NAME]        NVARCHAR (50)  NOT NULL,
    [DESCRIPTION] NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_CO_ROLE] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXNAME]
    ON [CADIS_SYS].[CO_ROLE]([NAME] ASC);
