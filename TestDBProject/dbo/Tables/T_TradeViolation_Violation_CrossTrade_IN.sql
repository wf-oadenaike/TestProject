CREATE TABLE [dbo].[T_TradeViolation_Violation_CrossTrade_IN] (
    [CADIS_BATCH_ID]           INT            NOT NULL,
    [CADIS_MSG_ID]             INT            CONSTRAINT [DF__T_TradeVi__CADIS__22AFB8F7] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]          INT            NOT NULL,
    [CADIS_ROW_ID]             INT            NOT NULL,
    [CrossTrade_CADIS_ROW_ID]  INT            NULL,
    [CrossTrade_NYDateTime]    NVARCHAR (100) NULL,
    [CrossTrade_RouteBrkr]     NVARCHAR (100) NULL,
    [CrossTrade_RouteDateTime] NVARCHAR (100) NULL,
    [CrossTrade_RoutePosition] NVARCHAR (100) NULL,
    [CrossTrade_RoutePrice]    NVARCHAR (100) NULL,
    [CrossTrade_RouteTktNum]   NVARCHAR (100) NULL,
    [CrossTrade_RouteTranID]   NVARCHAR (100) NULL,
    [CrossTrade_RouteOrderID]  NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__23A3DD30] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__24980169] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50)  CONSTRAINT [DF__T_TradeVi__CADIS__258C25A2] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]    INT            CONSTRAINT [DF__T_TradeVi__CADIS__268049DB] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_CrossTrade_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

