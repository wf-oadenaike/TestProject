﻿CREATE PROCEDURE [CADIS_SYS].[SPMQ_MESSAGEINS]
(
	@QUEUENAME NVARCHAR(50),
	@LABEL NVARCHAR(50),
	@PRIORITY TINYINT,
	@MESSAGE NVARCHAR(MAX)
)
AS
DECLARE @QUEUEID INT
SELECT @QUEUEID = ID FROM CADIS_SYS.MQ_QUEUE WHERE NAME = @QUEUENAME
IF @QUEUEID IS NULL
	SELECT RESULT = -1
ELSE
BEGIN
	INSERT CADIS_SYS.MQ_MESSAGE (QUEUEID, PRIORITY, LABEL, MESSAGE) VALUES (@QUEUEID, @PRIORITY, @LABEL, @MESSAGE)
	SELECT RESULT=SCOPE_IDENTITY()
END
