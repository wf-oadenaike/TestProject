﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION531_INBOXSEL]
@PCTGROWTH DECIMAL (20, 10), @DAYSFWD INT, @DAYSBCK INT, @FLOW DECIMAL (20, 2), @OVERDRAFT_AMT DECIMAL (20, 2), @OVERDRAFT_DATE DATETIME, @TRANSFER_AMT DECIMAL (20, 2), @TRANSFER_DATE DATETIME, @FLOWLAG INT, @WhereSQL NVARCHAR (MAX), @PageNumber INT, @RowsIn INT, @Illustrate BIT, @SortColumnDef NVARCHAR (250), @SortColumn NVARCHAR (250), @SortColumnOrder VARCHAR (4), @DecodeJoinSql NVARCHAR (2000), @Username NVARCHAR (250), @RowsOut INT OUTPUT, @HasPrevious BIT OUTPUT, @HasNext BIT OUTPUT, @TotalNumberOfRows INT OUTPUT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


