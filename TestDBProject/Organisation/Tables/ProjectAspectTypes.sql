CREATE TABLE [Organisation].[ProjectAspectTypes] (
    [ProjectAspectTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ProjectAspectTypeBK]      VARCHAR (25)  NOT NULL,
    [ProjectAspectDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKProjectAspectTypes] PRIMARY KEY CLUSTERED ([ProjectAspectTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProjectAspectTypes]
    ON [Organisation].[ProjectAspectTypes]([ProjectAspectTypeId] ASC);

