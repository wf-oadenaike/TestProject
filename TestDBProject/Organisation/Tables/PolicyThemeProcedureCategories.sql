CREATE TABLE [Organisation].[PolicyThemeProcedureCategories] (
    [PTPCategoryId]    SMALLINT     IDENTITY (1, 1) NOT NULL,
    [PTPCategoryBK]    VARCHAR (25) NOT NULL,
    [PTPCategoryName]  [sysname]    NOT NULL,
    [PTPRegisterLevel] BIT          CONSTRAINT [DF_PTPC_PTPRL] DEFAULT ((1)) NOT NULL,
    [ReviewWithin]     SMALLINT     CONSTRAINT [DF_PTPC_RW] DEFAULT ((30)) NOT NULL,
    [ValidityPeriod]   SMALLINT     CONSTRAINT [DF_PTPC_VP] DEFAULT ((365)) NOT NULL,
    CONSTRAINT [PKPolicyThemeProcedureCategories] PRIMARY KEY CLUSTERED ([PTPCategoryBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIPolicyThemeProcedureCategories]
    ON [Organisation].[PolicyThemeProcedureCategories]([PTPCategoryId] ASC);

