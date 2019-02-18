﻿CREATE TABLE [Staging].[STG_Performance] (
    [Fund]                NVARCHAR (256) NULL,
    [Sector]              NVARCHAR (256) NULL,
    [SubSector]           NVARCHAR (256) NULL,
    [Ticker]              NVARCHAR (256) NULL,
    [EndWeightPort]       NVARCHAR (256) NULL,
    [EndWeightBench]      NVARCHAR (256) NULL,
    [EndWeight]           NVARCHAR (256) NULL,
    [TotalReturn1DPort]   NVARCHAR (256) NULL,
    [TotalReturn1DBench]  NVARCHAR (256) NULL,
    [TotalReturn1D]       NVARCHAR (256) NULL,
    [TotalReturnMTDPort]  NVARCHAR (256) NULL,
    [TotalReturnMTDBench] NVARCHAR (256) NULL,
    [TotalReturnMTD]      NVARCHAR (256) NULL,
    [TotalReturnYTDPort]  NVARCHAR (256) NULL,
    [TotalReturnYTDBench] NVARCHAR (256) NULL,
    [TotalReturnYTD]      NVARCHAR (256) NULL,
    [MaxDrawPort]         NVARCHAR (256) NULL,
    [MaxDrawBench]        NVARCHAR (256) NULL,
    [StdDevPort]          NVARCHAR (256) NULL,
    [StdDevBench]         NVARCHAR (256) NULL,
    [TrackErrPort]        NVARCHAR (256) NULL,
    [TotRtn1YPort]        NVARCHAR (256) NULL,
    [TotRtn1YBench]       NVARCHAR (256) NULL,
    [TotRtn1Y]            NVARCHAR (256) NULL,
    [TotRtn3MPort]        NVARCHAR (256) NULL,
    [TotRtn3MBench]       NVARCHAR (256) NULL,
    [TotRtn3M]            NVARCHAR (256) NULL,
    [RecPerMaxDrawPort]   NVARCHAR (256) NULL,
    [RecPerMaxDrawBench]  NVARCHAR (256) NULL,
    [MaxRtnPort]          NVARCHAR (256) NULL,
    [MaxRtnBench]         NVARCHAR (256) NULL,
    [MaxRelDrawPort]      NVARCHAR (256) NULL,
    [FileName]            NVARCHAR (256) NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_SBP_CD] DEFAULT (getdate()) NOT NULL
);

