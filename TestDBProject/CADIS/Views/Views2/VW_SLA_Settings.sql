﻿CREATE VIEW "CADIS"."VW_SLA_Settings"
AS
select 
	T1.[DataChannelID], 
	T1.[DataChannelName], 
	T2.[SOURCE], 
	T2.[ENTITY], 
	T2.[DESCRIPTION], 
	T2.[DIRECTION], 
	T2.[MARKIT_SOLUTION], 
	T2.[MORNING_CHECK], 
	T1.[EXPECTED_DELIVERY_TIME], 
	T1.[EXPECTED_SLA_COMPLETION], 
	T1.[IS_ACTIVE],
	T2.[DELIVERY_SCHEDULE_ID]
from
	"dbo"."T_DS_DATA_CHANNEL" T1	
join
	"dbo"."T_REF_SOURCE_SLA" T2
on
	T1.[DataChannelID] = T2.[DATA_CHANNEL_ID] 	

