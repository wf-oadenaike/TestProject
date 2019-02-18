﻿

CREATE VIEW [dbo].[V_REF_UNQUOTED_FUNDING_STATUS_LOOKUP] AS

SELECT DISTINCT 

  FIELD_VALUE		as	NAME
 ,LOOKUP_VALUE		as VALUE

FROM T_REF_LOOKUP

WHERE	ENTITY			= 'UNQUOTED'
AND		SUB_ENTITY		= 'FUNDING'
AND		FIELD			= 'STATUS'

