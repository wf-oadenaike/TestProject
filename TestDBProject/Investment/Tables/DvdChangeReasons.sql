CREATE TABLE [Investment].[DvdChangeReasons] (
    [DvdChangeReasonId]   INT           IDENTITY (1, 1) NOT NULL,
    [DvdChangeReason]     VARCHAR (128) NOT NULL,
    [DvdChangeReasonType] VARCHAR (25)  NOT NULL,
    CONSTRAINT [PKDvdChangeReasons] PRIMARY KEY CLUSTERED ([DvdChangeReasonId] ASC)
);

