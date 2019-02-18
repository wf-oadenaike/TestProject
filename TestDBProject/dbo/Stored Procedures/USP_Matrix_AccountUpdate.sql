
CREATE Proc [dbo].[USP_Matrix_AccountUpdate]
-------------------------------------------------------------------------------------- 
-- NAME:			[dbo].[USP_Matrix_AccountUpdate]
-- 
-- NOTE:			Update Matrix Account table against salesforce account data for Boomi to update into salesforce
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			16/04/2018
-------------------------------------------------------------------------------------- 
-- DESCRIPTION:		Update Matrix Account table for Boomi to update into salesforce
-- HISTORY:			
-- 16-04-2018		VIPUL KHATRI			DAP-1753      -- Update Matrix Account table for Boomi to update into salesforce
-- 01-08-2018		Rob Walker				DAP-2241      -- Prevent exceptions processes for contacts and accounts picking up the wrong owner details
-- 30-08-2018		Rob Walker				DAP-2300	  -- Tweak the export status logic

AS

BEGIN TRY

	 -- Load into temporary tables -------------------------------------------------------------------------------------------------------------------------

	--- MATRIX ACCOUNT DATA EXCLUDING DUPLICATES.  -----------------------------
	IF OBJECT_ID('TEMPDB..#MATRIX_ACCOUNT') IS NOT NULL
		 DROP TABLE #MATRIX_ACCOUNT

	CREATE TABLE #MATRIX_ACCOUNT (
		 AccSalesForceID                varchar(18)   NOT NULL,
		 AccSivID                       varchar(100)  NOT NULL,
		 AccMatrixOutletID              varchar(50)   NULL,
		 WfAccMatrixOutletId			varchar(50)   NULL,
		 AccParentSivID                 varchar(100)  NULL,
		 WfAccParentSivId				varchar(100)  NULL,
		 AccOwnerID                     varchar(18)   NULL,
		 AccOwnerName                   varchar(1000) NULL,
		 AccName                        varchar(1000) NULL,
		 AccOutletType                  varchar(100)  NULL,
		 AccBillingStreet               varchar(1000) NULL,
		 AccBillingCity                 varchar(100)  NULL,
		 AccBillingState                varchar(100)  NULL,
		 AccBillingPostcode             varchar(100)  NULL,
		 AccBillingPostcodeMapping      varchar(10)   NULL,
		 AccBillingCountry              varchar(100)  NULL,
		 AccLandline                    varchar(50)   NULL,
		 AccFax                         varchar(50)   NULL,
		 AccWebsite                     varchar(128)  NULL,
		 ACCEMAIL                       varchar(1)    NULL,
		 AccFirmSegment                 varchar(100)  NULL,
		 AccPlatformsUsed               varchar(1000) NULL,
		 AccAuthStatus                  varchar(100)  NULL,
		 PrimaryBusiness                varchar(1000) NULL,
		 AccVerifiedBy                  varchar(1000) NULL,
		 AccExistingCompanyRelationship varchar(1000) NULL,
		 AsAtDate                       datetime      NOT NULL,
		 AccountFsrFrn                  varchar(20)   NULL,
		 FCAStatus						varchar(50)	  NULL,
		 MfidStatus						varchar(100)  NULL,
		 wfMFIDStatus					varchar(100)  NULL,
		 isPriority                     varchar(10)   NULL,
		 IsLocked                       varchar(10)   NULL,
		 RecordTypeName					varchar(50)   NULL
	)

	INSERT INTO #MATRIX_ACCOUNT
	(
		AccSalesForceID,
		AccSivID,
		AccMatrixOutletID,
		AccParentSivID,
		AccOwnerID,
		AccOwnerName,
		AccName,
		AccOutletType,
		AccBillingStreet,
		AccBillingCity,
		AccBillingState,
		AccBillingPostcode,
		AccBillingPostcodeMapping,
		AccBillingCountry,
		AccLandline,
		AccFax,
		AccWebsite,
		ACCEMAIL,
		AccFirmSegment,
		AccPlatformsUsed,
		AccAuthStatus,
		PrimaryBusiness,
		AccVerifiedBy,
		AccExistingCompanyRelationship,
		AsAtDate,
		AccountFsrFrn,
		FCAStatus,
		MfidStatus,
		RecordTypeName
	)
	SELECT SfAccountId                                                 AS AccSalesForceID,
		   AccountSivId                                                AS AccSivID,
		   MatrixOutletId                                              AS AccMatrixOutletID,
		   ParentAccountSivId                                          AS AccParentSivID,
		   AccountOwnerId                                              AS AccOwnerID,
		   AccountOwnerName                                            AS AccOwnerName,
		   AccountName                                                 AS AccName,
		   OutletType                                                  AS AccOutletType,
		   REPLACE(REPLACE(BILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   BillingCity                                                 AS AccBillingCity,
		   BillingState                                                AS AccBillingState,
		   BillingPostcode                                             AS AccBillingPostcode,
		   BillingPostcodeMapping                                      AS AccBillingPostcodeMapping,
		   BillingCountry                                              AS AccBillingCountry,
		   Phone                                                       AS AccLandline,
		   Fax                                                         AS AccFax,
		   Website                                                     AS AccWebsite,
		   EmailAddress                                                AS ACCEMAIL,
		   FirmSegment                                                 AS AccFirmSegment,
		   PlatformsUsed                                               AS AccPlatformsUsed,
		   AuthStatus                                                  AS AccAuthStatus,
		   MX_PRIMARY_BUSINESS                                         AS PrimaryBusiness,
		   VerifiedBy                                                  AS AccVerifiedBy,
		   IsExistingCompanyRelationship                               AS AccExistingCompanyRelationship,
		   AsAtDate                                                    AS AsAtDate,
		   FcaId                                                       AS AccountFsrFrn,
		   FCAStatus												   AS FCAStatus,
		   MfidStatus												   AS MfidStatus,
		   RecordTypeName											   AS RecordTypeName
	FROM [Sales.BP].[MxAccountVw]

	--  Update priority and lock flag on Matrix data
	UPDATE M
	SET isPriority				= S.IsPriorityClient,
		IsLocked				= S.IsLocked,
		WfAccParentSivId		= S.ParentAccountSivId,
		WfAccMatrixOutletId		= S.MatrixOutletId,
		wfMFIDStatus			= S.AccMFIDStatus
	from #MATRIX_ACCOUNT M
	inner JOIN   [Sales.BP].[sfAccountVw] S
	ON M.AccSalesForceid = S.SfAccountId

	--- SALESFORCE ACCOUNT DATA -------------------------------------------
	IF OBJECT_ID('TEMPDB..#SF_ACCOUNT') IS NOT NULL
		 DROP TABLE #SF_ACCOUNT

	CREATE TABLE #SF_ACCOUNT (
		AccSalesForceID nvarchar(2000) NULL,
		AccSivID nvarchar(2000) NULL,
		AccMatrixOutletID nvarchar(2000) NULL,
		AccParentSivID nvarchar(2000) NULL,
		AccOwnerID nvarchar(2000) NULL,
		AccOwnerName nvarchar(2000) NULL,
		AccName nvarchar(2000) NULL,
		AccOutletType nvarchar(2000) NULL,
		AccBillingStreet nvarchar(2000) NULL,
		AccBillingCity nvarchar(2000) NULL,
		AccBillingState nvarchar(2000) NULL,
		AccBillingPostcode nvarchar(2000) NULL,
		AccBillingPostcodeMapping nvarchar(2000) NULL,
		AccBillingCountry nvarchar(2000) NULL,
		AccLandline nvarchar(2000) NULL,
		AccFax nvarchar(2000) NULL,
		AccWebsite nvarchar(2000) NULL,
		ACCEMAIL nvarchar(2000) NULL,
		AccFirmSegment nvarchar(2000) NULL,
		AccPlatformsUsed nvarchar(2000) NULL,
		AccAuthStatus nvarchar(2000) NULL,
		PrimaryBusiness varchar(MAX) NULL,
		AccVerifiedBy nvarchar(2000) NULL,
		AccExistingCompanyRelationship nvarchar(2000) NULL,
		isPriority nvarchar(2000) NULL,
		IsLocked varchar(10) NULL,
	    RecordTypeName					varchar(50)   NULL
	)

		INSERT INTO #SF_ACCOUNT
	(
		AccSalesForceID,
		AccSivID,
		AccMatrixOutletID,
		AccParentSivID,
		AccOwnerID,
		AccOwnerName,
		AccName,
		AccOutletType,
		AccBillingStreet,
		AccBillingCity,
		AccBillingState,
		AccBillingPostcode,
		AccBillingPostcodeMapping,
		AccBillingCountry,
		AccLandline,
		AccFax,
		AccWebsite,
		ACCEMAIL,
		AccFirmSegment,
		AccPlatformsUsed,
		AccAuthStatus,
		PrimaryBusiness,
		AccVerifiedBy,
		AccExistingCompanyRelationship,
		isPriority,
		IsLocked,
		RecordTypeName
	)

	SELECT SfAccountId                                                 AS AccSalesForceID,
       AccountSivId                                                AS AccSivID,
       MatrixOutletId                                              AS AccMatrixOutletID,
       ParentAccountSivId                                          AS AccParentSivID,
       AccountOwnerId                                              AS AccOwnerID,
       AccountOwnerName                                            AS AccOwnerName,
       AccountName                                                 AS AccName,
       OutletType                                                  AS AccOutletType,
       REPLACE(REPLACE(BILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
       BillingCity                                                 AS AccBillingCity,
       BillingState                                                AS AccBillingState,
       BillingPostcode                                             AS AccBillingPostcode,
	   BillingPostcodeMapping                                      AS AccBillingPostcodeMapping,
       BillingCountry                                              AS AccBillingCountry,
       Phone                                                       AS AccLandline,
       Fax                                                         AS AccFax,
       Website                                                     AS AccWebsite,
       EmailAddress                                                AS ACCEMAIL,
       FirmSegment                                                 AS AccFirmSegment,
       PlatformsUsed                                               AS AccPlatformsUsed,
       AuthStatus                                                  AS AccAuthStatus,
       WF_PRIMARY_BUSINESS                                         AS PrimaryBusiness,
       AccVerifiedBy                                               AS AccVerifiedBy,
       AccExistingCompanyRelationship                              AS AccExistingCompanyRelationship,
       IsPriorityClient                                            AS isPriority,
       IsLocked                                                    AS IsLocked,
	   RecordTypeName											   as RecordTypeName
	FROM [Sales.BP].[sfAccountVw]


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
	SET AccSalesForceID =  P.AccSalesForceID
	from T_MATRIX_PROCESS_SALESFORCE_ACCOUNT_AUDIT A
	INNER JOIN T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	ON A.AccSivId = P.AccSivId
	AND A.AsAtDate =  P.AsAtDate
	AND A.CaseID =  P.CaseID
	WHERE A.AccSalesForceID = ''
	and A.AccSalesForceID <> P.AccSalesForceID	 

    -- Load into final table -------------------------------------------------------------------------------------------------------------------------

	-- Truncate previous data
	TRUNCATE TABLE [dbo].T_MATRIX_PROCESS_SALESFORCE_ACCOUNT

	-- START TRANSACTION
	BEGIN TRANSACTION

	INSERT INTO [dbo].T_MATRIX_PROCESS_SALESFORCE_ACCOUNT
	(
				AccSivId,
				AsAtDate,
				CaseID,
				Type,
				AccFcaID,
				AccSalesForceID,
				AccMatrixOutletId,
				AccParentSivId,
				AccOwnerId,
				AccOwnerName,
				AccName,
				AccOutletType,
				AccBillingStreet,
				AccBillingCity,
				AccBillingState,
				AccBillingPostcode,
				AccBillingCountry,
				AccLandline,
				AccFax,
				AccWebsite,
				AccFirmSegment,
				AccAuthStatus,
				AccPlatformsUsed,
				AccVerifiedBy,
				AccExistingCompanyRelationship,
				AccPriorityClient,
				AccCalculatedPriority,
				AccKeyAccount,
				AccRegionCode,
				AccIsLocked,
				WFPrimaryBusiness,
				MXPrimaryBusiness,
				RecordTypeName,
				AccParentSalesforceId,
				FCAStatus,
				MfidStatus,
				IsActive
	)
	-- Case 1 - Parent = 'Yes' and child = 'Yes'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   1                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId, 
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME			                                             AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY												 AS AccBillingCity,
		   MX.ACCBILLINGSTATE												 AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE		                                     AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY			                                     AS AccBillingCountry,
		   mx.AccLandline												     AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   SF.ISPRIORITY													 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   SF.ISLOCKED														 AS AccIsLocked,
		   CASE WHEN (SF.PrimaryBusiness IS NULL OR SF.PrimaryBusiness IN ('Unclassified','Other')) THEN
				MX.PRIMARYBUSINESS
		   ELSE NULL END													 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   Case when isnull(sf.RecordTypeName,'') in ('Head Office','Outlet','')
				then MX.RecordTypeName
		   end					                                             AS RecordTypeName,
		   MXP.ACCSALESFORCEID                                               AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus, 
		   mx.MFIDStatus													 as IsActive
	FROM #MATRIX_ACCOUNT MX
	INNER JOIN #MATRIX_ACCOUNT MXP
		 ON MX.ACCPARENTSIVID = MXP.ACCSIVID
	left outer join #SF_ACCOUNT SF
		 ON MX.ACCSALESFORCEID = SF.ACCSALESFORCEID
	LEFT OUTER JOIN #POST_CODE_OWNER PO
	ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND MX.ACCSALESFORCEID != ''
	and MXP.ACCSALESFORCEID != ''

	UNION

	-- Case 2  - Parent = 'No parent', child = 'Yes'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   2                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   case when (MX.WfAccParentSivID is not null and MX.AccParentSivID is null)
		   then ' '
		   else MX.AccParentSivID end                                        AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId, 
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME														 AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY												 AS AccBillingCity,
		   MX.ACCBILLINGSTATE												 AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE											 AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY			                                     AS AccBillingCountry,
		   mx.AccLandline												     AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   MX.ISPRIORITY			                                         AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   MX.ISLOCKED														 AS AccIsLocked,
		   CASE WHEN (SF.PrimaryBusiness IS NULL OR SF.PrimaryBusiness IN ('Unclassified','Other')) THEN
				MX.PRIMARYBUSINESS
		   ELSE NULL END													 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   Case when isnull(sf.RecordTypeName,'') in ('Head Office','Outlet','')
				then MX.RecordTypeName
		   end																 AS RecordTypeName,	
		   case when (MX.WfAccParentSivID is not null and MX.AccParentSivID is null)
		   then ' '
		   else NULL end   													 AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus,
		   mx.MFIDStatus													 AS IsActive
	FROM #MATRIX_ACCOUNT MX
	LEFT OUTER JOIN #SF_ACCOUNT SF
		 ON MX.ACCSALESFORCEID = SF.ACCSALESFORCEID
	LEFT OUTER JOIN #POST_CODE_OWNER PO
	ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	WHERE MX.ACCPARENTSIVID IS NULL
	AND	  MX.ACCSALESFORCEID != ''

	UNION

	-- CASE 3 - Parent = 'Yes', child = 'No'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   3                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId, 
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY		                                         AS AccBillingCity,
		   MX.ACCBILLINGSTATE												 AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE		                                     AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY												 AS AccBillingCountry,
		   mx.AccLandline													 AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   'false'															 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   'false'															 AS AccIsLocked,
		   MX.PRIMARYBUSINESS												 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   MX.RecordTypeName                                                 AS RecordTypeName,
		   MXP.ACCSALESFORCEID				                                 AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus,
		   mx.MFIDStatus													 as IsActive
	FROM #MATRIX_ACCOUNT MX
	INNER JOIN #MATRIX_ACCOUNT MXP
		 ON MX.ACCPARENTSIVID = MXP.ACCSIVID
	LEFT OUTER JOIN #POST_CODE_OWNER PO
	ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND MX.ACCSALESFORCEID = ''
	and MXP.ACCSALESFORCEID != ''

	UNION

	-- Case 4 - Parent = 'No Parent', child = 'No'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   4                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId,
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   'false'			                                                 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   'false'															 AS AccIsLocked,
		   MX.PRIMARYBUSINESS											     AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   MX.RecordTypeName                                                 AS RecordTypeName,
		   NULL																 AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus,
		   MX.MFIDStatus													 AS IsActive
	FROM #MATRIX_ACCOUNT MX
	LEFT OUTER JOIN #POST_CODE_OWNER PO
	ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	WHERE MX.ACCPARENTSIVID IS NULL
	AND   MX.ACCSALESFORCEID = ''

	UNION

	-- Case 5 - Parent = 'No', child = 'No'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   5                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId,
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   'false'															 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   'false'															 AS AccIsLocked,
		   MX.PRIMARYBUSINESS												 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   MX.RecordTypeName                                                 AS RecordTypeName,
		   NULL																 AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus,
		   MX.MFIDStatus													 AS IsActive
	FROM #MATRIX_ACCOUNT MX
	LEFT OUTER JOIN #MATRIX_ACCOUNT  MX2   -- Using main table to avoid rows being eliminated via a left join
		ON mx.ACCPARENTSIVID = MX2.ACCSIVID
	LEFT OUTER JOIN #POST_CODE_OWNER PO
		ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND   MX.ACCSALESFORCEID  = ''
	AND   MX2.ACCSALESFORCEID = ''

	union

	-- Case 6 - Parent = 'No', child = 'Yes'
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   6                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   case when (MX.WfAccMatrixOutletId is not null and MX.AccMatrixOutletID is null)
		   then ' '
		   else MX.ACCMATRIXOUTLETID end                                     AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   PO.ownerId														 AS AccOwnerId,
		   PO.OWNERNAME														 AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   MX.ACCBILLINGSTREET												 AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   MX.ISPRIORITY													 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   MX.ISLOCKED													     AS AccIsLocked,
		   CASE WHEN (SF.PrimaryBusiness IS NULL OR SF.PrimaryBusiness IN ('Unclassified','Other')) THEN
				MX.PRIMARYBUSINESS
		   ELSE NULL END													 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   Case when isnull(sf.RecordTypeName,'') in ('Head Office','Outlet','')
				then MX.RecordTypeName
		   end																 AS RecordTypeName,	
		   NULL																 AS AccParentSalesforceId,
		   MX.FCAStatus,
		   case when (MX.WfMfidStatus is not null and MX.MfidStatus is null)
		   then ' '
		   else MX.MfidStatus end											 as MfidStatus,
		   MX.MFIDStatus													 AS IsActive
	FROM #MATRIX_ACCOUNT MX
	LEFT OUTER JOIN #MATRIX_ACCOUNT  MX2   -- Using main table to avoid rows being eliminated via a left join
		ON mx.ACCPARENTSIVID = MX2.ACCSIVID
	LEFT OUTER JOIN #POST_CODE_OWNER PO
		ON MX.ACCBILLINGPOSTCODEMAPPING = PO.POST_CODE
	LEFT OUTER JOIN #SF_ACCOUNT SF
		ON MX.ACCSALESFORCEID = SF.ACCSALESFORCEID
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND   MX.ACCSALESFORCEID  != ''
	AND   MX2.ACCSALESFORCEID = ''

	UPDATE P
	SET AccOwnerId		= o.AccountOwnerId,
        AccOwnerName	= c.PersonsName
	FROM T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	INNER JOIN T_SALESFORCE_POSTCODE_OVERRIDE O
	ON P.AccSalesForceID = O.SfAccountId  
	INNER JOIN Core.Persons c
	ON O.AccountOwnerId = C.FullEmployeeBK
	WHERE o.overridestatus = 'Exported'

	-- Update ownerId and OwnerName when it is not specified.
	-- This will be changed in future to grab default owner from SF. Current logic is to default owner to Sophie.	
	UPDATE P
	SET AccOwnerId		= (SELECT FullEmployeeBK FROM [Core].[Persons] where personsName = 'Sophie Maton'),
        AccOwnerName	= (SELECT personsName FROM [Core].[Persons] where personsName = 'Sophie Maton')
	FROM T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	WHERE AccOwnerId IS NULL
	AND (P.AccPriorityClient = 'FALSE' AND P.ACCISLOCKED = 'FALSE')

	-- DAP-2241 Call the Matrix Exception proc here before Nulling columns out
	EXEC [Sales.BP].[usp_GenerateSalesforceMatrixAccountExceptions]

	-- Update priority client and islocked dependent fields
	UPDATE P
	SET AccOwnerId = NULL,
		AccOwnerName = NULL,
		AccName = 		NULL,
		ACCBILLINGSTREET = CASE WHEN IsBillingAddressNull = 1
						THEN p.ACCBILLINGSTREET
					ELSE  NULL END,
		ACCBILLINGCITY = CASE WHEN IsBillingAddressNull = 1
						THEN p.ACCBILLINGCITY
					ELSE  NULL END,
		ACCBILLINGSTATE = NULL,
		ACCBILLINGPOSTCODE = CASE WHEN IsBillingAddressNull = 1
						THEN p.ACCBILLINGPOSTCODE
					ELSE  NULL END,
		ACCBILLINGCOUNTRY = CASE WHEN IsBillingAddressNull = 1
						THEN p.ACCBILLINGCOUNTRY
					ELSE  NULL END,
		AccLandline = CASE WHEN SF.Phone IS NULL 
					THEN  p.AccLandline
					ELSE NULL END,
		IsActive = CASE WHEN SF.AccIsActive is not null then NULL
						when p.isactive = 'Inactive' then NULL
						else p.isactive
					 end
	FROM T_MATRIX_PROCESS_SALESFORCE_ACCOUNT p
	LEFT OUTER JOIN [Sales.BP].[SfAccountVw] SF
	ON P.AccSalesForceID = SF.SfAccountId
	WHERE AccSalesForceID != ''
	and (P.AccPriorityClient = 'TRUE' OR P.ACCISLOCKED = 'TRUE')

	-- Update any address fields to space when part of it is null
	update A
	set accbillingstreet	= COALESCE(accbillingstreet,' '),
		accbillingcity		= COALESCE(accbillingcity,' '),
		accbillingpostcode	= COALESCE(accbillingpostcode,' '),
		accbillingcountry	= COALESCE(accbillingcountry,' ') 
	FROM T_MATRIX_PROCESS_SALESFORCE_ACCOUNT A
	WHERE exportstatus = 'WAIT'
	and (accbillingstreet is not null
	or accbillingcity is not null
	or accbillingpostcode is not null
	or accbillingcountry is not null)
	AND (accbillingstreet IS NULL OR accbillingcity IS NULL OR accbillingcountry IS NULL OR accbillingpostcode IS NULL)

	Update mx 
	set		accparentsivid = ' ',
			accparentsalesforceid = ' ' 
	from [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT] mx 
	left join [Sales.BP].[SfAccountVw] me 
	on me.SfAccountId =mx.accparentsalesforceid
	where me.SfAccountId is null
	and coalesce(mx.accparentsivid,'')<>''
	and coalesce(mx.accparentsalesforceid,'')<>''

	-- Any Exclusions. Update exportStatus to reason why it doesn't need to be processed by Boomi.

	-- Identical AccPriorityClient = 'TRUE' or ACCISLOCKED = 'TRUE'
	UPDATE E
	SET EXPORTSTATUS = 'IDENTICAL'
	FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT] E
	INNER JOIN [Sales.BP].[SfAccountVw] S
		 ON E.AccSalesForceID = S.SfAccountId
	WHERE E.EXPORTSTATUS = 'WAIT'
	AND (E.AccPriorityClient = 'TRUE' OR E.ACCISLOCKED = 'TRUE')
	AND COALESCE(E.AccFcaid, S.Fcaid,'') = COALESCE(S.Fcaid, '')
	AND COALESCE(E.AccSalesforceId, S.SfAccountId,'') = COALESCE(S.SfAccountId, '')
	AND COALESCE(E.ACCMATRIXOUTLETID, S.MatrixOutletId,'') = COALESCE(S.MatrixOutletId,'')
	AND COALESCE(e.AccName,S.AccountName,'') = COALESCE(S.AccountName, '')
	AND COALESCE(E.AccParentSalesforceId, S.SfParentAccountId,'') = COALESCE(S.SfParentAccountId, '')
	AND COALESCE(E.AccSivId, S.AccountSivId,'') = COALESCE(S.AccountSivId, '')
	AND COALESCE(E.AccParentSivID, S.ParentAccountSivId,'') = COALESCE(S.ParentAccountSivId, '')
	AND COALESCE(E.AccOutletType, S.OutletType,'') = COALESCE(S.OutletType, '')
	AND COALESCE(E.AccFax, S.Fax,'') = COALESCE(S.Fax, '')
	AND COALESCE(E.AccWebsite, S.Website,'') = COALESCE(S.Website, '')
	AND COALESCE(E.AccEmail, S.EmailAddress,'') = COALESCE(S.EmailAddress, '')
	AND COALESCE(E.AccFirmSegment, S.FirmSegment,'') = COALESCE(S.FirmSegment, '')
	AND COALESCE(E.AccAuthStatus, S.AuthStatus,'') = COALESCE(S.AuthStatus, '')
	AND COALESCE(E.AccPlatformsUsed, S.PlatformsUsed,'') = COALESCE(S.PlatformsUsed, '')
	AND COALESCE(E.RecordTypeName, S.RecordTypeName,'') = COALESCE(S.RecordTypeName, '')
	AND	CASE
			WHEN COALESCE(S.AccVerifiedBy, E.AccVerifiedBy,'') = '' THEN 'MATRIX VERIFIED'
			ELSE COALESCE(S.AccVerifiedBy, E.AccVerifiedBy,'')
	   END = COALESCE(E.AccVerifiedBy, '')
	AND COALESCE(E.AccExistingCompanyRelationship, S.AccExistingCompanyRelationship,'') = COALESCE(S.AccExistingCompanyRelationship, '')
	AND CASE
			WHEN COALESCE(E.AccPriorityClient, S.IsPriorityClient,'') = '' THEN COALESCE(S.IsPriorityClient, '')
			ELSE COALESCE(E.AccPriorityClient, S.IsPriorityClient,'')
	    END = COALESCE(S.IsPriorityClient, '')
	AND CASE
			WHEN COALESCE(E.AccCalculatedPriority, S.CalculatedPriority,'') = '' THEN COALESCE(S.CalculatedPriority, '')
			ELSE COALESCE(E.AccCalculatedPriority, S.CalculatedPriority,'')
	   END = COALESCE(S.CalculatedPriority, '')
	AND CASE
			WHEN COALESCE(E.AccKeyAccount, S.IsKeyAccount,'') = '' THEN COALESCE(S.IsKeyAccount, '')
			ELSE COALESCE(E.AccKeyAccount, S.IsKeyAccount,'')
	   END = COALESCE(S.IsKeyAccount, '')
	AND CASE
			WHEN COALESCE(E.AccRegionCode, S.RegionId,'') = '' THEN COALESCE(S.RegionId, '')
			ELSE COALESCE(E.AccRegionCode, S.RegionId,'')
	   END = COALESCE(S.RegionId, '')
	AND CASE
			WHEN COALESCE(E.WFPRIMARYBUSINESS, S.WF_PRIMARY_BUSINESS,'') = '' THEN COALESCE(S.WF_PRIMARY_BUSINESS, '')
			ELSE COALESCE(E.WFPRIMARYBUSINESS, S.WF_PRIMARY_BUSINESS,'')
	   END = COALESCE(S.WF_PRIMARY_BUSINESS, '')
	AND  COALESCE(E.MXPRIMARYBUSINESS, S.MX_PRIMARY_BUSINESS,'') = COALESCE(S.MX_PRIMARY_BUSINESS, '')
	AND  COALESCE(E.FCAStatus, S.AccFCAStatus,'') = COALESCE(S.AccFCAStatus, '') 
	AND  COALESCE(E.MFIDStatus, S.AccMfidStatus,'') = COALESCE(S.AccMfidStatus, '')
	AND  COALESCE(E.IsActive, S.AccIsActive,'') = COALESCE(S.AccIsActive, '')

	-- Identical AccPriorityClient = 'FALSE' and ACCISLOCKED = 'FALSE'
	UPDATE E
	SET EXPORTSTATUS = 'IDENTICAL'
	FROM [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT] E
	INNER JOIN [Sales.BP].[SfAccountVw] S
		 ON E.AccSalesForceID = S.SfAccountId
	WHERE E.EXPORTSTATUS = 'WAIT'
	and (E.AccPriorityClient = 'FALSE' AND E.ACCISLOCKED = 'FALSE')
	AND COALESCE(E.AccFcaid, S.Fcaid,'') = COALESCE(S.Fcaid, '')
	AND COALESCE(E.AccSalesforceId, S.SfAccountId,'') = COALESCE(S.SfAccountId, '')
	AND COALESCE(E.ACCMATRIXOUTLETID, S.MatrixOutletId,'') = COALESCE(S.MatrixOutletId,'')
	AND COALESCE(e.AccName,S.AccountName,'') = COALESCE(S.AccountName, '')
	AND COALESCE(E.AccParentSalesforceId, S.SfParentAccountId,'') = COALESCE(S.SfParentAccountId, '')
	AND COALESCE(E.AccSivId, S.AccountSivId,'') = COALESCE(S.AccountSivId, '')
	AND COALESCE(E.AccParentSivID, S.ParentAccountSivId,'') = COALESCE(S.ParentAccountSivId, '')
	AND COALESCE(E.AccOwnerID, S.AccountOwnerId,'') = COALESCE(S.AccountOwnerId, '')
	AND COALESCE(E.AccOutletType, S.OutletType,'') = COALESCE(S.OutletType, '')
	AND COALESCE(E.AccBillingStreet, S.BillingStreet,'') = COALESCE(S.BillingStreet, '')
	AND COALESCE(E.AccBillingCity, S.BillingCity,'') = COALESCE(S.BillingCity, '')
	AND COALESCE(E.AccBillingPostCode, S.BillingPostCode,'') = COALESCE(S.BillingPostCode, '')
	AND COALESCE(E.AccBillingCountry, S.BillingCountry,'') = COALESCE(S.BillingCountry, '')
	AND COALESCE(E.AccLandLine, S.Phone,'') = COALESCE(S.Phone, '')
	AND COALESCE(E.AccFax, S.Fax,'') = COALESCE(S.Fax, '')
	AND COALESCE(E.AccWebsite, S.Website,'') = COALESCE(S.Website, '')
	AND COALESCE(E.AccEmail, S.EmailAddress,'') = COALESCE(S.EmailAddress, '')
	AND COALESCE(E.AccFirmSegment, S.FirmSegment,'') = COALESCE(S.FirmSegment, '')
	AND COALESCE(E.AccAuthStatus, S.AuthStatus,'') = COALESCE(S.AuthStatus, '')
	AND COALESCE(E.AccPlatformsUsed, S.PlatformsUsed,'') = COALESCE(S.PlatformsUsed, '')
	AND COALESCE(E.RecordTypeName, S.RecordTypeName,'') = COALESCE(S.RecordTypeName, '')
	AND
	   CASE
			WHEN COALESCE(S.AccVerifiedBy, E.AccVerifiedBy,'') = '' THEN 'MATRIX VERIFIED'
			ELSE COALESCE(S.AccVerifiedBy, E.AccVerifiedBy,'')
	   END = COALESCE(E.AccVerifiedBy, '')
	AND COALESCE(E.AccExistingCompanyRelationship, S.AccExistingCompanyRelationship,'') = COALESCE(S.AccExistingCompanyRelationship, '')
	AND
	   CASE
			WHEN COALESCE(E.AccPriorityClient, S.IsPriorityClient,'') = '' THEN COALESCE(S.IsPriorityClient, '')
			ELSE COALESCE(E.AccPriorityClient, S.IsPriorityClient,'')
	   END = COALESCE(S.IsPriorityClient, '')
	AND
	   CASE
			WHEN COALESCE(E.AccCalculatedPriority, S.CalculatedPriority,'') = '' THEN COALESCE(S.CalculatedPriority, '')
			ELSE COALESCE(E.AccCalculatedPriority, S.CalculatedPriority,'')
	   END = COALESCE(S.CalculatedPriority, '')
	AND
	   CASE
			WHEN COALESCE(E.AccKeyAccount, S.IsKeyAccount,'') = '' THEN COALESCE(S.IsKeyAccount, '')
			ELSE COALESCE(E.AccKeyAccount, S.IsKeyAccount,'')
	   END = COALESCE(S.IsKeyAccount, '')
	AND
	   CASE
			WHEN COALESCE(E.AccRegionCode, S.RegionId,'') = '' THEN COALESCE(S.RegionId, '')
			ELSE COALESCE(E.AccRegionCode, S.RegionId,'')
	   END = COALESCE(S.RegionId, '')
	AND
	   CASE
			WHEN COALESCE(E.WFPRIMARYBUSINESS, S.WF_PRIMARY_BUSINESS,'') = '' THEN COALESCE(S.WF_PRIMARY_BUSINESS, '')
			ELSE COALESCE(E.WFPRIMARYBUSINESS, S.WF_PRIMARY_BUSINESS,'')
	   END = COALESCE(S.WF_PRIMARY_BUSINESS, '')
	AND  COALESCE(E.MXPRIMARYBUSINESS, S.MX_PRIMARY_BUSINESS,'') = COALESCE(S.MX_PRIMARY_BUSINESS, '')
	AND  COALESCE(E.FCAStatus, S.AccFCAStatus,'') = COALESCE(S.AccFCAStatus, '') 
	AND  COALESCE(E.MFIDStatus, S.AccMfidStatus,'') = COALESCE(S.AccMfidStatus, '')
    AND  COALESCE(E.IsActive, S.AccIsActive,'') = COALESCE(S.AccIsActive, '')

	-- Entries not in salesforce
	UPDATE P
	SET EXPORTSTATUS = 'NOT IN SALESFORCE'
	from  T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	where exportstatus = 'WAIT'
	and (accPriorityClient is null or AccIsLocked is null)

	-- Circular references
	UPDATE P
	SET EXPORTSTATUS = 'CIRCULAR'
	FROM [DBO].T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	INNER JOIN [Sales.BP].[SfAccountVw] D
	ON P.AccParentSalesforceId = D.SfAccountId
	AND d.SfParentAccountId = P.AccSalesForceID
	and P.EXPORTSTATUS = 'WAIT'

	-- UPDATE PARENTS FOR CIRCULAR REFERENCE.
	UPDATE P
	SET EXPORTSTATUS = 'CIRCULAR'
	FROM [DBO].T_MATRIX_PROCESS_SALESFORCE_ACCOUNT C 
	INNER JOIN [DBO].T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	ON P.AccSalesForceID = C.ACCPARENTSALESFORCEID
	and p.EXPORTSTATUS = 'WAIT'
	AND C.EXPORTSTATUS = 'CIRCULAR'

	UPDATE P
	SET EXPORTSTATUS = 'DUPLICATE ACCOUNT'
	from T_MATRIX_PROCESS_SALESFORCE_ACCOUNT P
	WHERE AccSalesForceID IN (
		 SELECT DISTINCT SALESFORCE_ACCOUNT_ID
		 FROM [dbo].T_MATRIX_DUPLICATEACCOUNT
	)
	and P.EXPORTSTATUS IN ('WAIT','IDENTICAL','CIRCULAR')

	-- When reprocessing without getting a new file, we need to update SF ID which have already been sent to SF
	update M
	set AccSalesForceID = s.SfAccountId,
		ExportStatus = 'Already inserted'
	from [dbo].[T_MATRIX_PROCESS_SALESFORCE_ACCOUNT] M
	inner join [Sales.BP].[SfAccountVw] S
	on M.AccSivId = S.AccountSivId
	WHERE exportstatus = 'WAIT'
	AND ISNULL(AccSalesForceID,'') = ''

	COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN --RollBack in case of Error

		-- Write errors to table: dbo.LogProcErrors
		EXECUTE dbo.usp_LogProcErrors

END CATCH



