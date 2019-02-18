CREATE TABLE [Core].[WP_Throg_Map] (
    [Mapname]  VARCHAR (50)  NULL,
    [XeroName] VARCHAR (100) NULL,
    [SageName] VARCHAR (50)  NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NDX_UNQ]
    ON [Core].[WP_Throg_Map]([Mapname] ASC, [XeroName] ASC, [SageName] ASC);

