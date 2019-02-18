CREATE TABLE [Finance].[AccountCategories] (
    [AccountCategoryId]          SMALLINT  IDENTITY (1, 1) NOT NULL,
    [AccountCategory]            [sysname] NOT NULL,
    [AccountCategoryDescription] [sysname] NOT NULL,
    [PnLBS]                      SMALLINT  CONSTRAINT [DF_AC_PBS] DEFAULT ((-1)) NOT NULL,
    [ControlId]                  BIGINT    NOT NULL,
    CONSTRAINT [XPKAccountCategory] PRIMARY KEY CLUSTERED ([AccountCategoryId] ASC)
);

