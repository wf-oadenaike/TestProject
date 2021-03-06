﻿CREATE PROCEDURE [CADIS_SYS].[SPGETLOCKINFO]
(
@Guid nchar(33),
@Name nvarchar(250)
)
AS
SELECT 
	PL.COMPONENTID,
	VW_ALL.NAME,
	PL.LOCKEDBY,
	PL.LOCKACQUIRED,
	PL.LOCKID
FROM CADIS_SYS.CO_PROCESSLOCK  PL
INNER JOIN CADIS_SYS.VW_ALL_PROCESSES VW_ALL
ON 
VW_ALL.ComponentId =PL.COMPONENTID AND 
VW_ALL.NAME=@Name AND PL.GUID = @Guid
ORDER BY PL.LOCKID
