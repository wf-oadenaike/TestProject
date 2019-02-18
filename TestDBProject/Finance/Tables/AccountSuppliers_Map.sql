CREATE TABLE [Finance].[AccountSuppliers_Map] (
    [ThrogID]              VARCHAR (20)  NULL,
    [ThrogSupplier]        VARCHAR (255) NULL,
    [WPSupplier]           VARCHAR (255) NULL,
    [WPID]                 VARCHAR (MAX) NULL,
    [AccountSupplierMapID] BIGINT        IDENTITY (1, 1) NOT NULL
);

