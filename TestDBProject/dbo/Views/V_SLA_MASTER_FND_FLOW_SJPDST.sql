﻿
CREATE VIEW [dbo].[V_SLA_MASTER_FND_FLOW_SJPDST] AS

 SELECT TOP 1000 *

 FROM			T_MASTER_FND_FLOW 
 WHERE FUND_SHORT_NAME = 'SJPDST'
 ORDER BY CADIS_SYSTEM_UPDATED desc
   
