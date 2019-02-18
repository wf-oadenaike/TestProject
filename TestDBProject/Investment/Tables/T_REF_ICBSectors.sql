CREATE TABLE [Investment].[T_REF_ICBSectors] (
    [ID]            SMALLINT      NOT NULL,
    [ICBID]         VARCHAR (4)   NOT NULL,
    [Name]          VARCHAR (100) NOT NULL,
    [SupersectorID] SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_Investment.T_REF_ICB.SupersectorID] FOREIGN KEY ([SupersectorID]) REFERENCES [Investment].[T_REF_ICBSupersectors] ([ID])
);

