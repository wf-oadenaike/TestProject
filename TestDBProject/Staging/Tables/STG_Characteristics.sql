﻿CREATE TABLE [Staging].[STG_Characteristics] (
    [Fund]         NVARCHAR (256) NULL,
    [Sector]       NVARCHAR (256) NULL,
    [SubSector]    NVARCHAR (256) NULL,
    [Ticker]       NVARCHAR (256) NULL,
    [WgtPort]      NVARCHAR (256) NULL,
    [WgtBench]     NVARCHAR (256) NULL,
    [Wgt]          NVARCHAR (256) NULL,
    [DivYldPort]   NVARCHAR (256) NULL,
    [DivYldBench]  NVARCHAR (256) NULL,
    [DivYld]       NVARCHAR (256) NULL,
    [P_EPort]      NVARCHAR (256) NULL,
    [P_EBench]     NVARCHAR (256) NULL,
    [P_E]          NVARCHAR (256) NULL,
    [P_BPort]      NVARCHAR (256) NULL,
    [P_BBench]     NVARCHAR (256) NULL,
    [P_B]          NVARCHAR (256) NULL,
    [BEstP_EPort]  NVARCHAR (256) NULL,
    [BEstP_EBench] NVARCHAR (256) NULL,
    [BEstP_E]      NVARCHAR (256) NULL,
    [BEstP_BPort]  NVARCHAR (256) NULL,
    [BEstP_BBench] NVARCHAR (256) NULL,
    [BEstP_B]      NVARCHAR (256) NULL,
    [FileName]     NVARCHAR (256) NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_SBC_CD] DEFAULT (getdate()) NOT NULL
);
