CREATE PROC [dbo].[USP_Matrix_ContactUpdate]
-------------------------------------------------------------------------------------- 
-- NAME:  		[dbo].[USP_Matrix_ContactUpdate]
-- 
-- NOTE:			Update contact table against salesforce contact for Boomi to update into salesforce
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			16/04/2018
-------------------------------------------------------------------------------------- 
-- DESCRIPTION:		Update table for Boomi to update into salesforce
-- HISTORY:			
-- 16-04-2018		VIPUL KHATRI			DAP-1753      -- Update Contact SF table for Boomi to update into salesforce
-- 26-06-2018		VIPUL KHATRI			DAP-2045      -- Removed verifiedby from identical logic.
-- 11-07-2018		VIPUL KHATRI			DAP-2195      -- Account/Contact feed changes release.
-- 19-07-2018		JOE TAPPER				DAP-2045      -- Adjusted MOVER and DUPLICATE ACCOUNT logic.
-- 01-08-2018		Rob Walker				DAP-2241	  -- Prevent exceptions processes for contacts and accounts picking up the wrong owner details
-- 30-08-2018		Rob Walker				DAP-2300	  -- Tweak the export status logic


AS

BEGIN TRY


	 -- Load into temporary tables -------------------------------------------------------------------------------------------------------------------------

     --- MATRIX_Contact DATA. 
     IF OBJECT_ID('TEMPDB..#MATRIX_CONTACT') IS NOT NULL
          DROP TABLE #MATRIX_CONTACT

	CREATE TABLE #MATRIX_CONTACT (
		 CntSalesforceId           varchar(18)   NOT NULL,
		 Type                      varchar(7)    NOT NULL,
		 CntAccountSalesforceId    varchar(18)   NULL,
		 CntFcaId                  varchar(20)   NULL,
		 CntAccountFcaId           varchar(20)   NULL,
		 CntOwnerId                varchar(18)   NULL,
		 CntOwnerName              varchar(200)  NULL,
		 CntAccountSivId           varchar(100)  NULL,
		 CntSivId                  varchar(100)  NOT NULL,
		 CntMatrixId               varchar(20)   NULL,
		 CntSalutation             varchar(20)   NULL,
		 CntFirstName              varchar(100)  NULL,
		 CntLastName               varchar(100)  NULL,
		 CntJobTitle               varchar(100)  NULL,
		 CntMailingStreet          varchar(1000) NULL,
		 CntMailingCity            varchar(100)  NULL,
		 CntMailingState           varchar(100)  NULL,
		 CntMailingPostcode        varchar(100)  NULL,
		 CntMailingPostcodeMapping varchar(10)   NULL,
		 CntMailingCountry         varchar(100)  NULL,
		 CntLandline               varchar(50)   NULL,
		 CntMobile                 varchar(50)   NULL,
		 CntFax                    varchar(50)   NULL,
		 CntEmail                  varchar(128)  NULL,
		 CntIsCf1                  varchar(5)    NULL,
		 CntIsCf2                  varchar(5)    NULL,
		 CntIsCf3                  varchar(5)    NULL,
		 CntIsCf4                  varchar(5)    NULL,
		 CntIsCf10                 varchar(5)    NULL,
		 CntIsCf11                 varchar(5)    NULL,
		 CntIsCf30                 varchar(5)    NULL,
		 CntVerifiedBy             varchar(100)  NULL,
		 AsAtDate                  datetime      NOT NULL,
		 FCAStatus                 varchar(50)   NULL,
		 MFIDStatus                varchar(100)  NULL,
		 isPriority                varchar(10)   NULL,
		 IsLocked                  varchar(10)   NULL,
		 AccBillingPostcodeMapping varchar(10)   NULL 			
	)

	INSERT INTO #MATRIX_CONTACT
	(	
		CntSalesforceId,
		Type,
		CntAccountSalesforceId,
		CntFcaId,
		CntAccountFcaId,
		CntOwnerId,
		CntOwnerName,
		CntAccountSivId,
		CntSivId,
		CntMatrixId,
		CntSalutation,
		CntFirstName,
		CntLastName,
		CntJobTitle,
		CntMailingStreet,
		CntMailingCity,
		CntMailingState,
		CntMailingPostcode,
		CntMailingPostcodeMapping,
		CntMailingCountry,
		CntLandline,
		CntMobile,
		CntFax,
		CntEmail,
		CntIsCf1,
		CntIsCf2,
		CntIsCf3,
		CntIsCf4,
		CntIsCf10,
		CntIsCf11,
		CntIsCf30,
		CntVerifiedBy,
		AsAtDate,
		FCAStatus,
		MFIDStatus,
		isPriority,
		IsLocked,
		AccBillingPostcodeMapping
	)
	SELECT SfContactId            AS CntSalesforceId,
		   'Contact'              AS Type,
		   SfAccountId            AS CntAccountSalesforceId,
		   FcaId                  AS CntFcaId,
		   AccountFcaId           AS CntAccountFcaId,
		   ContactOwnerId         AS CntOwnerId,
		   ContactOwnerName       AS CntOwnerName,
		   isnull(AccountSivId,' ')        AS CntAccountSivId,
		   ContactSivId           AS CntSivId,
		   isnull(ContactMatrixId,' ')        AS CntMatrixId,
		   Salutation             AS CntSalutation,
		   FirstName              AS CntFirstName,
		   LastName               AS CntLastName,
		   JobTitle               AS CntJobTitle,
		   NULL					  AS CntMailingStreet,
		   NULL				      AS CntMailingCity,
		   NULL					  AS CntMailingState,
		   NULL					  AS CntMailingPostcode,
		   NULL					  AS CntMailingPostcodeMapping,
		   NULL					  AS CntMailingCountry,
		   Phone                  AS CntLandline,
		   Mobile                 AS CntMobile,
		   Fax                    AS CntFax,
		   EmailAddress           AS CntEmail,
		   IsCf1                  AS CntIsCf1,
		   IsCf2                  AS CntIsCf2,
		   IsCf3                  AS CntIsCf3,
		   IsCf4                  AS CntIsCf4,
		   IsCf10                 AS CntIsCf10,
		   IsCf11                 AS CntIsCf11,
		   IsCf30                 AS CntIsCf30,
		   VerifiedBy             AS CntVerifiedBy,
		   AsAtDate               AS AsAtDate,
		   FCAStatus              AS FCAStatus,
		   MfidStatus             AS MfidStatus,
		   NULL                   AS isPriority,
		   NULL                   AS IsLocked,
		   NULL					  AS AccBillingPostcodeMapping
	FROM [Sales.BP].[MxContactVw]

	-- Update SFAccountId for movers using salesforce data
	update C
	set CntAccountSalesforceId = SA.SfAccountId
	FROM  #MATRIX_CONTACT C
	inner join [Sales.BP].[sfcontactVw] SC
	on c.CntSivId = SC.ContactSivId
	left outer join [Sales.BP].[sfaccountVw] SA
	on SA.AccountSivId = c.CntAccountsivId
	where (c.CntAccountSivId <> SC.AccountSivId or c.cntAccountsalesforceid <> sc.sfaccountid)

	-- Update SFAccountId for movers which doesn't salesforce data
	update c
	set CntAccountSalesforceId = a.SfAccountId 
	FROM  #MATRIX_CONTACT C
	inner join [sales.bp].[mxaccountvw] a
	on c.CntAccountSivId = a.AccountSivId
	and C.CntAccountSalesforceId <> a.SfAccountId
	left outer join [Sales.BP].[sfcontactVw] SC
	on c.CntSivId = SC.ContactSivId
	where SC.ContactSivId is null 


     --- SALESFORCE CONTACT DATA -------------------------------------------
     IF OBJECT_ID('TEMPDB..#SF_CONTACT') IS NOT NULL
          DROP TABLE #SF_CONTACT

	CREATE TABLE #SF_CONTACT (
		 CntSalesforceId                nvarchar(2000) NOT NULL,
		 CntAccountSalesforceId         nvarchar(2000) NOT NULL,
		 CntFcaId                       nvarchar(2000) NULL,
		 CntAccountFcaId                nvarchar(2000) NULL,
		 CntOwnerId                     nvarchar(2000) NULL,
		 CntOwnerName                   nvarchar(2000) NULL,
		 CntAccountSivId                nvarchar(2000) NULL,
		 CntSivId                       nvarchar(2000) NULL,
		 CntMatrixId                    nvarchar(2000) NULL,
		 CntSalutation                  nvarchar(2000) NULL,
		 CntFirstName                   nvarchar(2000) NULL,
		 CntLastName                    nvarchar(2000) NULL,
		 CntJobTitle                    nvarchar(2000) NULL,
		 CntMailingStreet               nvarchar(2000) NULL,
		 CntMailingCity                 nvarchar(2000) NULL,
		 CntMailingState                nvarchar(2000) NULL,
		 CntMailingPostcode             nvarchar(2000) NULL,
		 CntMailingPostcodeMapping      nvarchar(2000) NULL,
		 CntMailingCountry              nvarchar(2000) NULL,
		 CntLandline                    nvarchar(2000) NULL,
		 CntMobile                      nvarchar(2000) NULL,
		 CntFax                         nvarchar(2000) NULL,
		 CntEmail                       nvarchar(2000) NULL,
		 CntIsCf1                       nvarchar(2000) NULL,
		 CntIsCf2                       nvarchar(2000) NULL,
		 CntIsCf3                       nvarchar(2000) NULL,
		 CntIsCf4                       nvarchar(2000) NULL,
		 CntIsCf10                      nvarchar(2000) NULL,
		 CntIsCf11                      nvarchar(2000) NULL,
		 CntIsCf30                      nvarchar(2000) NULL,
		 CntVerifiedBy                  nvarchar(2000) NULL,
		 CntExistingCompanyRelationship nvarchar(2000) NULL,
		 AccountIsPriorityClient        varchar(10)    NULL,
		 AccountIsLocked                varchar(10)    NULL,
		 AccountRecordtypeName          varchar(50)    NULL
	)

	Insert into #SF_CONTACT
	(
			CntSalesforceId,
			CntAccountSalesforceId,
			CntFcaId,
			CntAccountFcaId,
			CntOwnerId,
			CntOwnerName,
			CntAccountSivId,
			CntSivId,
			CntMatrixId,
			CntSalutation,
			CntFirstName,
			CntLastName,
			CntJobTitle,
			CntMailingStreet,
			CntMailingCity,
			CntMailingState,
			CntMailingPostcode,
			CntMailingPostcodeMapping,
			CntMailingCountry,
			CntLandline,
			CntMobile,
			CntFax,
			CntEmail,
			CntIsCf1,
			CntIsCf2,
			CntIsCf3,
			CntIsCf4,
			CntIsCf10,
			CntIsCf11,
			CntIsCf30,
			CntVerifiedBy,
			CntExistingCompanyRelationship,
			AccountIsPriorityClient,
			AccountIsLocked,
			AccountRecordtypeName
	)

	SELECT C.SfContactId                 AS CntSalesforceId,
		   C.SfAccountId                 AS CntAccountSalesforceId,
		   C.FcaId                       AS CntFcaId,
		   C.AccountFcaId                AS CntAccountFcaId,
		   C.ContactOwnerId              AS CntOwnerId,
		   C.ContactOwnerName            AS CntOwnerName,
		   C.AccountSivId                AS CntAccountSivId,
		   isnull(C.ContactSivId,'')     AS CntSivId,
		   C.ContactMatrixId             AS CntMatrixId,
		   C.Salutation                  AS CntSalutation,
		   C.FirstName                   AS CntFirstName,
		   C.LastName                    AS CntLastName,
		   C.JobTitle                    AS CntJobTitle,
		   C.MailingStreet               AS CntMailingStreet,
		   C.MailingCity                 AS CntMailingCity,
		   C.MailingState                AS CntMailingState,
		   C.MailingPostcode             AS CntMailingPostcode,
		   C.MailingPostcodeMapping      AS CntMailingPostcodeMapping,
		   C.MailingCountry              AS CntMailingCountry,
		   C.Phone                       AS CntLandline,
		   C.Mobile                      AS CntMobile,
		   C.Fax                         AS CntFax,
		   C.EmailAddress                AS CntEmail,
		   C.IsCf1                       AS CntIsCf1,
		   C.IsCf2                       AS CntIsCf2,
		   C.IsCf3                       AS CntIsCf3,
		   C.IsCf4                       AS CntIsCf4,
		   C.IsCf10                      AS CntIsCf10,
		   C.IsCf11                      AS CntIsCf11,
		   C.IsCf30                      AS CntIsCf30,
		   C.VerifiedBy                  AS CntVerifiedBy,
		   C.ExistingCompanyRelationship AS CntExistingCompanyRelationship,
		   C.AccIsPriorityClient         AS AccountIsPriorityClient,
		   C.AccIsLocked                 AS AccountIsLocked,
		   C.AccRecordtypeName           AS AccountRecordtypeName
	FROM [Sales.BP].[SFContactVw] C
	INNER JOIN [Sales.BP].[SFAccountVw] A
		 ON C.SfAccountId = A.SfAccountId
	--WHERE c.ContactSivId IS NOT NULL


     --  Update priority and lock flag on Matrix data
	UPDATE C
	SET isPriority = S.IsPriorityClient,
		IsLocked   = S.IsLocked
	from #MATRIX_CONTACT C
	inner JOIN   [Sales.BP].[sfAccountVw] S
	ON C.CntAccountSalesforceId = S.SfAccountId

	--  Update AccBillingPostCodeMapping from Account table
	UPDATE C
	SET AccBillingPostcodeMapping = MA.BillingPostcodeMapping
	from #MATRIX_CONTACT C
	inner JOIN   [Sales.BP].[mxAccountVw] MA
	on C.CntAccountSivId = MA.AccountSivId 


	--- POST CODE OWNER DATA -------------------------------------------
	IF OBJECT_ID('TEMPDB..#POST_CODE_OWNER') IS NOT NULL
		 DROP TABLE #POST_CODE_OWNER

	CREATE TABLE #POST_CODE_OWNER (
     POST_CODE varchar(20) NOT NULL,
     OwnerName sysname     NULL,
     ownerId   varchar(18) NULL
	)

	INSERT INTO #POST_CODE_OWNER (
			POST_CODE,
			OwnerName,
			ownerId
			)
	
	SELECT  POST_CODE,
			PersonsName			AS OwnerName,
			FullEmployeeBK		as ownerId
	FROM V_SALESFORCE_POST_CODE_OWNER

    -- As the Boomi process is asyncronous, the audit table can be out of sync for the previous months run. 
	-- We need to update table T_MATRIX_PROCESS_SALESFORCE_ACCOUNT_AUDIT with saleforceId for ones which initially didn't exists and were created by Boomi. 
	
	Update A
	SET CntSalesforceId =  P.CntSalesforceId
	from T_MATRIX_PROCESS_SALESFORCE_CONTACT_AUDIT A
	INNER JOIN T_MATRIX_PROCESS_SALESFORCE_CONTACT P
	ON A.CntSivId = P.CntSivId
	AND A.AsAtDate =  P.AsAtDate
	AND A.CaseID =  P.CaseID
	WHERE A.CntSalesforceId = ''
	and A.CntSalesforceId <> P.CntSalesforceId	 

	 -- Load into final table -------------------------------------------------------------------------------------------------------------------------

     -- Truncate previous data
     TRUNCATE TABLE [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT]

     -- START TRANSACTION
     BEGIN TRANSACTION

    INSERT INTO [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] 
		(CntSivId,
		CntSalesforceId,
		AsAtDate,
		CaseID,
		Type,
		CntAccountSalesforceId,
		CntFcaId,
		CntAccountFcaId,
		CntOwnerId,
		CntOwnerName,
		CntAccountSivId,
		CntMatrixId,
		CntSalutation,
		CntFirstName,
		CntLastName,
		CntJobTitle,
		CntMailingStreet,
		CntMailingCity,
		CntMailingState,
		CntMailingPostcode,
		CntMailingCountry,
		CntLandline,
		CntMobile,
		CntFax,
		CntEmail,
		CntIsCf1,
		CntIsCf2,
		CntIsCf3,
		CntIsCf4,
		CntIsCf10,
		CntIsCf11,
		CntIsCf30,
		CntVerifiedBy,
		FCAStatus,	
		MfidStatus,
		IsActive,
		AccountIsPriorityClient,
		AccountIsLocked	
	)

	-- Case 1 -- Updates
	SELECT MX.CntSivId,
		   mx.CntSalesforceId,
		   MX.AsAtDate,
		   1   AS CaseID,
		   Mx.Type,
		   mx.CntAccountSalesforceId,
		   MX.CntFcaId,
		   MX.CntAccountFcaId,
		   PO.ownerId					AS CntOwnerId,
		   PO.OWNERNAME					AS CntOwnerName,
		   MX.CntAccountSivId,
		   MX.CntMatrixId,
		   MX.CntSalutation,
		   MX.CntFirstName,
		   MX.CntLastName,
		   MX.CntJobTitle,
		   MX.CntMailingStreet,
		   MX.CntMailingCity,
		   MX.CntMailingState,
		   MX.CntMailingPostcode,
		   MX.CntMailingCountry,
		   MX.CntLandline,
		   MX.CntMobile,
		   MX.CntFax,
		   MX.CntEmail,
		   MX.CntIsCf1,
		   MX.CntIsCf2,
		   MX.CntIsCf3,
		   MX.CntIsCf4,
		   MX.CntIsCf10,
		   MX.CntIsCf11,
		   MX.CntIsCf30,
		   MX.CntVerifiedBy,
		   MX.FCAStatus,
		   MX.MfidStatus,
		   mx.MFIDStatus			IsActive,
		   mx.IsPriority			AccountIsPriorityClient,
		   mx.IsLocked				AccountIsLocked	
	FROM #MATRIX_CONTACT MX
	INNER JOIN #SF_CONTACT SF
		 ON MX.CntSalesforceId = SF.CntSalesforceId
		 AND MX.CntAccountSalesforceId = SF.CntAccountSalesforceId
	LEFT OUTER JOIN #POST_CODE_OWNER PO
		ON MX.AccBillingPostcodeMapping = PO.POST_CODE

    UNION

    -- Case 2 -- Inserts
    SELECT MX.CntSivId,
		   mx.CntSalesforceId,
            MX.AsAtDate,
            2							AS CaseID,
            MX.Type,
            MX.CntAccountSalesforceId,
            MX.CntFcaId,
            MX.CntAccountFcaId,
            PO.ownerId,
            PO.OWNERNAME,
            MX.CntAccountSivId,
            MX.CntMatrixId,
            MX.CntSalutation,
            MX.CntFirstName,
            MX.CntLastName,
            MX.CntJobTitle,
            MX.CntMailingStreet,
            MX.CntMailingCity,
            MX.CntMailingState,
            MX.CntMailingPostcode,
            MX.CntMailingCountry,
            MX.CntLandline,
            MX.CntMobile,
            MX.CntFax,
            MX.CntEmail,
            MX.CntIsCf1,
            MX.CntIsCf2,
            MX.CntIsCf3,
            MX.CntIsCf4,
            MX.CntIsCf10,
            MX.CntIsCf11,
            MX.CntIsCf30,
            MX.CntVerifiedBy,
			MX.FCAStatus,	
			MX.MfidStatus,
			MX.MFIDStatus			as IsActive,
			'false'					as IsPriority,
			'false'					as IsLocked
    FROM #MATRIX_CONTACT MX
    LEFT OUTER JOIN #SF_CONTACT SF
        ON MX.CntSalesforceId = SF.CntSalesforceId
        AND MX.CntAccountSalesforceId = SF.CntAccountSalesforceId
	LEFT OUTER JOIN #POST_CODE_OWNER PO
		ON MX.AccBillingPostcodeMapping = PO.POST_CODE
    WHERE SF.CntSalesforceId IS NULL
    AND SF.CntAccountSalesforceId IS NULL

	UPDATE P
	SET CntOwnerId		= o.AccountOwnerId,
        CntOwnerName	= c.PersonsName
	FROM T_MATRIX_PROCESS_SALESFORCE_CONTACT P
	INNER JOIN T_SALESFORCE_POSTCODE_OVERRIDE O
	ON P.CntAccountSalesforceId = O.SfAccountId  
	INNER JOIN Core.Persons c
	ON O.AccountOwnerId = C.FullEmployeeBK
	WHERE o.overridestatus = 'Exported'

	-- Update ownerId and OwnerName when it is not specified.
	-- This will be changed in future to grab default owner from SF. Current logic is to default owner to Sophie.	
	UPDATE P
	SET CntOwnerId		= (SELECT FullEmployeeBK FROM [Core].[Persons] where personsName = 'Sophie Maton'),
        CntOwnerName	= (SELECT personsName FROM [Core].[Persons] where personsName = 'Sophie Maton')
	FROM [T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	WHERE CntOwnerId IS NULL
	AND (P.AccountIsPriorityClient = 'false' AND P.AccountIsLocked = 'false')

	-- Update inactive setting when matrix or FCA verified
	UPDATE P
	SET IsActive = 'Inactive' 
	FROM [T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	WHERE MfidStatus is null
	and CntVerifiedBy in ('MATRIX VERIFIED','FCA verified') 

-- Entries not in salesforce
	UPDATE P
	SET EXPORTSTATUS = 'NOT IN SALESFORCE'
	from  [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	where exportstatus = 'WAIT'
	and (P.AccountIsPriorityClient is null or P.AccountIsLocked is null)


	-- Exclude duplicate contacts
	UPDATE P
	SET EXPORTSTATUS = 'DUPLICATE CONTACT'
	FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	WHERE CntSalesforceId IN (
		 SELECT DISTINCT SALESFORCE_CONTACT_ID
		 FROM [dbo].T_MATRIX_DUPLICATECONTACT
	)
	and ExportStatus IN ('WAIT','IDENTICAL')

	-- Exclude duplicate accounts
	UPDATE P
	SET EXPORTSTATUS = 'DUPLICATE ACCOUNT'
	FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	WHERE CntAccountSalesforceId IN (
			 SELECT DISTINCT SALESFORCE_ACCOUNT_ID
			 FROM [dbo].T_MATRIX_DUPLICATEACCOUNT
	)
	and ExportStatus IN ('WAIT','IDENTICAL')

	UPDATE P
	SET EXPORTSTATUS = 'MOVERS'
	from [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
	INNER JOIN [Sales.BP].[sfcontactVw] a
	on P.CntSalesforceId = a.SfContactId
	where a.AccountSivId <> P.CntAccountSivId
	AND (a.AccIsPriorityClient = 'true' OR a.AccIsLocked = 'true')
	AND ExportStatus = 'WAIT'

	-- This is different from above DUPLICATE ACCOUNTS 
	UPDATE C
	SET EXPORTSTATUS = 'DUPLICATE ACCOUNT'
	from [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] C
	join T_MATRIX_PROCESS_SALESFORCE_ACCOUNT A 
	on A.accSivID = c.cntaccountsivid 
	where c.EXPORTSTATUS IN ('WAIT','IDENTICAL','MOVERS')
	AND A.EXPORTSTATUS = 'DUPLICATE ACCOUNT'  



	-- DAP-2241 Call the Matrix Exception proc here before Nulling columns out
	EXEC [Sales.BP].[usp_GenerateSalesforceMatrixContactExceptions]

	-- Update priority client and islocked dependent fields
	UPDATE P
	SET CntOwnerId = NULL,
		CntOwnerName = NULL,
		CntSalutation = CASE WHEN sf.isNameNull = 1
						THEN p.CntSalutation
					ELSE  NULL END,
		CntFirstName = CASE WHEN sf.isNameNull = 1
						THEN p.CntFirstName
					ELSE  NULL END,
		CntLastName = CASE WHEN sf.isNameNull = 1
						THEN p.CntLastName
					ELSE  NULL END,
		CntMailingStreet = CASE WHEN SF.IsMailingAddressNull = 1
						THEN p.CntMailingStreet
					ELSE  NULL END,
		CntMailingCity = CASE WHEN SF.IsMailingAddressNull = 1
						THEN p.CntMailingCity
					ELSE  NULL END,
		CntMailingState = NULL,
		CntMailingPostcode = CASE WHEN SF.IsMailingAddressNull = 1
						THEN p.CntMailingPostcode
					ELSE  NULL END,
		CntMailingCountry = CASE WHEN SF.IsMailingAddressNull = 1
						THEN p.CntMailingCountry
					ELSE  NULL END,
		CntLandline = CASE WHEN SF.Phone IS NULL 
						 THEN p.CntLandline
					  ELSE	NULL END,
		CntMobile = CASE WHEN SF.Mobile  IS NULL 
						 THEN p.CntMobile 
					  ELSE	NULL END,
		CntEmail = CASE WHEN SF.EmailAddress  IS NULL 
						 THEN p.CntEmail 
					  ELSE	NULL END,
		IsActive = CASE WHEN SF.IsActive is not null then NULL
						when p.isactive = 'Inactive' then NULL
						else p.isactive
					 end
	FROM [T_MATRIX_PROCESS_SALESFORCE_CONTACT] p
	LEFT OUTER JOIN [Sales.BP].[SfContactVw] SF
	ON P.CNTSALESFORCEID = SF.SfContactId
	AND P.CntAccountSalesforceId = SF.SfAccountId
	WHERE CntSalesforceId != ''
	AND (P.AccountIsPriorityClient = 'true'
	OR P.AccountIsLocked = 'true')

	-- Update any address fields to space when part of it is null
	update C
	set CntMailingStreet	= COALESCE(CntMailingStreet,' '),
		CntMailingCity		= COALESCE(CntMailingCity,' '),
		CntMailingPostcode	= COALESCE(CntMailingPostcode,' '),
		CntMailingCountry	= COALESCE(CntMailingCountry,' ') 
	FROM T_MATRIX_PROCESS_SALESFORCE_CONTACT C
	WHERE exportstatus = 'WAIT'
	and (CntMailingStreet is not null
	or CntMailingCity is not null
	or CntMailingPostcode is not null
	or CntMailingCountry is not null)
	AND (CntMailingStreet IS NULL OR CntMailingCity IS NULL OR CntMailingPostcode IS NULL OR CntMailingCountry IS NULL)

    -- Any Exclusions. Update exportStatus to reason why it doesn't need to be processed by Boomi.

    -- Identical AccPriorityClient = 'true' or ACCISLOCKED = 'true'
    UPDATE P
    SET EXPORTSTATUS = 'IDENTICAL'
    FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
    INNER JOIN [Sales.BP].[SFContactVw] S
        ON P.CntSalesforceId = S.SFContactID
		and P.CntAccountSalesforceId = S.SFAccountID
    WHERE P.EXPORTSTATUS = 'WAIT' 
	and (P.AccountIsPriorityClient = 'true' OR P.AccountIsLocked = 'true')
    AND COALESCE(P.CntFcaid, S.FcaId, '') = COALESCE(S.FcaId, '')
	AND COALESCE(P.CntAccountFcaId, S.AccountFcaId,'') = COALESCE(S.AccountFcaId, '')
    AND COALESCE(P.CntAccountSalesforceId, S.SfAccountId, '') = COALESCE(S.SfAccountId, '')
	AND COALESCE(P.CntOwnerId, S.ContactOwnerId, '') = COALESCE(S.ContactOwnerId, '')
    AND COALESCE(P.CntOwnerName, S.ContactOwnerName,'') = COALESCE(S.ContactOwnerName, '')
	AND COALESCE(P.CntAccountSivId, S.AccountSivId,'') = COALESCE(S.AccountSivId, '')
	AND COALESCE(P.CntSivId, S.ContactSivId,'') = COALESCE(S.ContactSivId, '')
    AND COALESCE(P.CntMatrixId, S.ContactMatrixId, '') = COALESCE(S.ContactMatrixId, '')
    AND COALESCE(P.CntSalutation, S.Salutation, '') = COALESCE(S.Salutation, '')
    AND COALESCE(P.CntJobTitle, S.JobTitle,'') = COALESCE(S.JobTitle, '')
    AND COALESCE(P.CntFax, S.Fax,'') = COALESCE(S.Fax, '')
	AND COALESCE(P.FCASTATUS, S.FCASTATUS,'') = COALESCE(S.FCASTATUS, '')
	AND COALESCE(P.MFIDSTATUS, S.MFIDSTATUS,'') = COALESCE(S.MFIDSTATUS, '')
	AND COALESCE(P.IsActive, S.IsActive,'') = COALESCE(S.IsActive, '')
AND (CASE
        WHEN P.CntIsCf1 = 'true' THEN 'Y'
		WHEN P.CntIsCf1 = 'false' THEN 'N'
        ELSE S.IsCf1
    END) = S.IsCf1
    AND (CASE
        WHEN P.CntIsCf2 = 'true' THEN 'Y'
		WHEN P.CntIsCf2 = 'false' THEN 'N'
        ELSE S.IsCf2
    END) = S.IsCf2
    AND (CASE
        WHEN P.CntIsCf3 = 'true' THEN 'Y'
		WHEN P.CntIsCf3 = 'false' THEN 'N'
        ELSE S.IsCf3
    END) = S.IsCf3
    AND (CASE
        WHEN P.CntIsCf4 = 'true' THEN 'Y'
		WHEN P.CntIsCf4 = 'false' THEN 'N'
        ELSE S.IsCf4
    END) = S.IsCf4
    AND (CASE
        WHEN P.CntIsCf10 = 'true' THEN 'Y'
		WHEN P.CntIsCf10 = 'false' THEN 'N'
        ELSE S.IsCf10
    END) = S.IsCf10
    AND (CASE
        WHEN P.CntIsCf11 = 'true' THEN 'Y'
		WHEN P.CntIsCf11 = 'false' THEN 'N'
        ELSE S.IsCf11
    END) = S.IsCf11
    AND (CASE
        WHEN P.CntIsCf30 = 'true' THEN 'Y'
		WHEN P.CntIsCf30 = 'false' THEN 'N'
        ELSE S.IsCf30
    END) = S.IsCf30

	-- Identical AccPriorityClient = 'false' and ACCISLOCKED = 'false'
    UPDATE P
    SET EXPORTSTATUS = 'IDENTICAL'
    FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] P
    INNER JOIN [Sales.BP].[SFContactVw] S
        ON P.CntSalesforceId = S.SFContactID
		and P.CntAccountSalesforceId = S.SFAccountID
    WHERE P.EXPORTSTATUS = 'WAIT' 
	and (P.AccountIsPriorityClient = 'false' AND P.AccountIsLocked = 'false')
    AND COALESCE(P.CntFcaid, S.FcaId,'') = COALESCE(S.FcaId, '')
	AND COALESCE(P.CntAccountFcaId, S.AccountFcaId,'') = COALESCE(S.AccountFcaId, '')
    AND COALESCE(P.CntAccountSalesforceId, S.SfAccountId, '') = COALESCE(S.SfAccountId, '')
    AND COALESCE(P.CntOwnerId, S.ContactOwnerId, '') = COALESCE(S.ContactOwnerId, '')
    AND COALESCE(P.CntOwnerName, S.ContactOwnerName,'') = COALESCE(S.ContactOwnerName, '')
	AND COALESCE(P.CntAccountSivId, S.AccountSivId,'') = COALESCE(S.AccountSivId, '')
	AND COALESCE(P.CntSivId, S.ContactSivId,'') = COALESCE(S.ContactSivId, '')
    AND COALESCE(P.CntMatrixId, S.ContactMatrixId,'') = COALESCE(S.ContactMatrixId, '')
    AND COALESCE(P.CntSalutation, S.Salutation, '') = COALESCE(S.Salutation, '')
    AND COALESCE(P.CntFirstName, S.FirstName,'') = COALESCE(S.FirstName, '')
    AND COALESCE(P.CntLastName, S.LastName,'') = COALESCE(S.LastName, '')
    AND COALESCE(P.CntJobTitle, S.JobTitle,'') = COALESCE(S.JobTitle, '')
    AND COALESCE(P.CntMailingStreet, S.MailingStreet,'') = COALESCE(S.MailingStreet, '')
    AND COALESCE(P.CntMailingCity, S.MailingCity,'') = COALESCE(S.MailingCity, '')
    AND COALESCE(P.CntMailingPostcode, S.MailingPostcode,'') = COALESCE(S.MailingPostcode, '')
    AND COALESCE(P.CntMailingCountry, S.MailingCountry,'') = COALESCE(S.MailingCountry, '')
    AND COALESCE(P.CntLandline, S.Phone,'') = COALESCE(S.Phone, '')
    AND COALESCE(P.CntMobile, S.Mobile,'') = COALESCE(S.Mobile, '')
    AND COALESCE(P.CntFax, S.Fax,'') = COALESCE(S.Fax, '')
    AND COALESCE(P.CntEmail, S.EmailAddress,'') = COALESCE(S.EmailAddress, '')
	AND COALESCE(P.FCASTATUS, S.FCASTATUS,'') = COALESCE(S.FCASTATUS, '')
	AND COALESCE(P.MFIDSTATUS, S.MFIDSTATUS,'') = COALESCE(S.MFIDSTATUS, '')
	AND COALESCE(P.IsActive, S.IsActive,'') = COALESCE(S.IsActive, '')
   AND (CASE
        WHEN P.CntIsCf1 = 'true' THEN 'Y'
		WHEN P.CntIsCf1 = 'false' THEN 'N'
        ELSE S.IsCf1
    END) = S.IsCf1
    AND (CASE
        WHEN P.CntIsCf2 = 'true' THEN 'Y'
		WHEN P.CntIsCf2 = 'false' THEN 'N'
        ELSE S.IsCf2
    END) = S.IsCf2
    AND (CASE
        WHEN P.CntIsCf3 = 'true' THEN 'Y'
		WHEN P.CntIsCf3 = 'false' THEN 'N'
        ELSE S.IsCf3
    END) = S.IsCf3
    AND (CASE
        WHEN P.CntIsCf4 = 'true' THEN 'Y'
		WHEN P.CntIsCf4 = 'false' THEN 'N'
        ELSE S.IsCf4
    END) = S.IsCf4
    AND (CASE
        WHEN P.CntIsCf10 = 'true' THEN 'Y'
		WHEN P.CntIsCf10 = 'false' THEN 'N'
        ELSE S.IsCf10
    END) = S.IsCf10
    AND (CASE
        WHEN P.CntIsCf11 = 'true' THEN 'Y'
		WHEN P.CntIsCf11 = 'false' THEN 'N'
        ELSE S.IsCf11
    END) = S.IsCf11
    AND (CASE
        WHEN P.CntIsCf30 = 'true' THEN 'Y'
		WHEN P.CntIsCf30 = 'false' THEN 'N'
        ELSE S.IsCf30
    END) = S.IsCf30


	-- Update already inserted rows.
	update M
	set CntSalesforceId = s.SfContactId,
		CntAccountSalesforceId = s.SfAccountId,
		ExportStatus = 'Already inserted'
	from [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] M
	inner join [Sales.BP].[SFContactVw] S
	on M.CntAccountSivId = S.AccountSivId
	and M.CntSivId = S.ContactSivId
	WHERE exportstatus = 'WAIT'
	and (ISNULL(CntSalesforceId,'') = ''
	or ISNULL(CntAccountSalesforceId,'') = '')

	update C
	SET ExportStatus = 'INVALID EMAIL'
	FROM   [dbo].[T_MATRIX_PROCESS_SALESFORCE_CONTACT] C
	WHERE(patindex('%[' + char(127) + '-' + char(255) + ']%', cntemail COLLATE Latin1_General_BIN2) > 0)


     COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN --RollBack in case of Error

		-- Write errors to table: dbo.LogProcErrors
		EXECUTE dbo.usp_LogProcErrors

END CATCH



