﻿


CREATE VIEW [dbo].[V_REF_UNQUOTED_REVALUATION_STATUS_INTERNAL_LOOKUP] AS

SELECT DISTINCT 

  FIELD_VALUE		as	NAME
 ,LOOKUP_VALUE		as VALUE

FROM T_REF_LOOKUP

WHERE	ENTITY			= 'UNQUOTED'
AND		SUB_ENTITY		= 'REVALUATION'
AND		FIELD			= 'STATUS_INTERNAL'

		
