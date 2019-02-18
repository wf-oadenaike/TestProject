﻿CREATE TABLE [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE_tar] (
    [Fund]                   NVARCHAR (256) NULL,
    [Sector]                 NVARCHAR (256) NULL,
    [SubSector]              NVARCHAR (256) NULL,
    [Ticker]                 NVARCHAR (256) NULL,
    [EndWeightPort]          NVARCHAR (256) NULL,
    [EndWeightBench]         NVARCHAR (256) NULL,
    [EndWeight]              NVARCHAR (256) NULL,
    [TotalReturn1DPort]      NVARCHAR (256) NULL,
    [TotalReturn1DBench]     NVARCHAR (256) NULL,
    [TotalReturn1D]          NVARCHAR (256) NULL,
    [TotalReturnMTDPort]     NVARCHAR (256) NULL,
    [TotalReturnMTDBench]    NVARCHAR (256) NULL,
    [TotalReturnMTD]         NVARCHAR (256) NULL,
    [TotalReturnYTDPort]     NVARCHAR (256) NULL,
    [TotalReturnYTDBench]    NVARCHAR (256) NULL,
    [TotalReturnYTD]         NVARCHAR (256) NULL,
    [MaxDrawPort]            NVARCHAR (256) NULL,
    [MaxDrawBench]           NVARCHAR (256) NULL,
    [StdDevPort]             NVARCHAR (256) NULL,
    [StdDevBench]            NVARCHAR (256) NULL,
    [TrackErrPort]           NVARCHAR (256) NULL,
    [TotRtn1YPort]           NVARCHAR (256) NULL,
    [TotRtn1YBench]          NVARCHAR (256) NULL,
    [TotRtn1Y]               NVARCHAR (256) NULL,
    [TotRtn3MPort]           NVARCHAR (256) NULL,
    [TotRtn3MBench]          NVARCHAR (256) NULL,
    [TotRtn3M]               NVARCHAR (256) NULL,
    [RecPerMaxDrawPort]      NVARCHAR (256) NULL,
    [RecPerMaxDrawBench]     NVARCHAR (256) NULL,
    [MaxRtnPort]             NVARCHAR (256) NULL,
    [MaxRtnBench]            NVARCHAR (256) NULL,
    [MaxRelDrawPort]         NVARCHAR (256) NULL,
    [FileName]               NVARCHAR (256) NULL,
    [FILE_DATE]              NVARCHAR (256) NULL,
    [FILE_TYPE]              VARCHAR (20)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL,
    [TotRtn3YPort]           NVARCHAR (256) NULL,
    [TotRtn3YBench]          NVARCHAR (256) NULL,
    [TotRtn3Y]               NVARCHAR (256) NULL,
    [TotRtnWTDPort]          NVARCHAR (256) NULL,
    [TotRtnWTDBench]         NVARCHAR (256) NULL,
    [TotRtnWTD]              NVARCHAR (256) NULL,
    [TotRtnQTDPort]          NVARCHAR (256) NULL,
    [TotRtnQTDBench]         NVARCHAR (256) NULL,
    [TotRtnQTD]              NVARCHAR (256) NULL,
    [flag]                   CHAR (1)       NULL,
    [EffectiveDate]          DATETIME       NULL,
    [EndDate]                DATETIME       NULL,
    [aCTION]                 NVARCHAR (50)  NULL
);

