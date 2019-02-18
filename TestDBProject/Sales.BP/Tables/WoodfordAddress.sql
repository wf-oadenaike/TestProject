CREATE TABLE [Sales.BP].[WoodfordAddress] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [AddrStreet]         NVARCHAR (100) NULL,
    [AddrCity]           NVARCHAR (100) NULL,
    [AddrState]          NVARCHAR (100) NULL,
    [AddrPostcode]       NVARCHAR (20)  NULL,
    [AddrCountry]        NVARCHAR (100) NULL,
    [WoodfordLastUpdate] DATETIME       NULL,
    [MatrixLastUpdate]   DATETIME       NULL,
    [StartDateTime]      DATETIME       CONSTRAINT [c_wa_StartDateTime] DEFAULT (getdate()) NOT NULL,
    [EndDateTime]        DATETIME       CONSTRAINT [c_wa_EndDateTime] DEFAULT ('2099-12-31T00:00:00') NOT NULL,
    [IsActive]           BIT            CONSTRAINT [c_wa_IsActiveDefault] DEFAULT ('1') NOT NULL,
    CONSTRAINT [pk_wa_id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [uc_wa_all] UNIQUE NONCLUSTERED ([AddrStreet] ASC, [AddrCity] ASC, [AddrState] ASC, [AddrPostcode] ASC, [AddrCountry] ASC, [EndDateTime] ASC)
);

