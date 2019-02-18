CREATE TABLE [Staging].[DepartmentsSrc] (
    [SrcId]          [Staging].[SalesforceIdDom] NOT NULL,
    [DepartmentBK]   SMALLINT                    NULL,
    [DepartmentName] [sysname]                   NOT NULL,
    [IsDelete]       BIT                         DEFAULT ((0)) NOT NULL,
    [ActiveFlag]     BIT                         DEFAULT ((1)) NOT NULL,
    CONSTRAINT [XPKDepartmentsSrc] PRIMARY KEY CLUSTERED ([SrcId] ASC)
);

