CREATE TABLE [Investment].[T_REF_ICBSupersectors] (
    [ID]         SMALLINT      NOT NULL,
    [ICBID]      VARCHAR (4)   NOT NULL,
    [Name]       VARCHAR (100) NOT NULL,
    [IndustryID] SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_Investment.T_REF_ICB.IndustryID] FOREIGN KEY ([IndustryID]) REFERENCES [Investment].[T_REF_ICBIndustries] ([ID])
);

