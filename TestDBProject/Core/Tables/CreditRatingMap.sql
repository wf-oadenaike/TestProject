CREATE TABLE [Core].[CreditRatingMap] (
    [RatingId]     INT         IDENTITY (1, 1) NOT NULL,
    [MeasureValue] SMALLINT    NOT NULL,
    [Moodys]       VARCHAR (5) NOT NULL,
    [SP_Fitch]     VARCHAR (5) NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NC_NDX_MOODYS]
    ON [Core].[CreditRatingMap]([MeasureValue] ASC, [Moodys] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NC_NDX_SP_FITCH]
    ON [Core].[CreditRatingMap]([MeasureValue] ASC, [SP_Fitch] ASC) WITH (FILLFACTOR = 80);

