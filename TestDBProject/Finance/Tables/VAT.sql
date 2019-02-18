CREATE TABLE [Finance].[VAT] (
    [VATId]           SMALLINT  IDENTITY (1, 1) NOT NULL,
    [VATName]         [sysname] NOT NULL,
    [VATNetPriceCalc] REAL      NOT NULL,
    [ValidFromDate]   DATETIME  CONSTRAINT [VATValidFromDate] DEFAULT (getdate()) NOT NULL,
    [ValidToDate]     DATETIME  CONSTRAINT [VATValidToDate] DEFAULT (((2020)-(4))-(1)) NOT NULL,
    [ValidFromId]     INT       CONSTRAINT [VATValidFromId] DEFAULT ((datepart(year,getdate())*(10000)+datepart(month,getdate())*(100))+datepart(day,getdate())) NOT NULL,
    [ValidToId]       INT       CONSTRAINT [VATVaildToId] DEFAULT ((20200401)) NOT NULL,
    [CurrentRecord]   BIT       CONSTRAINT [VATCurrentRecord] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [UPKVAT] PRIMARY KEY CLUSTERED ([VATName] ASC)
);

