CREATE TABLE [KPI].[MeasuredKPIs-old] (
    [KPIId]                     SMALLINT        IDENTITY (1, 1) NOT NULL,
    [KPIName]                   VARCHAR (128)   NOT NULL,
    [KPINameAlias]              VARCHAR (128)   NULL,
    [KPIDescription]            VARCHAR (128)   NULL,
    [KPIBK]                     SMALLINT        NOT NULL,
    [GreenThresholdValue]       DECIMAL (19, 5) NULL,
    [AmberThresholdValue]       DECIMAL (19, 5) NULL,
    [RedThresholdValue]         DECIMAL (19, 5) NULL,
    [TargetValue]               DECIMAL (19, 5) NULL,
    [Operator]                  VARCHAR (25)    NOT NULL,
    [IsPercentage]              BIT             NOT NULL,
    [IsActive]                  BIT             NOT NULL,
    [RefreshFrequencyId]        SMALLINT        NOT NULL,
    [AggrFunction]              VARCHAR (3)     NOT NULL,
    [OwnerRoleId]               SMALLINT        NOT NULL,
    [KPIDBBK]                   VARCHAR (25)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL,
    [FUND_SHORT_NAME]           VARCHAR (20)    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIMeasuredKPIs]
    ON [KPI].[MeasuredKPIs-old]([KPIId] ASC);


GO
ALTER INDEX [UXIMeasuredKPIs]
    ON [KPI].[MeasuredKPIs-old] DISABLE;


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIMeasuredKPIsKPIBK]
    ON [KPI].[MeasuredKPIs-old]([KPIBK] ASC);


GO
ALTER INDEX [UXIMeasuredKPIsKPIBK]
    ON [KPI].[MeasuredKPIs-old] DISABLE;

