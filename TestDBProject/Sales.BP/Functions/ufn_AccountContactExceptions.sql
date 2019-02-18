
CREATE FUNCTION [Sales.BP].[ufn_AccountContactExceptions]
(@ExceptionStatus varchar(30), @AccountOwnerId varchar(18))

RETURNS @Output TABLE
(
SfAccountID varchar(18) primary key NOT NULL,
SfAccountName varchar(2000) NULL,
SfAccountOwnerID varchar(18) NULL,
SfAccountOwner varchar (256) NULL,
SalesforceHyperlink varchar(100) NULL,
AccountExceptionCnt integer NULL,
ContactExceptionCnt integer NULL
)

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[ufn_AccountContactExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867 Returns counts of Account and Contact Exceptions per Salesforce Account. Filters on Account Owner if Id passed in.
-- R.Dixon: 28/09/2017 JIRA: DAP-1289 Return salesforceHyperlink field for account IDs
-- V.Khatri: 03/05/2018 JIRA: DAP-1753 Removed char(15) restriction on SFA.AccountOwnerId. left(SFA.AccountOwnerId,15) -> SFA.AccountOwnerId 
-- V.Khatri: 19/06/2018 JIRA: DAP-2045 Added code to ignore duplicate accounts.
-- 
-------------------------------------------------------------------------------------- 

BEGIN

IF @AccountOwnerId = 'All' set @AccountOwnerId = NULL

INSERT	@Output
	SELECT	top 1000000 SFA.SfAccountId,
		SFA.AccountName, 
		SFA.AccountOwnerId,
		P.PersonsName AS AccountOwner,
		REF.[URL] + sfa.sfAccountID AS SalesforceHyperlink,
		ISNULL(ACC.AccountExceptionCnt,0) AS AccountExceptionCnt,
		ISNULL(CON.ContactExceptionCnt,0) AS ContactExceptionCnt
FROM	[Sales.BP].[SfAccountvw] SFA
LEFT	OUTER JOIN CADIS_SYS.CO_DBPARM DBP
ON		DBP.name = 'EnvironmentDescription'
LEFT	OUTER JOIN dbo.T_REF_SF_URL REF
ON		REF.ENV = DBP.[VALUE]
LEFT	OUTER JOIN [Core].[Persons] P
ON		SFA.AccountOwnerId = P.FullEmployeeBK
LEFT	OUTER	JOIN 
		(SELECT	sf_SfAccountId,
				COUNT(*) As AccountExceptionCnt
		FROM	[Sales.BP].AccountOverride AO
WHERE	Overridestatus IN (select splitdata FROM [dbo].[ufnSplitString](replace(@ExceptionStatus,'''',''),','))
		GROUP	BY sf_SfAccountId
		) ACC
ON		ACC.sf_SfAccountId = SFA.sfAccountId 
LEFT	OUTER	JOIN 
		(SELECT	sf_SfAccountId,
				COUNT(*) As ContactExceptionCnt
		FROM	[Sales.BP].ContactOverride CO
		WHERE	Overridestatus IN (select splitdata FROM [dbo].[ufnSplitString](replace(@ExceptionStatus,'''',''),','))
		GROUP	BY sf_SfAccountId
		) CON
ON		CON.sf_SfAccountId = SFA.sfAccountId 
WHERE	(ACC.AccountExceptionCnt > 0 OR CON.ContactExceptionCnt > 0)
AND		SFA.AccountOwnerId = ISNULL(@AccountOwnerId, SFA.AccountOwnerId)
AND		SFA.SfAccountId not in (select SALESFORCE_ACCOUNT_ID from T_MATRIX_DUPLICATEACCOUNT)
ORDER	BY SFA.AccountName ASC

RETURN 
END
