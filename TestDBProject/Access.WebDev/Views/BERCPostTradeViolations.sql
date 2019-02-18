

CREATE VIEW [Access.WebDev].[BERCPostTradeViolations]
/******************************
** Desc: Compliance - Utilitised by the Investment Operations team via EDM data generators 
		 / functions to display Trader Violations and Notes
** Auth: R. Walker
** Date: 27/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1493     27/02/2018  R.Walker	Initial version of view
** DAP-2084     05/06/2018  R.Walker	Use new SecuritySourceIDs to get Security Name
** DAP-2091     24/07/2018  R.Walker	Add detailed Slack Commentary
** DAP-2325		04/10/2018  Olu			Add AsAtDate and AsOfDate
******************************/
AS 

SELECT	mstr.CADIS_RUN_ID,
		mstr.CADIS_ROW_ID,
		CAST(mstr.TRADEVIOLATION_DATE AS DATE) AS [Date], 
		CAST(mstr.VIOLATION_VIOLDATETIME AS DATETIME) AS [Time], 
		mstr.RULE_RULECODE AS RuleID, --
		mstr.RULE_RULENAME AS PostTradeExceptionCategory,
		mstr.TRADE_ALLOCTKTNUM AS TradeTicketNumber,
		bkt.SECURITY_SECDESC AS TradedSecurity,
		bkt.SECURITY_SECIDENT AS SecIdent,
		trd.NOTEDETAILS_NOTE AS TraderNotes,
		nte.NOTEDETAILS_NOTE AS LastNote,
		nte.NOTEDETAILS_USER AS ApprLogin,
		NULL AS DetailedReasonNotes, -- place holder - not yet available
		sec.Security_Name AS SecurityName,
		DATEPART(yy, TRADEVIOLATION_DATE) AS [Year],
		DATEPART(mm, TRADEVIOLATION_DATE) AS [Month],
		slck.OrderID AS slck_OrderID,
		slck.Narrative AS slck_Message,
		slck.PostedBy AS slck_PostedBy,
		slck.EventDate AS slck_Date,
		mstr.CADIS_SYSTEM_UPDATED as AsAtDate,
		mstr.CADIS_SYSTEM_INSERTED as AsofDate
FROM "dbo"."T_MASTER_COMPLIANCE_VIOL" mstr
LEFT OUTER JOIN "dbo"."T_MASTER_COMPLIANCE_VIOL_BUCKET" bkt
ON mstr.CADIS_RUN_ID = bkt.CADIS_RUN_ID
	AND  mstr.CADIS_ROW_ID = bkt.CADIS_PARENT_ID
LEFT OUTER JOIN "dbo"."T_MASTER_COMPLIANCE_VIOL_NOTE_DETAIL" trd
ON mstr.CADIS_RUN_ID = trd.CADIS_RUN_ID
	AND  mstr.CADIS_ROW_ID = trd.CADIS_PARENT_ID 
	AND  trd.NOTE_TYPE = 'Trader'
LEFT OUTER JOIN 
(
	SELECT	ROW_NUMBER() OVER (PARTITION BY CADIS_RUN_ID, CADIS_PARENT_ID ORDER BY NOTEDETAILS_DATETIME DESC) AS ROWNUMBER, -- get last set of notes published
			CADIS_RUN_ID, 
			CADIS_PARENT_ID, 
			CAST(NOTEDETAILS_DATETIME AS DATETIME) AS NOTEDETAILS_DATETIME, 
			NOTEDETAILS_NOTE, 
			NOTEDETAILS_USER 
	FROM "dbo"."T_MASTER_COMPLIANCE_VIOL_NOTE_DETAIL" 
	WHERE NOTE_TYPE = 'Normal'
) nte
ON mstr.CADIS_RUN_ID = nte.CADIS_RUN_ID
	AND  mstr.CADIS_ROW_ID = nte.CADIS_PARENT_ID
	AND nte.ROWNUMBER = 1
LEFT OUTER JOIN   dbo.Vw_SecuritySourceIDs sids
ON bkt.SECURITY_SECIDENT = sids.SECURITY_ID
LEFT OUTER JOIN   dbo.Vw_SecuritySourceIDs unq
ON unq.SECURITY_ID = IIF(CHARINDEX(' ', bkt.SECURITY_SECDESC) > 1, LEFT(bkt.SECURITY_SECDESC, CHARINDEX(' ', bkt.SECURITY_SECDESC) - 1), NULL)  -- handle unquoted securities
	AND unq.IDENTIFIER = 'TICKER'
	AND LEFT(bkt.SECURITY_SECDESC, 1) = '.'
LEFT OUTER JOIN   dbo.T_MASTER_SEC sec
ON COALESCE(sids.EDM_SEC_ID,unq.EDM_SEC_ID) = sec.EDM_SEC_ID	
	OUTER APPLY [dbo].[ufn_SlackCommentaryForOrderTree](mstr.TRADE_ORDERNUM) slck 
WHERE  mstr.VIOLATION_TYPE = 'Trade'
	AND mstr.VIOLATION_VIOLTYPE ='Trading'  
--	AND CONVERT(VARCHAR(6), CAST(mstr.TRADEVIOLATION_DATE AS DATE), 112) = CONVERT(VARCHAR(6), DATEADD(mm, -1, GETDATE()), 112) -- Get last full months worth of data





