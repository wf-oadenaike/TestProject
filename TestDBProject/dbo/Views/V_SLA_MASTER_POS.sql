﻿
CREATE VIEW [dbo].[V_SLA_MASTER_POS] AS

  SELECT TOP 1000 p.*

 FROM			T_MASTER_POS p
 ORDER BY p.CADIS_SYSTEM_UPDATED desc
   
