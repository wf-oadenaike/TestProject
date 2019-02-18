
CREATE VIEW [TCA].[zzz_V_REC_BLOOMBERG_TCA_OUT]
AS

/********************************************************
-- Name: [TCA].[V_REC_BLOOMBERG_TCA_OUT]
-- Decription: Recs Bloomberg against TCA out.

** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
-- DAP-1858		23/03/2018  V.Khatri	Initial Version
-- 
********************************************************/

SELECT	Comparison.Order_ID,
	    BB_Order_ID,
		TCA_Order_ID,
		BB_Parent_Order_ID,
		TCA_Parent_Order_ID,
		BB_Broker_ID,
		TCA_Broker_ID,
		BB_account,
		TCA_account,
		BB_Side,
		TCA_Side,
		BB_ORDER_QUANTITY,
		TCA_ORDER_QUANTITY,
		BB_ALLOCATED_QUANTITY,
		TCA_ALLOCATED_QUANTITY,
		MATCHED_TYPE,
		CASE WHEN MATCHED_TYPE = 'UNMATCHED'
				THEN ISNULL(REASON,'')
				ELSE ''
		END						AS REASON
FROM
(
	SELECT  ISNULL(BB.Parent_Order_ID,TCA.Parent_Order_ID)  AS Parent_Order_ID,
			BB.Parent_Order_ID								AS BB_Parent_Order_ID,
			TCA.Parent_Order_ID								AS TCA_Parent_Order_ID,
			ISNULL(BB.Order_ID,TCA.Order_ID)					AS Order_ID,
			BB.Order_ID										AS BB_Order_ID,
			TCA.Order_ID									AS TCA_Order_ID,
			BB.Broker_ID									AS BB_Broker_ID,
			TCA.Broker_ID									AS TCA_Broker_ID,
			BB.account										AS BB_account,
			TCA.account										AS TCA_account,
			BB.Side											AS BB_Side,
			TCA.Side										AS TCA_Side,
			BB.ORDER_QUANTITY								AS BB_ORDER_QUANTITY,
			TCA.ORDER_QUANTITY								AS TCA_ORDER_QUANTITY,
			BB.ALLOCATED_QUANTITY							AS BB_ALLOCATED_QUANTITY,
			TCA.ALLOCATED_QUANTITY							AS TCA_ALLOCATED_QUANTITY,
			CASE
			  WHEN
				   (BB.Order_ID = TCA.Order_ID AND
				   BB.Broker_ID = TCA.Broker_ID AND
				   BB.account = TCA.account AND
				   BB.ORDER_QUANTITY = TCA.ORDER_QUANTITY AND
				   BB.ALLOCATED_QUANTITY = TCA.ALLOCATED_QUANTITY) THEN 'MATCHED'
			  ELSE 'UNMATCHED'
		 END                                    AS MATCHED_TYPE
	FROM
	(
	select 		ROOT_I_TSORDNUM			as Parent_Order_ID,
				I_TSORDNUM				as Order_ID,
				C_BROKER				as Broker_ID,
				C_ACCOUNT				as account,
				C_SIDE					as side,
				ORDER_QUANTITY,
				ALLOCATED_QUANTITY
	from	TCA.TCAOUT
	) BB
	FULL OUTER JOIN 
	(
	select	ParentOrderId			as Parent_Order_ID, 
			OrderId					as Order_ID, 
			isnull(brokerid,'')		as Broker_ID, 
			account					as account,
			side					as side, 
			orderSize				as order_Quantity, 
			isnull(shares,0)		as allocated_Quantity 
	from [TCA].[BETA_TCAOutputresults]
	) TCA
	ON			   BB.Order_ID = TCA.Order_ID AND
				   BB.Broker_ID = TCA.Broker_ID AND
				   BB.account = TCA.account AND
				   BB.Side	= TCA.Side AND
				   BB.ORDER_QUANTITY = TCA.ORDER_QUANTITY AND
				   BB.ALLOCATED_QUANTITY = TCA.ALLOCATED_QUANTITY
) Comparison
LEFT OUTER JOIN [TCA].[V_REC_BLOOMBERG_TCA_OUT_EXCEPTION_REASON] R
ON Comparison.ORDER_ID = R.ORDER_ID