CREATE TABLE [Staging].[DepartmentSrc] (
    [Company: ID]                     [Staging].[SalesforceIdDom] NOT NULL,
    [Company: Company name]           [sysname]                   NOT NULL,
    [Department: ID]                  [Staging].[SalesforceIdDom] NOT NULL,
    [Department: Department]          [sysname]                   NULL,
    [Department code]                 [sysname]                   NULL,
    [No longer in use]                NVARCHAR (255)              NULL,
    [Department: Currency]            NVARCHAR (255)              NULL,
    [Department: Created By]          NVARCHAR (255)              NULL,
    [Department: Created Alias]       NVARCHAR (255)              NULL,
    [Department: Created Date]        DATETIME                    NULL,
    [Department: Last Modified By]    NVARCHAR (255)              NULL,
    [Department: Last Modified Alias] NVARCHAR (255)              NULL,
    [Department: Last Modified Date]  DATETIME                    NULL
);

