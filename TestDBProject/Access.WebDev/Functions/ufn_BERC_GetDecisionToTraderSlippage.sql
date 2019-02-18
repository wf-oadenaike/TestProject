

CREATE FUNCTION [Access.WebDev].[ufn_BERC_GetDecisionToTraderSlippage]
(
	@TradeDateFrom DATE = NULL,
	@TradeDateTo DATE = NULL,
	@DecisionToTraderElapsedMinutes INT = NULL,
	@ApprovalToTraderElapsedTimeInMinutes INT = NULL
)
RETURNS @Output TABLE (
		OrderID									INTEGER NULL,
		ChildOrderID							INTEGER NULL,
		SecurityName							VARCHAR(100) NULL,
		Country									VARCHAR(50) NULL,
		NotionalValueGBP						DECIMAL(19,2) NULL,
		DecisionDateTimeGMT						DATETIME NULL,
		TraderDateTimeGMT						DATETIME NULL,
		DecisionToTraderElapsedTimeInMinutes	INTEGER NULL,
		ApprovalToTraderElapsedTimeInMinutes	INTEGER NULL,
		ActivatedByUserId						VARCHAR(100) NULL,
		ActivatedByUserName						VARCHAR(100) NULL,
		ActivatedByUserDepartment				VARCHAR(100) NULL,
		AsAtDate								DATETIME NULL,
		AsOfDate								DATETIME NULL
)
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 04/05/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1013     21/02/2018  D.Fanning   Return orders where elapsed time between decisions and trade is >= than supplied time in minutes.
** DAP-2086     12/06/2018  D.Fanning   Update the timely execution to trader component to different tabs for fund manager and ops/compliance
** DAP-2159     12/06/2018  D.Fanning   Fix for aggregated trades, take the entry point (OrderId = ChildOrderId) and minimum decision and trade datetimes
** DAP-2137     06/07/2018  D.Fanning   ApprovalToTraderElapsedTimeInMinutes
** DAP-2325		04/10/2018  OLU			Add AsAtDate and AsOfDate
*******************************/
BEGIN
	IF @TradeDateFrom IS NULL
		SET @TradeDateFrom = DATEFROMPARTS(DATEPART(yyyy, DATEADD(month, -12, CAST(GetDate() as date))), DATEPART(mm, DATEADD(month, -12, CAST(GetDate() as date))), 1);

	IF @TradeDateTo IS NULL
		SET @TradeDateTo = EOMONTH(DATEADD(month, -1, CAST(GetDate() as date)));

	IF @DecisionToTraderElapsedMinutes IS NULL
		SET @DecisionToTraderElapsedMinutes = 30;

	IF @ApprovalToTraderElapsedTimeInMinutes IS NULL
		SET @ApprovalToTraderElapsedTimeInMinutes = 5;
		
	INSERT INTO @Output
	(
		OrderID,
		ChildOrderID,
		SecurityName,
		Country,
		NotionalValueGBP,
		DecisionDateTimeGMT,
		TraderDateTimeGMT,
		DecisionToTraderElapsedTimeInMinutes,
		ApprovalToTraderElapsedTimeInMinutes,
		ActivatedByUserId,
		ActivatedByUserName,
		ActivatedByUserDepartment,
		AsAtDate,								
		AsOfDate								
	)
	SELECT 
		X.OrderID,
		X.ChildOrderID,
		X.SecurityName,
		X.Country,
		X.NotionalValueGBP,
		X.DecisionDateTimeGMT,
		X.TraderDateTimeGMT,
		X.DecisionToTraderElapsedTimeInMinutes,
		X.ApprovalToTraderElapsedTimeInMinutes,
		X.ActivatedByUserId,
		ActivatedByUserName = ISNULL(P.PersonsName, ''),
		ActivatedByUserDepartment = ISNULL(D.DepartmentName, ''),
		LastUpdatedDate,
		AsOfDate
	FROM
	(
		SELECT
			ITG.OrderID,
			ChildOrderID = ITG.Child_Order_Id,
			SecurityName = MAX(ITG.Security_Name),
			Country = MAX(ITG.Country),
			NotionalValueGBP = SUM(ITG.Total_Value),
			DecisionDateTimeGMT = MIN(ITG.origDecisionDate),
			TraderDateTimeGMT = MIN(ITG.origTraderDate),
			DecisionToTraderElapsedTimeInMinutes = ABS(DATEDIFF(minute, MIN(ITG.origDecisionDate), MIN(ITG.origTraderDate))),
			ApprovalToTraderElapsedTimeInMinutes = ABS(DATEDIFF(minute, MIN(ITG.origReleaseDate), MIN(ITG.origTraderDate))),
			ActivatedByUserId =	(
								SELECT TOP 1 C_USER from [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] X
								WHERE X.I_TSORDNUM = ITG.OrderID
								AND C_EVENT IN ('ACTIVATED ORDER')
								ORDER BY I_AUDITID
								),
		MAX(CADIS_SYSTEM_UPDATED) AS LastUpdatedDate,
		 MAX(ITG.origTraderDate) AS AsOfDate
		 
		FROM
			T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED ITG
		WHERE
			CAST(ITG.Trade_Date_Time as date) >= @TradeDateFrom
		AND CAST(ITG.Trade_Date_Time as date) <= @TradeDateTo
		AND ITG.OrderID = ITG.Child_Order_Id
		GROUP BY
			ITG.OrderID,
			ITG.Child_Order_Id
	) X
	LEFT OUTER JOIN
		[Core].[Persons] P ON X.ActivatedByUserID = P.BloombergID
	LEFT OUTER JOIN
		[Core].[Departments] D ON D.DepartmentId = P.DepartmentId
	WHERE
		(X.DecisionToTraderElapsedTimeInMinutes >= @DecisionToTraderElapsedMinutes
	OR X.ApprovalToTraderElapsedTimeInMinutes >= @ApprovalToTraderElapsedTimeInMinutes)

	RETURN
END

