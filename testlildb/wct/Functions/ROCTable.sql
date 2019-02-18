CREATE FUNCTION [wct].[ROCTable]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [idx]               INT        NULL,
        [ppred]             FLOAT (53) NULL,
        [failure]           INT        NULL,
        [success]           INT        NULL,
        [cumfailure]        INT        NULL,
        [cumsuccess]        INT        NULL,
        [FalsePositiveRate] FLOAT (53) NULL,
        [TruePositiveRate]  FLOAT (53) NULL,
        [AUROC]             FLOAT (53) NULL,
        [cumAUROC]          FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ROCTable]

