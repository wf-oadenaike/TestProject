CREATE TABLE [Finance].[FinancialLineTypes] (
    [FinancialLineTypeId]      SMALLINT     IDENTITY (1, 1) NOT NULL,
    [FinancialLineCode]        VARCHAR (20) NOT NULL,
    [FinancialLineDescription] [sysname]    NOT NULL,
    CONSTRAINT [XPKFinancialLineTypes] PRIMARY KEY CLUSTERED ([FinancialLineTypeId] ASC),
    CONSTRAINT [IXUFinancialLineTypesLineCode] UNIQUE NONCLUSTERED ([FinancialLineCode] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUFinancialLineTypeCode]
    ON [Finance].[FinancialLineTypes]([FinancialLineCode] ASC);

