﻿CREATE PROCEDURE [CADIS_SYS].[SPMQ_MESSAGEPEEK]
(
	@QUEUENAME NVARCHAR(50),
	-- NULL/0 First message
	-- > 0 Specific message
	@MSGID INT
)
AS
DECLARE @QUEUEID INT
SELECT @QUEUEID = ID FROM CADIS_SYS.MQ_QUEUE WHERE NAME = @QUEUENAME
SET @MSGID = ISNULL(@MSGID, 0)
IF @QUEUEID IS NOT NULL
BEGIN
	IF @MSGID > 0
	BEGIN
		-- Specific msg ID
		SELECT * FROM CADIS_SYS.MQ_MESSAGE WHERE QUEUEID=@QUEUEID AND ID=@MSGID
	END
	ELSE
	BEGIN
		-- First msg ID
		SELECT TOP 1 * FROM CADIS_SYS.MQ_MESSAGE WHERE QUEUEID=@QUEUEID ORDER BY PRIORITY ASC, ID ASC
	END
END