﻿
CREATE VIEW [dbo].[V_SLA_MASTER_FND_FLOW_SJPHIY] AS

 SELECT TOP 1000 *

 FROM			T_MASTER_FND_FLOW 
 WHERE FUND_SHORT_NAME = 'SJPHIY'
 ORDER BY CADIS_SYSTEM_UPDATED desc
   
