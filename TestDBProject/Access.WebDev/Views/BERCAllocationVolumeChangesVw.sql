
CREATE VIEW [Access.WebDev].[BERCAllocationVolumeChangesVw]
/******************************
** Desc:
** Auth: R.Walker
** Date: 02/08/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-2090     02/08/2018  R.Walker   Initial version of view
*******************************/
AS

SELECT
	[OrderDate],
	[Year],
	[Month],
	Activated_Order, 
	Activated_Account, 
	Activated_Order_Amount, 
	Activated_Order_Pct, 
	Allocated_Order, 
	Allocated_Account, 
	Allocated_Order_Amount, 
	Allocated_Order_Pct,
	Stock,
	slck.OrderID AS slck_OrderID,
	slck.Narrative AS slck_Message,
	slck.PostedBy AS slck_PostedBy,
	slck.EventDate AS slck_Date,
	CADIS_SYSTEM_INSERTED AS AsOfDate,
	CADIS_SYSTEM_INSERTED AS AsAtDate		
FROM [Access.WebDev].[AllocationVolumeChanges]
OUTER APPLY [dbo].[ufn_SlackCommentaryForOrderTree] (COALESCE(Activated_Order, Allocated_Order)) slck 
WHERE COALESCE(Activated_Order, Allocated_Order) IN (SELECT COALESCE(Activated_Order, Allocated_Order) AS OrderID FROM [Access.WebDev].[AllocationVolumeChanges] WHERE ROUND([Activated_Order_Pct],2) <> ROUND([Allocated_Order_Pct],2))
--ORDER BY COALESCE(Activated_Order, Allocated_Order)


