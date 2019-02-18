
CREATE VIEW [Compliance].[TradeViolations]
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
******************************/
AS 

SELECT	mstr.CADIS_RUN_ID,
		mstr.CADIS_ROW_ID,
		CAST(mstr.TRADEVIOLATION_DATE AS DATE) AS [Date], 
		CAST(mstr.VIOLATION_VIOLDATETIME AS DATETIME) AS [Time], 
		mstr.VIOLATION_VIOLGRPID AS GroupID, 
		mstr.VIOLATION_VIOLID AS ViolationID,
		mstr.RULE_RULECODE AS RuleID, 
		mstr.RULE_RULENAME AS RuleName, 
		mstr.TRADE_ORDERNUM AS [OrderNum], 
		mstr.TRADE_ALLOCTKTNUM AS AllocationTkt,
		mstr.TRADE_SETTLEDATE AS SettleDate, 
		mstr.TRADE_TKTFUNC AS [Application], 
		mstr.TRADE_TKTTYPE AS TktType, 
		mstr.ACCOUNTS_ACCOUNTNAME AS AcctCode, 
		mstr.TRADERNOTE_TRDRLOGIN AS TktWriter, 
		bkt.SECURITY_SECBUYSELL AS SecBuySell, 
		bkt.SECURITY_SECCURNCY AS SecCurncy,
		bkt.SECURITY_SECDESC AS SecDesc, 
		bkt.SECURITY_SECIDENT AS SecIdent,
		trd.NOTEDETAILS_NOTE AS TraderNote, 
		nte.NOTEDETAILS_NOTE AS LastNote, 
		nte.NOTEDETAILS_USER AS ApprLogin
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
	SELECT	ROW_NUMBER() OVER (PARTITION BY CADIS_RUN_ID, CADIS_PARENT_ID ORDER BY NOTEDETAILS_DATETIME DESC) AS ROWNUMBER, 
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
WHERE  mstr.VIOLATION_TYPE = 'Trade'
	AND mstr.VIOLATION_VIOLTYPE ='Trading'  



