﻿CREATE VIEW dbo.V_REF_DATA_CHANNELS 
AS

SELECT	[DATACHANNELID], [DESCRIPTION] + ' - ' + CONVERT(VARCHAR(8),[EXPECTED_DELIVERY_TIME]) AS [DESCRIPTION] 
FROM	[CADIS].[VW_SLA_SETTINGS]

