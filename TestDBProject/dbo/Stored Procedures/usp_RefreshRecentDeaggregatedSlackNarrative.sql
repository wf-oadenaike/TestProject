CREATE PROCEDURE [dbo].[usp_RefreshRecentDeaggregatedSlackNarrative]
-------------------------------------------------------------------------------------- 
-- Name:			dbo.usp_RefreshRecentDeaggregatedSlackNarrative
-- 
-- Note:			This, and the table it populates, are intended to be a temporary
--					solution until Manywho is capable of requesting a function.  Then
--					we will return only the data they want, rather than actualizing a huge
--					slice of data for them to consume.
-- 
-- Author:			W.Stubbs
-- Date:			16/01/2018
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Wipe and populate a target table with the actualized results of a query
-------------------------------------------------------------------------------------- 
AS
BEGIN

delete from dbo.T_RecentDeaggregatedSlackNarrative

select * 
into #filteredorderinfo
from T_BBG_TCA_TRADE_ORDERS_AUDIT
where c_event in ('ACTIVATED ORDER'
					, 'ORDER ALLOCATED'
					, 'AGGREGATED FROM'
					, 'AGGREGATED TO'
					, 'E-SENT: ROUTED TO ELEC BRKR'
					, 'ALLOCATION CANCELLED')
;

WITH MyCTE 
	(BaseOrderID
	,AggrFromOrder
	,OrderID)
AS
(select distinct 
	i_TSORDNUM
	,i_TSORDNUM
	,i_TSORDNUM
from 
	#filteredorderinfo root
where c_Event = 'ACTIVATED ORDER' 
and D_DATE >= '01-SEP-2017' 

UNION ALL

select  
	root.BaseOrderID
	,branch.I_AGGRFROM
	,branch.i_TSORDNUM
from 

	#filteredorderinfo branch  
	inner join 	MyCTE root
	on root.OrderID = branch.I_AGGRFROM
		AND branch.I_AGGRFROM <> branch.I_TSORDNUM -- patch to cope with corrupt data where an order seems to aggregate to itself
	)
	

INSERT into dbo.T_RecentDeaggregatedSlackNarrative
SELECT 
DISTINCT MyCTE.BaseOrderID, MyCTE.OrderID , narr.EventDate, narr.PostedBy, narr.Narrative, narr.EventType

FROM MyCTE
left outer join
[TCA].[TCANarrativeEvents] narr
on MyCTE.ORDERID = narr.OrderId


END





