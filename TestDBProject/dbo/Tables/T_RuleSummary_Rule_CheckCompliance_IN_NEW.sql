﻿CREATE TABLE [dbo].[T_RuleSummary_Rule_CheckCompliance_IN_NEW] (
    [CADIS_BATCH_ID]                      INT            NOT NULL,
    [CADIS_MSG_ID]                        INT            CONSTRAINT [DF__T_RuleSum__CADIS__6BDEA6FA] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                     INT            NOT NULL,
    [CADIS_ROW_ID]                        INT            NOT NULL,
    [CheckCompliance_CADIS_ROW_ID]        INT            NULL,
    [Severity_CADIS_ROW_ID]               INT            NULL,
    [Severity_SeverityVal]                NVARCHAR (100) NULL,
    [OverrideUserGrp_CADIS_ROW_ID]        INT            NULL,
    [OverrideUserGrp_OverrideUserGrpName] NVARCHAR (100) NULL,
    [OverrideUserGrp_OverrideUserGrpType] NVARCHAR (100) NULL,
    [Alert_CADIS_ROW_ID]                  INT            NULL,
    [Alert_AlertType]                     NVARCHAR (100) NULL,
    [PostMsgTarget_CADIS_ROW_ID]          INT            NULL,
    [PostMsgTarget_PostMsgTargetName]     NVARCHAR (100) NULL,
    [PostMsgTarget_PostMsgTargetType]     NVARCHAR (100) NULL,
    [PreTrade_CADIS_ROW_ID]               INT            NULL,
    [PreTrade_PreTradeCheck]              NVARCHAR (100) NULL,
    [PostTrade_CADIS_ROW_ID]              INT            NULL,
    [PostTrade_PostTradeCheck]            NVARCHAR (100) NULL,
    [EndOfDay_CADIS_ROW_ID]               INT            NULL,
    [EndOfDay_EndOfDayCheck]              NVARCHAR (100) NULL,
    [OpenOrders_CADIS_ROW_ID]             INT            NULL,
    [OpenOrders_InclOpenOrders]           NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]               DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__6CD2CB33] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__6DC6EF6C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]              NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__6EBB13A5] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]               INT            CONSTRAINT [DF__T_RuleSum__CADIS__6FAF37DE] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_CheckCompliance_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

