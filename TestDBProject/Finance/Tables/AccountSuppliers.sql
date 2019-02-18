CREATE TABLE [Finance].[AccountSuppliers] (
    [AccountRef] VARCHAR (20)   NOT NULL,
    [Supplier]   NVARCHAR (255) NOT NULL,
    [ControlId]  BIGINT         NOT NULL,
    PRIMARY KEY CLUSTERED ([AccountRef] ASC)
);

