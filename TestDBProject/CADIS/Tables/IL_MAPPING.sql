﻿CREATE TABLE [CADIS].[IL_MAPPING] (
    [ID]               INT            IDENTITY (1, 1) NOT NULL,
    [ILLUSTRATED_NAME] NVARCHAR (200) NOT NULL,
    [FIELD_NAME]       NVARCHAR (200) NOT NULL,
    [SOURCE]           NVARCHAR (200) NOT NULL,
    [DESCRIPTION]      NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_IL_MAPPING] PRIMARY KEY CLUSTERED ([ID] ASC)
);

