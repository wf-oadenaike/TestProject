

CREATE FUNCTION [dbo].[ufn_SlackCommentaryForOrderTree]
(
    @BaseOrderID int 
)
returns @OutputTable table
(
	 BaseOrderID					int
	,OrderID						int
	,EventDate						datetime
	,PostedBy						varchar(50)
	,Narrative						varchar(max)
	,EventType						varchar(50)	
	,NarrativeEventid				int
)

-------------------------------------------------------------------------------------- 
-- Name:			dbo.ufn_SlackCommentaryForOrderTree
-- 
-- Note:			Returns the slack commentary for the full tree of the supplied base
--					order ID
-- 
-- Author:			W.Stubbs
-- Date:			16/01/2018
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Supplied with base orderID, returns all slack commentary for it
--					and its children
--					
--					RW - Alter the join to bring back Base Order Slack as well as child
-------------------------------------------------------------------------------------- 
as

begin

insert into  @OutputTable
select DISTINCT deagg.OrderID, narr.OrderId AS Child_Order_ID , narr.EventDate, narr.PostedBy, narr.Narrative, narr.EventType,narr.NarrativeEventid

from [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] deagg
left outer join
[TCA].[TCANarrativeEvents] narr
on (deagg.OrderId = narr.OrderId OR deagg.Child_Order_Id = narr.OrderId)
where deagg.orderID = @BaseOrderID
and narr.narrative is not null

RETURN

END


