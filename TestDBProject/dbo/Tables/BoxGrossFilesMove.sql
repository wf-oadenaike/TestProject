CREATE TABLE [dbo].[BoxGrossFilesMove] (
    [Createdate] DATETIME     CONSTRAINT [DF_BoxGrossFilesMove_Createdate] DEFAULT (getdate()) NOT NULL,
    [FileName]   VARCHAR (50) NOT NULL
);

