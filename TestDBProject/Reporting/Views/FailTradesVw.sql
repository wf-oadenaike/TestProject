
CREATE VIEW [Reporting].[FailTradesVw]
as
SELECT  F.Trade_Date					as Trade_date,
		F.Broker,
		b.C_BROKER						as BB_Broker,
        SECURITY_NAME			   as Security_Name,
	    INTERNAL_NOTES			   as Internal_Notes,
        COUNT(SECURITY_NAME)        AS Total_Failed_Trades,
        AVG(FS_AGE_ACTUAL)          AS Avg_Days_To_Resolve
FROM T_NT_Failed_Trade_Report F
LEFT OUTER JOIN [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] B WITH (NOLOCK)
    ON F.IM_REFERENCE = b.I_TKTNUM
    AND B.C_EVENT IN ('ORDER ALLOCATED', 'POSTTRAD ALLOC CXL/COR', 'CORRECTED ALLOCATION')
GROUP BY Trade_date,
         Broker,
		  b.C_BROKER,
         SECURITY_NAME,
		 INTERNAL_NOTES
