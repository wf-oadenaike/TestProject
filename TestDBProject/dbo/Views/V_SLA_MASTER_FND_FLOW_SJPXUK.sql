﻿
CREATE VIEW [dbo].[V_SLA_MASTER_FND_FLOW_SJPXUK] AS

 SELECT TOP 1000 *

 FROM			T_MASTER_FND_FLOW 
 WHERE FUND_SHORT_NAME = 'SJPXUK'
 ORDER BY CADIS_SYSTEM_UPDATED desc
   