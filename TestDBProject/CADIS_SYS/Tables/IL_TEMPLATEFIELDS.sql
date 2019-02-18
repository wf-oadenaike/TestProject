﻿CREATE TABLE [CADIS_SYS].[IL_TEMPLATEFIELDS] (
    [TEMPLATEID]        INT            NOT NULL,
    [TEMPLATEFIELDNAME] NVARCHAR (256) NOT NULL,
    [TEMPLATEDESC]      NVARCHAR (256) NOT NULL,
    [TEMPLATEFORMAT]    NVARCHAR (256) NOT NULL,
    [TEMPLATEFIELDTYPE] NVARCHAR (256) NULL,
    CONSTRAINT [PK_IL_TEMPLATEFIELDS] PRIMARY KEY CLUSTERED ([TEMPLATEID] ASC, [TEMPLATEFIELDNAME] ASC)
);

