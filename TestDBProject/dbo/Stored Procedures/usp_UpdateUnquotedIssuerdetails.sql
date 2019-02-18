

CREATE PROCEDURE [dbo].[usp_UpdateUnquotedIssuerdetails] AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_UpdateUnquotedIsuserdetails]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
--Olu: 22/10/2018 JIRA: DAP-2262 
--[Insert Unquoted Data |Update t_master_issuer with Right PrimaryAnalyst, SecondaryAnalyst IDs, JIRAEpicKeys and SalesForceAcctIDs|Clean Data where fields have #N/A]
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_UpdateUnquotedIssuerdetails]';

BEGIN TRANSACTION




--Arix
Update T_MASTER_ISSUER
SET CompanyType = 'Plc',
	Salesforce_Account_Id = '0012000001WTkWJ',
	BoxFolderID = '6000305529',
	JiraEpicKey = 'INVBAU-676',
	PrimaryAnalystPersonID = 51,
	SecondaryAnalystPersonID= 48,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000009


--Autolus
Update T_MASTER_ISSUER
SET CompanyType = 'Ltd',
	Salesforce_Account_Id = '0012000001RNF24',
	BoxFolderID = '4102524607',
	JiraEpicKey = 'INVBAU-755',
	PrimaryAnalystPersonID = 51,
	SecondaryAnalystPersonID= 48,
	Currency = 'USD'
where EDM_Issuer_ID = 600000012



--Eve
Update T_MASTER_ISSUER
SET CompanyType = 'Plc',
	Salesforce_Account_Id = '0012000001bCTF8',
	BoxFolderID = '8378731289',
	JiraEpicKey = 'INVBAU-1296',
	PrimaryAnalystPersonID = 42,
	SecondaryAnalystPersonID= 11,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000053




--Evofem
Update T_MASTER_ISSUER
SET CompanyType = 'Plc',
	Salesforce_Account_Id = '0012000001CIW8Q',
	BoxFolderID = '2604531001',
	JiraEpicKey = 'INVBAU-30',
	PrimaryAnalystPersonID = 51,
	SecondaryAnalystPersonID= 48,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000054



--Mereo 
Update T_MASTER_ISSUER
SET CompanyType = 'Plc',
	Salesforce_Account_Id = '0012000001NuiPr',
	BoxFolderID = '3897904573',
	JiraEpicKey = 'INVBAU-35',
	PrimaryAnalystPersonID = 51,
	SecondaryAnalystPersonID= 48,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000096




--PurpleBricks 
Update T_MASTER_ISSUER
SET CompanyType = 'Plc',
	Salesforce_Account_Id = '0012000001CIW9F',
	BoxFolderID = '2604545677',
	JiraEpicKey = 'INVBAU-905',
	PrimaryAnalystPersonID = 42,
	SecondaryAnalystPersonID = 11,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000119



--IH 
Update T_MASTER_ISSUER
SET CompanyType = 'Ltd',
	Salesforce_Account_Id = '0012000001CIW8j',
	BoxFolderID = '2604542297',
	JiraEpicKey = 'INVBAU-868',
	PrimaryAnalystPersonID = 42,
	SecondaryAnalystPersonID = 11,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000073


--Sphere
Update T_MASTER_ISSUER
SET CompanyType = 'Ltd',
	Salesforce_Account_Id = '00120000013Wzsd',
	BoxFolderID = '2604548417',
	JiraEpicKey = 'INVBAU-70',
	PrimaryAnalystPersonID = 51,
	SecondaryAnalystPersonID = 48,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000140




--Ombu 
Update T_MASTER_ISSUER
SET CompanyType = 'Ltd',
	Salesforce_Account_Id = '0012000001CIW95',
	BoxFolderID = '2906888579',
	JiraEpicKey = 'INVBAU-20',
	PrimaryAnalystPersonID = 42,
	SecondaryAnalystPersonID = 11,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000110


--Sabina 
Update T_MASTER_ISSUER
SET CompanyType = 'Ltd',
	Salesforce_Account_Id = '0012000001U3KdX',
	BoxFolderID = '5473615925',
	JiraEpicKey = 'INVBAU-682',
	PrimaryAnalystPersonID = 42,
	SecondaryAnalystPersonID = 11,
	Currency = 'GBP'
where EDM_Issuer_ID = 600000132


-- Abaco
Update T_MASTER_ISSUER	
SET	PrimaryAnalystPersonID =  1,
	SecondaryAnalystPersonID =  1
WHERE EDM_Issuer_ID = 600000003

--Clean Data where fields have #N/A 

UPDATE T_MASTER_ISSUER
SET Country_Of_Risk = NULL
WHERE Country_Of_Risk = '#N/A Field Not Applicable'

UPDATE T_MASTER_ISSUER
SET Ticker_exchange = NULL
WHERE Ticker_exchange = '#N/A N/A'

UPDATE T_MASTER_ISSUER
SET LEI = NULL
WHERE LEI = '#N/A N/A'


--Update t_master_issuer with Right PrimaryAnalyst, SecondaryAnalyst IDs, JIRAEpicKeys and SalesForceAcctIDs 
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW8N', JiraEpicKey =  'INVBAU-2457' where Issuer_Name = '4d pharma plc'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW7x', JiraEpicKey =  '' where Issuer_Name = 'AA PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '', JiraEpicKey =  'INVBAU-658' where Issuer_Name = 'Abaco Capital PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001XQwMC', JiraEpicKey =  'INVBAU-658' where Issuer_Name = 'ABLS Capital'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiOm', JiraEpicKey =  'INVBAU-2459' where Issuer_Name = 'Abzena PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001VKoXM', JiraEpicKey =  'INVBAU-659' where Issuer_Name = 'Accelerated Digital Ventures '
Update t_master_issuer set  primaryAnalystPersonID = NULL ,  SecondaryAnalystPersonID =  NULL,  Salesforce_Account_Id  =  '0012000001CIW7p', JiraEpicKey =  'INVBAU-907' where Issuer_Name = 'AJ Bell Holdings'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0010O00001sLQTt', JiraEpicKey =  '' where Issuer_Name = 'Agios Pharmaceuticals Inc'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001CIW7q', JiraEpicKey =  'INVBAU-2460' where Issuer_Name = 'Alkermes PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013Xwyt', JiraEpicKey =  'INVBAU-959' where Issuer_Name = 'Allied Minds PLC'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013Xy8X', JiraEpicKey =  'INVBAU-683' where Issuer_Name = 'American Financial Exchange'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001uIUTd', JiraEpicKey =  '' where Issuer_Name = 'Amigo Holdings PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001WTkQ6', JiraEpicKey =  'INVBAU-783' where Issuer_Name = 'AMO Pharma'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001WTkWJ', JiraEpicKey =  'INVBAU-676' where Issuer_Name = 'Arix Bioscience Plc'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001QquNr', JiraEpicKey =  'INVBAU-633' where Issuer_Name = 'Atom Bank'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001RNF24', JiraEpicKey =  'INVBAU-755' where Issuer_Name = 'Autolus Therapeutics PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001SHKze', JiraEpicKey =  '' where Issuer_Name like 'Babcock%'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001md0HX', JiraEpicKey =  '' where Issuer_Name = 'Bakkavor Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O000021PJR6', JiraEpicKey =  '' where Issuer_Name like 'Barclays%'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001lpoox', JiraEpicKey =  '' where Issuer_Name = 'Barratt Developments PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001NuiOu', JiraEpicKey =  '' where Issuer_Name = 'BCA Marketplace PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001lqjwa', JiraEpicKey =  '' where Issuer_Name = 'Bellway PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001CIW81', JiraEpicKey =  'INVBAU-4259' where Issuer_Name = 'Benchmark Holdings Plc'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW9e', JiraEpicKey =  'INVBAU-18' where Issuer_Name = 'BenevolentAI'
Update t_master_issuer set  primaryAnalystPersonID = NULL ,  SecondaryAnalystPersonID =  NULL,  Salesforce_Account_Id  =  '00120000013Wzco', JiraEpicKey =  'INVBAU-31' where Issuer_Name = 'Biofem'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001fLNYR', JiraEpicKey =  'INVBAU-2462' where Issuer_Name = 'Biogen Inc'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0010O00001o0HPC', JiraEpicKey =  'INVBAU-3384' where Issuer_Name = 'Bodle Technologies'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001i2VxQ', JiraEpicKey =  '' where Issuer_Name = 'Bovis Homes Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013WzuZ', JiraEpicKey =  'INVBAU-73' where Issuer_Name like 'Brandon%'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001Hrunl', JiraEpicKey =  'INVBAU-1048' where Issuer_Name = 'Brave Bison Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001mczjt', JiraEpicKey =  'INVBAU-3013' where Issuer_Name = 'Breedon Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001CIW83', JiraEpicKey =  '' where Issuer_Name = 'British American Tobacco PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lqjpA', JiraEpicKey =  '' where Issuer_Name = 'British Land Co PLC/The'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW85', JiraEpicKey =  '' where Issuer_Name = 'BTG PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001QLDhy', JiraEpicKey =  'INVBAU-4260' where Issuer_Name = 'Burford Capital Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiP2', JiraEpicKey =  'INVBAU-1370' where Issuer_Name = 'Cambridge Innovation Capital'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001CIW88', JiraEpicKey =  '' where Issuer_Name = 'Capita PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001lrYzF', JiraEpicKey =  '' where Issuer_Name = 'Card Factory PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013YUgq', JiraEpicKey =  'INVBAU-1203' where Issuer_Name = 'Carrick Therapeutics'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW8A', JiraEpicKey =  'INVBAU-866' where Issuer_Name = 'Cell Medica'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiP6', JiraEpicKey =  'INVBAU-25' where Issuer_Name = 'CeQur'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013Wzfn', JiraEpicKey =  'INVBAU-29' where Issuer_Name = 'Circassia Pharmaceuticals Plc'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '00120000013XLPf', JiraEpicKey =  'INVBAU-789' where Issuer_Name = 'Countryside Properties PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001lrKvk', JiraEpicKey =  '' where Issuer_Name = 'Crest Nicholson Holdings plc'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001NuiPH', JiraEpicKey =  'INVBAU-717' where Issuer_Name like 'Crystal%'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001bAONS', JiraEpicKey =  'INVBAU-789' where Issuer_Name = 'DDF Parallel'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001NuiPH', JiraEpicKey =  'INVBAU-717' where Issuer_Name = 'Drayson Technologies'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013X0ls', JiraEpicKey =  'INVBAU-961' where Issuer_Name = 'Econic Technologies'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001p1vPm', JiraEpicKey =  '' where Issuer_Name = 'Eddie Stobart Logistics PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001mczn2', JiraEpicKey =  '' where Issuer_Name = 'Equiniti Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiPM', JiraEpicKey =  'INVBAU-2463' where Issuer_Name = 'e-Therapeutics PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lpgPF', JiraEpicKey =  '' where Issuer_Name = 'Eurocell PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001iN75I', JiraEpicKey =  '' where Issuer_Name = 'Euromoney Institutional Invest'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001bCTF8', JiraEpicKey =  'INVBAU-1296' where Issuer_Name = 'Eve Sleep PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW8Q', JiraEpicKey =  'INVBAU-30' where Issuer_Name = 'Evofem Biosciences Inc'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013Xwsg', JiraEpicKey =  'INVBAU-661' where Issuer_Name = 'Federated Wireless'
Update t_master_issuer set  primaryAnalystPersonID = NULL ,  SecondaryAnalystPersonID =  NULL,  Salesforce_Account_Id  =  '0012000001eiFtU', JiraEpicKey =  'INVBAU-1717' where Issuer_Name = 'Fibre 7 UK '
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lqIe4', JiraEpicKey =  '' where Issuer_Name = 'Forterra PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001CIW8U', JiraEpicKey =  '' where Issuer_Name = 'G4S PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiPR', JiraEpicKey =  'INVBAU-988' where Issuer_Name = 'Genomics'
Update t_master_issuer set  primaryAnalystPersonID = NULL ,  SecondaryAnalystPersonID =  NULL,  Salesforce_Account_Id  =  '0012000001CIW8X', JiraEpicKey =  'INVBAU-630' where Issuer_Name = 'Gigaclear'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '', JiraEpicKey =  '' where Issuer_Name = 'GYG PLC'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013Y2wF', JiraEpicKey =  'INVBAU-1426' where Issuer_Name = 'HaloSource Corp'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001iXtZ5', JiraEpicKey =  'INVBAU-1841' where Issuer_Name = 'HawkEye 360'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW8d', JiraEpicKey =  '' where Issuer_Name = 'HomeServe PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0010O00001p33Ji', JiraEpicKey =  'INVBAU-2972' where Issuer_Name = 'Honeycomb Investment Trust PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001CIW8e', JiraEpicKey =  'INVBAU-2465' where Issuer_Name = 'Horizon Discovery Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001bLwei', JiraEpicKey =  '' where Issuer_Name like 'Hostel%'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '00120000013XZIH', JiraEpicKey =  'INVBAU-2466' where Issuer_Name = 'Hvivo PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001RMN6G', JiraEpicKey =  '' where Issuer_Name = 'IDEX ASA'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001CIW8j', JiraEpicKey =  'INVBAU-868' where Issuer_Name  like 'International%'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiPd', JiraEpicKey =  'INVBAU-34' where Issuer_Name = 'Immunocore'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '00120000013XuX8', JiraEpicKey =  '' where Issuer_Name = 'Imperial Brands PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013XiUy', JiraEpicKey =  'INVBAU-667' where Issuer_Name = 'Inivata'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '', JiraEpicKey =  '' where Issuer_Name = 'Instone'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '', JiraEpicKey =  '' where Issuer_Name = 'International Consolidated Airlines Group'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013XwZ5', JiraEpicKey =  'INVBAU-957' where Issuer_Name = 'IP Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001CIW9M', JiraEpicKey =  'INVBAU-4262' where Issuer_Name = 'Itaconix PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001uIF8S', JiraEpicKey =  '' where Issuer_Name = 'ITV PLC'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001CIW8m', JiraEpicKey =  '' where Issuer_Name = 'ITWP Acquisitions Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001qWYY1', JiraEpicKey =  '' where Issuer_Name = 'Kier Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001NuiPi', JiraEpicKey =  'INVBAU-906' where Issuer_Name = 'Kind Consumer Holdings'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001o0HcV', JiraEpicKey =  '' where Issuer_Name = 'Kingfisher PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001HrunY', JiraEpicKey =  'INVBAU-869' where Issuer_Name = 'Kymab Group'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '00120000013XtjR', JiraEpicKey =  '' where Issuer_Name = 'Legal & General Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001eiFtU', JiraEpicKey =  '' where Issuer_Name like 'Lignia%'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0010O00001tTml1', JiraEpicKey =  'INVBAU-4982' where Issuer_Name = 'Literacy Capital'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '00120000013Y6iO', JiraEpicKey =  '' where Issuer_Name = 'Lloyds Banking Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW8v', JiraEpicKey =  'INVBAU-657' where Issuer_Name = 'Mafic'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '00120000013XZIR', JiraEpicKey =  'INVBAU-1064' where Issuer_Name = 'Malin Corp PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013XxHq', JiraEpicKey =  'INVBAU-33' where Issuer_Name = 'Malin J1 - Viamet'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013Xy2Y', JiraEpicKey =  'INVBAU-4264' where Issuer_Name = 'Mercia Technologies PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiPr', JiraEpicKey =  'INVBAU-35' where Issuer_Name = 'Mereo Biopharma Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0010O00001p1hb1', JiraEpicKey =  'INVBAU-3420' where Issuer_Name = 'Metaboards'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001QJMGm', JiraEpicKey =  'INVBAU-687' where Issuer_Name = 'Metalysis'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '00120000013XZIV', JiraEpicKey =  'INVBAU-516' where Issuer_Name = 'Micro Focus International PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW8y', JiraEpicKey =  'INVBAU-1633' where Issuer_Name = 'Midatech Pharma PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013XufH', JiraEpicKey =  'INVBAU-666' where Issuer_Name = 'Mission Therapeutics'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001YpAle', JiraEpicKey =  '' where Issuer_Name = 'Morses Club PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '', JiraEpicKey =  'INVBAU-2144' where Issuer_Name = 'NetScientific PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001RMNf3', JiraEpicKey =  '' where Issuer_Name like 'NewRiver%'
Update t_master_issuer set  primaryAnalystPersonID = NULL ,  SecondaryAnalystPersonID =  NULL,  Salesforce_Account_Id  =  '0010O00001tXUA8', JiraEpicKey =  'INVBAU-6018' where Issuer_Name = 'NEX Exchange'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013Xy3r', JiraEpicKey =  'INVBAU-665' where Issuer_Name = 'Nexeon'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiPw', JiraEpicKey =  'INVBAU-3993' where Issuer_Name = 'Nightstar Therapeutics PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013XZIc', JiraEpicKey =  '' where Issuer_Name = 'Non-Standard Finance PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiPx', JiraEpicKey =  'INVBAU-2056' where Issuer_Name = 'Northwest Biotherapeutics Inc'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001CIW93', JiraEpicKey =  'INVBAU-664' where Issuer_Name = 'Novabiotics'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013YUNx', JiraEpicKey =  'INVBAU-2340' where Issuer_Name = 'NuCana PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001HELT0', JiraEpicKey =  'INVBAU-3328' where Issuer_Name like 'Oakley Capital%'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001CIW95', JiraEpicKey =  'INVBAU-20' where Issuer_Name = 'OMBU GROUP LTD'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '00120000013XZIe', JiraEpicKey =  'INVBAU-22' where Issuer_Name = 'Origin'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '', JiraEpicKey =  '' where Issuer_Name = 'OSI'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW96', JiraEpicKey =  'INVBAU-24' where Issuer_Name = 'Oxford Nanopore Technologies'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001RN0LB', JiraEpicKey =  'INVBAU-2467' where Issuer_Name = 'Oxford Pharmascience'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0010O00001qWnjA', JiraEpicKey =  'INVBAU-960' where Issuer_Name = 'Oxford Sciences Innovation'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0010O00001kX3WH', JiraEpicKey =  'INVBAU-2323' where Issuer_Name = 'OxSyBio'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001NuiQ3', JiraEpicKey =  '' where Issuer_Name like 'P2P%'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001CIW98', JiraEpicKey =  '' where Issuer_Name = 'PayPoint PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001p28S3', JiraEpicKey =  '' where Issuer_Name = 'Phoenix Group Holdings'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013Y3S6', JiraEpicKey =  'INVBAU-916' where Issuer_Name = 'Phoenix Product Development'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001TQmnK', JiraEpicKey =  'INVBAU-28' where Issuer_Name = 'Precision Biopsy'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001CIW9C', JiraEpicKey =  'INVBAU-2380' where Issuer_Name = 'Prothena Corp PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiQ7', JiraEpicKey =  'INVBAU-37' where Issuer_Name = 'Proton Partners International'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW9D', JiraEpicKey =  '' where Issuer_Name = 'Provident Financial PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '00120000013YUDi', JiraEpicKey =  'INVBAU-805' where Issuer_Name = 'PsiOxus Therapeutics'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001CIW9F', JiraEpicKey =  'INVBAU-905' where Issuer_Name = 'Purplebricks Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '', JiraEpicKey =  '' where Issuer_Name = 'Raven Property Group Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001YpsPL', JiraEpicKey =  'INVBAU-1139' where Issuer_Name = 'Reaction Engines'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW9I', JiraEpicKey =  '' where Issuer_Name = 'Redde PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001lpom8', JiraEpicKey =  '' where Issuer_Name = 'Redrow PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lrS8B', JiraEpicKey =  '' where Issuer_Name = 'Regional REIT Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiQF', JiraEpicKey =  'INVBAU-2170' where Issuer_Name = 'ReNeuron Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001QqySk', JiraEpicKey =  'INVBAU-902' where Issuer_Name = 'Retail Money Market'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001Hrunm', JiraEpicKey =  'INVBAU-997' where Issuer_Name = 'RM2 International SA'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001p22uK', JiraEpicKey =  '' where Issuer_Name = 'Royal Bank of Scotland Group Plc'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0012000001U3KdX', JiraEpicKey =  'INVBAU-682' where Issuer_Name = 'SABINA ESTATES LTD'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001qXjDl', JiraEpicKey =  '' where Issuer_Name = 'Safe Harbour Holdings PLC'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001fbrGZ', JiraEpicKey =  '' where Issuer_Name = 'Saga PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiQL', JiraEpicKey =  'INVBAU-989' where Issuer_Name = 'SciFluor Life Sciences'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001QKdiE', JiraEpicKey =  'INVBAU-908' where Issuer_Name = 'Seedrs'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001NuiQN', JiraEpicKey =  'INVBAU-2468' where Issuer_Name = 'Silence Therapeutics PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lqIcm', JiraEpicKey =  'INVBAU-2985' where Issuer_Name = 'Sirius Real Estate Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiQP', JiraEpicKey =  'INVBAU-3014' where Issuer_Name = 'Sphere Medical'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '00120000013Wzsd', JiraEpicKey =  'INVBAU-70' where Issuer_Name = 'Spin Transfer Technologies '
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW9a', JiraEpicKey =  'INVBAU-2470' where Issuer_Name = 'Spire Healthcare Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001NuiQS', JiraEpicKey =  '' where Issuer_Name = 'Stobart Group Ltd'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '0010O00001jf91Q', JiraEpicKey =  'INVBAU-3090' where Issuer_Name = 'Strix Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001Hrunu', JiraEpicKey =  'INVBAU-843' where Issuer_Name = 'Synairgen PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001eJqir', JiraEpicKey =  'INVBAU-2443' where Issuer_Name like 'Syncona%'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0010O00001mz2yl', JiraEpicKey =  '' where Issuer_Name = 'Taylor Wimpey PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001p22sO', JiraEpicKey =  '' where Issuer_Name = 'TEN Entertainment Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0012000001YpxmZ', JiraEpicKey =  'INVBAU-1834' where Issuer_Name = 'Theravance Biopharma Inc'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0012000001akAqo', JiraEpicKey =  'INVBAU-517' where Issuer_Name = 'Thin Film Electronics ASA'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013XZIx', JiraEpicKey =  'INVBAU-1050' where Issuer_Name = 'Time out Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001CIW9i', JiraEpicKey =  '' where Issuer_Name = 'Tissue Regenix Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001mzd99', JiraEpicKey =  '' where Issuer_Name = 'Topps Tiles PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '00120000013XZIy', JiraEpicKey =  'INVBAU-886' where Issuer_Name = 'Ultrahaptics Holdings'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0010O00001qXrLy', JiraEpicKey =  'INVBAU-6137' where Issuer_Name = 'Ultromics'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  151,  Salesforce_Account_Id  =  '0012000001CIW9k', JiraEpicKey =  '' where Issuer_Name = 'Utilitywise PLC'
Update t_master_issuer set  primaryAnalystPersonID = 51 ,  SecondaryAnalystPersonID =  28,  Salesforce_Account_Id  =  '0012000001CIW9m', JiraEpicKey =  'INVBAU-2977' where Issuer_Name = 'Vernalis PLC'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '00120000013XxHq', JiraEpicKey =  'INVBAU-33' where Issuer_Name = 'Viamet'
Update t_master_issuer set  primaryAnalystPersonID = 28 ,  SecondaryAnalystPersonID =  51,  Salesforce_Account_Id  =  '0012000001NuiQb', JiraEpicKey =  'INVBAU-2472' where Issuer_Name like 'Verseon%'
Update t_master_issuer set  primaryAnalystPersonID = 58 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '', JiraEpicKey =  'INVBAU-2811' where Issuer_Name like 'VPC%'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001o2fGm', JiraEpicKey =  '' where Issuer_Name = 'Warehouse Reit PLC'
Update t_master_issuer set  primaryAnalystPersonID = 151 ,  SecondaryAnalystPersonID =  58,  Salesforce_Account_Id  =  '0010O00001lpuH0', JiraEpicKey =  '' where Issuer_Name = 'Watkin Jones PLC'
Update t_master_issuer set  primaryAnalystPersonID = 42 ,  SecondaryAnalystPersonID =  11,  Salesforce_Account_Id  =  '', JiraEpicKey =  'INVBAU-4265' where Issuer_Name = 'Xeros Technology Group PLC'
Update t_master_issuer set  primaryAnalystPersonID = 11 ,  SecondaryAnalystPersonID =  42,  Salesforce_Account_Id  =  '0010O00001kWpaO', JiraEpicKey =  'INVBAU-2368' where Issuer_Name = 'Yoyo Wallet'



UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiOk' ,  BoxFolderID =  '5329358585' ,  JiraEpicKey =  'INVBAU-2458' WHERE EDM_Issuer_ID  = 600000003
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW7s' ,  BoxFolderID =  '7429079413' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000007
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001Udb4L' ,  BoxFolderID =  '2604518885' ,  JiraEpicKey =  'INVBAU-2461' WHERE EDM_Issuer_ID  = 600000010
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW7z' ,  BoxFolderID =  '2604519099' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000014
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW80' ,  BoxFolderID =  '12026941910' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000019
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001md07h' ,  BoxFolderID =  '31500999490' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000024
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW84' ,  BoxFolderID =  '2604519645' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000029
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0010O00001qWugI' ,  BoxFolderID =  '11958703366' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000034
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013XZHu' ,  BoxFolderID =  '4733548277' ,  JiraEpicKey =  'INVBAU-3105' WHERE EDM_Issuer_ID  = 600000036
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8H' ,  BoxFolderID =  '2604519999' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000037
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001NuiP9' ,  BoxFolderID =  '46604089378' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000038
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8I' ,  BoxFolderID =  '5575169889' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000040
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '34962842639' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000043
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000044
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8L' ,  BoxFolderID =  '2604520703' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000045
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001NuiPL' ,  BoxFolderID =  '2988368831' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000049
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8W' ,  BoxFolderID =  '2820897035' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000056
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013XZIE' ,  BoxFolderID =  '7409117621' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000057
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001iydz0' ,  BoxFolderID =  '6578010361' ,  JiraEpicKey =  'INVBAU-3003' WHERE EDM_Issuer_ID  = 600000058
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW8Y' ,  BoxFolderID =  '2604521213' ,  JiraEpicKey =  'INVBAU-2464' WHERE EDM_Issuer_ID  = 600000059
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID =  '' ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000060
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001p1uxs' ,  BoxFolderID =  '35989456792' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000063
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001o0zBg' ,  BoxFolderID =  '35198070390' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000064
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000065
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8c' ,  BoxFolderID =  '11942945370' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000066
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  'INVBAU-868' WHERE EDM_Issuer_ID  = 600000072
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '53134240387' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000074
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001kUm9C' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000075
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8q' ,  BoxFolderID =  '2786939325' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000083
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '34859153710' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000084
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID =  '' ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000086
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000087
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lqjrk' ,  BoxFolderID =  '23470336063' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000089
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001NuiPp' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000091
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013XZIU' ,  BoxFolderID =  '4999921457' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000092
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001CIW8x' ,  BoxFolderID =  '2705885132' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000093
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001akDVr' ,  BoxFolderID =  '3867717169' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000099
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW92' ,  BoxFolderID =  '2603718671' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000102
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XtUo' ,  BoxFolderID =  '6684546189' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000106
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lqjwz' ,  BoxFolderID =  '22134316787' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000112
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XZIk' ,  BoxFolderID =  '6379725925' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000114
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000117
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000125
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '2604523543' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000127
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9R' ,  BoxFolderID =  '2604523777' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000128
UPDATE T_MASTER_ISSUER
SET 
--PrimaryAnalystPersonID =   '', 
 Salesforce_Account_Id =  '0012000001Hrunn' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000129
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9S' ,  BoxFolderID =  '2604523923' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000130
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW9T' ,  BoxFolderID =  '2604524019' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000134
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '55657165429' ,  JiraEpicKey =  'INVBAU-7205' WHERE EDM_Issuer_ID  = 600000135
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0010O00001kWjmU' ,  BoxFolderID =  '18714690746' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000138
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiQP' ,  BoxFolderID =  '3199422629' ,  JiraEpicKey =  'INVBAU-2469' WHERE EDM_Issuer_ID  = 600000139
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O000022s06V' ,  BoxFolderID =  '2604524523' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000141
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID =  '' ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000153
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XZJ4' ,  BoxFolderID =  '5703685297' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000156
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID = ''  ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000160
--UPDATE T_MASTER_ISSUER
--SET PrimaryAnalystPersonID =  '' ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000161
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '2982504185' ,  JiraEpicKey =  'INVBAU-907' WHERE EDM_Issuer_ID  = 600000165
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013Wzco' ,  BoxFolderID =  '6017561141' ,  JiraEpicKey =  'INVBAU-31' WHERE EDM_Issuer_ID  = 600000170
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013Wzfn' ,  BoxFolderID =  '2604537297' ,  JiraEpicKey =  'INVBAU-29' WHERE EDM_Issuer_ID  = 600000176
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001eiFtU' ,  BoxFolderID =  '9216104373' ,  JiraEpicKey =  'INVBAU-1717' WHERE EDM_Issuer_ID  = 600000182
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001CIW8X' ,  BoxFolderID =  '2604541885' ,  JiraEpicKey =  'INVBAU-630' WHERE EDM_Issuer_ID  = 600000184
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0010O00001tXUA8' ,  BoxFolderID =  '45100942175' ,  JiraEpicKey =  'INVBAU-6018' WHERE EDM_Issuer_ID  = 600000212
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001SHKze' ,  BoxFolderID =  '2831989715' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000013
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001md0HX' ,  BoxFolderID =  '41636837718' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000015
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001mczjt' ,  BoxFolderID =  '5362298753' ,  JiraEpicKey =  'INVBAU-3013' WHERE EDM_Issuer_ID  = 600000026
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001CIW83' ,  BoxFolderID =  '16853060933' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000027
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lqjpA' ,  BoxFolderID =  '23459474934' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000028
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001CIW88' ,  BoxFolderID =  '4983309570' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000032
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001NuiPH' ,  BoxFolderID =  '' ,  JiraEpicKey =  'INVBAU-717' WHERE EDM_Issuer_ID  = 600000042
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001p1vPm' ,  BoxFolderID =  '30698484442' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000047
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001mczn2' ,  BoxFolderID =  '4828324637' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000048
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lpgPF' ,  BoxFolderID =  '28270099167' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000050
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lqIe4' ,  BoxFolderID =  '2604531001' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000054
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001CIW8U' ,  BoxFolderID =  '2604520815' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000055
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '00120000013XuX8' ,  BoxFolderID =  '2604542297' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000073
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001uIF8S' ,  BoxFolderID =  '34059297410' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000079
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001qWYY1' ,  BoxFolderID =  '40904151959' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000081
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001RMNf3' ,  BoxFolderID =  '5749661061' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000101
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001CIW98' ,  BoxFolderID =  '3798198694' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000111
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000120
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lrS8B' ,  BoxFolderID =  '37990833146' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000123
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001qXjDl' ,  BoxFolderID =  '5473615925' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000132
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lqIcm' ,  BoxFolderID =  '22675337252' ,  JiraEpicKey =  'INVBAU-2985' WHERE EDM_Issuer_ID  = 600000137
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0012000001NuiQS' ,  BoxFolderID =  '11997187078' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000142
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001p22sO' ,  BoxFolderID =  '39337566155' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000147
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001mzd99' ,  BoxFolderID =  '22687224383' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000152
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001o2fGm' ,  BoxFolderID =  '34602068137' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000158
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  151 ,  Salesforce_Account_Id =  '0010O00001lpuH0' ,  BoxFolderID =  '21960585610' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000159
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013Xwyt' ,  BoxFolderID =  '2604518801' ,  JiraEpicKey =  'INVBAU-959' WHERE EDM_Issuer_ID  = 600000006
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001CIW81' ,  BoxFolderID =  '2604519467' ,  JiraEpicKey =  'INVBAU-4259' WHERE EDM_Issuer_ID  = 600000021
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000061
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001RMN6G' ,  BoxFolderID =  '3716121334' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000071
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001CIW9M' ,  BoxFolderID =  '3798203742' ,  JiraEpicKey =  'INVBAU-4262' WHERE EDM_Issuer_ID  = 600000078
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013Xy2Y' ,  BoxFolderID =  '2763541823' ,  JiraEpicKey =  'INVBAU-4264' WHERE EDM_Issuer_ID  = 600000094
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001HELT0' ,  BoxFolderID =  '37826376060' ,  JiraEpicKey =  'INVBAU-3328' WHERE EDM_Issuer_ID  = 600000108
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001CIW9F' ,  BoxFolderID =  '2604545677' ,  JiraEpicKey =  'INVBAU-905' WHERE EDM_Issuer_ID  = 600000119
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001U3KdX' ,  BoxFolderID =  '5473615925' ,  JiraEpicKey =  'INVBAU-682' WHERE EDM_Issuer_ID  = 600000131
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0010O00001jf91Q' ,  BoxFolderID =  '26663414012' ,  JiraEpicKey =  'INVBAU-3090' WHERE EDM_Issuer_ID  = 600000143
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013XZIx' ,  BoxFolderID =  '6776410314' ,  JiraEpicKey =  'INVBAU-1050' WHERE EDM_Issuer_ID  = 600000150
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013Y5G2' ,  BoxFolderID =  '2604525101' ,  JiraEpicKey =  'INVBAU-4265' WHERE EDM_Issuer_ID  = 600000162
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001VKoXM' ,  BoxFolderID =  '5724711849' ,  JiraEpicKey =  'INVBAU-659' WHERE EDM_Issuer_ID  = 600000164
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001QquNr' ,  BoxFolderID =  '2604530883' ,  JiraEpicKey =  'INVBAU-633' WHERE EDM_Issuer_ID  = 600000168
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001NuiPH' ,  BoxFolderID =  '2906865087' ,  JiraEpicKey =  'INVBAU-717' WHERE EDM_Issuer_ID  = 600000178
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013Xwsg' ,  BoxFolderID =  '5724576761' ,  JiraEpicKey =  'INVBAU-661' WHERE EDM_Issuer_ID  = 600000181
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001NuiPi' ,  BoxFolderID =  '3129746741' ,  JiraEpicKey =  'INVBAU-906' WHERE EDM_Issuer_ID  = 600000188
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0010O00001tTml1' ,  BoxFolderID =  '40630799714' ,  JiraEpicKey =  'INVBAU-4982' WHERE EDM_Issuer_ID  = 600000190
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013Xy3r' ,  BoxFolderID =  '5724222201' ,  JiraEpicKey =  'INVBAU-665' WHERE EDM_Issuer_ID  = 600000195
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001QqySk' ,  BoxFolderID =  '3030145149' ,  JiraEpicKey =  'INVBAU-902' WHERE EDM_Issuer_ID  = 600000204
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '00120000013XZIy' ,  BoxFolderID =  '3905103473' ,  JiraEpicKey =  'INVBAU-886' WHERE EDM_Issuer_ID  = 600000208
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  42 ,  Salesforce_Account_Id =  '0012000001YpsPL' ,  BoxFolderID =  '7685771870' ,  JiraEpicKey =  'INVBAU-1139' WHERE EDM_Issuer_ID  = 600000214
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0010O00001sLQTt' ,  BoxFolderID =  '49162978589' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000004
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW7q' ,  BoxFolderID =  '2604518737' ,  JiraEpicKey =  'INVBAU-2460' WHERE EDM_Issuer_ID  = 600000005
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001RNF24' ,  BoxFolderID =  '4102524607' ,  JiraEpicKey =  'INVBAU-755' WHERE EDM_Issuer_ID  = 600000011
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001fLNYR' ,  BoxFolderID =  '8376715977' ,  JiraEpicKey =  'INVBAU-2462' WHERE EDM_Issuer_ID  = 600000022
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013Wzfn' ,  BoxFolderID =  '2785613321' ,  JiraEpicKey =  'INVBAU-29' WHERE EDM_Issuer_ID  = 600000035
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiPM' ,  BoxFolderID =  '3198171555' ,  JiraEpicKey =  'INVBAU-2463' WHERE EDM_Issuer_ID  = 600000046
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW8e' ,  BoxFolderID =  '2604521579' ,  JiraEpicKey =  'INVBAU-2465' WHERE EDM_Issuer_ID  = 600000069
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiPr' ,  BoxFolderID =  '3897904573' ,  JiraEpicKey =  'INVBAU-35' WHERE EDM_Issuer_ID  = 600000095
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiPw' ,  BoxFolderID =  '40845873461' ,  JiraEpicKey =  'INVBAU-3993' WHERE EDM_Issuer_ID  = 600000103
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013YUNx' ,  BoxFolderID =  '40850806688' ,  JiraEpicKey =  'INVBAU-2340' WHERE EDM_Issuer_ID  = 600000107
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW9C' ,  BoxFolderID =  '2651763339' ,  JiraEpicKey =  'INVBAU-2380' WHERE EDM_Issuer_ID  = 600000115
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001Hrunu' ,  BoxFolderID =  '3203745367' ,  JiraEpicKey =  'INVBAU-843' WHERE EDM_Issuer_ID  = 600000144
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001YpxmZ' ,  BoxFolderID =  '4800657441' ,  JiraEpicKey =  'INVBAU-1834' WHERE EDM_Issuer_ID  = 600000148
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW9i' ,  BoxFolderID =  '2740077586' ,  JiraEpicKey =  'INVBAU-2471' WHERE EDM_Issuer_ID  = 600000151
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiQb' ,  BoxFolderID =  '6873890854' ,  JiraEpicKey =  'INVBAU-2472' WHERE EDM_Issuer_ID  = 600000155
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013YUgq' ,  BoxFolderID =  '6456980449' ,  JiraEpicKey =  'INVBAU-1203' WHERE EDM_Issuer_ID  = 600000173
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001bAONS' ,  BoxFolderID =  '5094115398' ,  JiraEpicKey =  'INVBAU-789' WHERE EDM_Issuer_ID  = 600000177
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013WzuZ' ,  BoxFolderID =  '2604540009' ,  JiraEpicKey =  'INVBAU-73' WHERE EDM_Issuer_ID  = 600000180
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013XiUy' ,  BoxFolderID =  '5724029533' ,  JiraEpicKey =  'INVBAU-667' WHERE EDM_Issuer_ID  = 600000187
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001HrunY' ,  BoxFolderID =  '2741724726' ,  JiraEpicKey =  'INVBAU-869' WHERE EDM_Issuer_ID  = 600000189
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013XufH' ,  BoxFolderID =  '5724134177' ,  JiraEpicKey =  'INVBAU-666' WHERE EDM_Issuer_ID  = 600000194
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001CIW93' ,  BoxFolderID =  '5724361049' ,  JiraEpicKey =  'INVBAU-664' WHERE EDM_Issuer_ID  = 600000196
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001TQmnK' ,  BoxFolderID =  '4159260275' ,  JiraEpicKey =  'INVBAU-28' WHERE EDM_Issuer_ID  = 600000200
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0012000001NuiQL' ,  BoxFolderID =  '3356375932' ,  JiraEpicKey =  'INVBAU-989' WHERE EDM_Issuer_ID  = 600000205
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '00120000013XxHq' ,  BoxFolderID =  '2604555053' ,  JiraEpicKey =  'INVBAU-33' WHERE EDM_Issuer_ID  = 600000209
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0010O00001qXrLy' ,  BoxFolderID =  '46606597276' ,  JiraEpicKey =  'INVBAU-6137' WHERE EDM_Issuer_ID  = 600000213
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  28 ,  Salesforce_Account_Id =  '0010O00001kX3WH' ,  BoxFolderID =  '13333951416' ,  JiraEpicKey =  'INVBAU-2323' WHERE EDM_Issuer_ID  = 600000215
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW8N' ,  BoxFolderID =  '2604518565' ,  JiraEpicKey =  'INVBAU-2457' WHERE EDM_Issuer_ID  = 600000000
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  'INVBAU-658' WHERE EDM_Issuer_ID  = 600000002
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001WTkWJ' ,  BoxFolderID =  '6000305529' ,  JiraEpicKey =  'INVBAU-676' WHERE EDM_Issuer_ID  = 600000008
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001WTkWJ' ,  BoxFolderID =  '6000305529' ,  JiraEpicKey =  'INVBAU-676' WHERE EDM_Issuer_ID  = 600000009
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001RNF24' ,  BoxFolderID =  '4102524607' ,  JiraEpicKey =  'INVBAU-755' WHERE EDM_Issuer_ID  = 600000012
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW8Q' ,  BoxFolderID =  '8378731289' ,  JiraEpicKey =  'INVBAU-30' WHERE EDM_Issuer_ID  = 600000053
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013XZIH' ,  BoxFolderID =  '5317833961' ,  JiraEpicKey =  'INVBAU-2466' WHERE EDM_Issuer_ID  = 600000070
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013XwZ5' ,  BoxFolderID =  '3068339037' ,  JiraEpicKey =  'INVBAU-957' WHERE EDM_Issuer_ID  = 600000077
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013XZIR' ,  BoxFolderID =  '3070370283' ,  JiraEpicKey =  'INVBAU-1064' WHERE EDM_Issuer_ID  = 600000090
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW8y' ,  BoxFolderID =  '2717682018' ,  JiraEpicKey =  'INVBAU-1633' WHERE EDM_Issuer_ID  = 600000097
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013Y2rF' ,  BoxFolderID =  '2604522511' ,  JiraEpicKey =  'INVBAU-2144' WHERE EDM_Issuer_ID  = 600000100
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiPx' ,  BoxFolderID =  '' ,  JiraEpicKey =  'INVBAU-2056' WHERE EDM_Issuer_ID  = 600000105
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiQF' ,  BoxFolderID =  '2633673739' ,  JiraEpicKey =  'INVBAU-2170' WHERE EDM_Issuer_ID  = 600000124
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001Hrunm' ,  BoxFolderID =  '2604523281' ,  JiraEpicKey =  'INVBAU-997' WHERE EDM_Issuer_ID  = 600000126
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiQN' ,  BoxFolderID =  '2807505403' ,  JiraEpicKey =  'INVBAU-2468' WHERE EDM_Issuer_ID  = 600000136
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001eJqir' ,  BoxFolderID =  '20952355091' ,  JiraEpicKey =  'INVBAU-2443' WHERE EDM_Issuer_ID  = 600000145
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001XQwMC' ,  BoxFolderID =  '6345554037' ,  JiraEpicKey =  'INVBAU-658' WHERE EDM_Issuer_ID  = 600000163
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001WTkQ6' ,  BoxFolderID =  '2742416530' ,  JiraEpicKey =  'INVBAU-783' WHERE EDM_Issuer_ID  = 600000167
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW9e' ,  BoxFolderID =  '2604552747' ,  JiraEpicKey =  'INVBAU-18' WHERE EDM_Issuer_ID  = 600000169
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiP2' ,  BoxFolderID =  '7589160273' ,  JiraEpicKey =  'INVBAU-1370' WHERE EDM_Issuer_ID  = 600000172
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW8A' ,  BoxFolderID =  '2604536191' ,  JiraEpicKey =  'INVBAU-866' WHERE EDM_Issuer_ID  = 600000174
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiP6' ,  BoxFolderID =  '2792629867' ,  JiraEpicKey =  'INVBAU-25' WHERE EDM_Issuer_ID  = 600000175
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiPR' ,  BoxFolderID =  '2604540105' ,  JiraEpicKey =  'INVBAU-988' WHERE EDM_Issuer_ID  = 600000183
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiPd' ,  BoxFolderID =  '3297899444' ,  JiraEpicKey =  'INVBAU-34' WHERE EDM_Issuer_ID  = 600000186
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW8v' ,  BoxFolderID =  '6452926277' ,  JiraEpicKey =  'INVBAU-657' WHERE EDM_Issuer_ID  = 600000191
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013XZIe' ,  BoxFolderID =  '2604528657' ,  JiraEpicKey =  'INVBAU-22' WHERE EDM_Issuer_ID  = 600000197
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001CIW96' ,  BoxFolderID =  '2604542527' ,  JiraEpicKey =  'INVBAU-24' WHERE EDM_Issuer_ID  = 600000198
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0010O00001qWnjA' ,  BoxFolderID =  '3098260455' ,  JiraEpicKey =  'INVBAU-960' WHERE EDM_Issuer_ID  = 600000199
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '0012000001NuiQ7' ,  BoxFolderID =  '3369361914' ,  JiraEpicKey =  'INVBAU-37' WHERE EDM_Issuer_ID  = 600000202
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '00120000013YUDi' ,  BoxFolderID =  '3122879255' ,  JiraEpicKey =  'INVBAU-805' WHERE EDM_Issuer_ID  = 600000203
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  51 ,  Salesforce_Account_Id =  '' ,  BoxFolderID =  '' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000211
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW7x' ,  BoxFolderID =  '3280168148' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000001
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O000021PJR6' ,  BoxFolderID =  '30611922327' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000016
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lpoox' ,  BoxFolderID =  '20381431807' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000017
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001NuiOu' ,  BoxFolderID =  '6204942093' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000018
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lqjwa' ,  BoxFolderID =  '22134338454' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000020
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001i2VxQ' ,  BoxFolderID =  '11482778846' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000023
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW85' ,  BoxFolderID =  '2604519775' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000030
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001QLDhy' ,  BoxFolderID =  '3576414765' ,  JiraEpicKey =  'INVBAU-4260' WHERE EDM_Issuer_ID  = 600000031
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lrYzF' ,  BoxFolderID =  '25745273718' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000033
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XLPf' ,  BoxFolderID =  '22703731505' ,  JiraEpicKey =  'INVBAU-789' WHERE EDM_Issuer_ID  = 600000039
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lrKvk' ,  BoxFolderID =  '24515821218' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000041
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001iN75I' ,  BoxFolderID =  '13693053395' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000051
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW8d' ,  BoxFolderID =  '3166663335' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000067
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001p33Ji' ,  BoxFolderID =  '6617230009' ,  JiraEpicKey =  'INVBAU-2972' WHERE EDM_Issuer_ID  = 600000068
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001o0HcV' ,  BoxFolderID =  '25865217190' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000082
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XtjR' ,  BoxFolderID =  '2604522253' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000085
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013Y6iO' ,  BoxFolderID =  '3237866532' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000088
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XZIV' ,  BoxFolderID =  '3897904573' ,  JiraEpicKey =  'INVBAU-516' WHERE EDM_Issuer_ID  = 600000096
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001YpAle' ,  BoxFolderID =  '7373402801' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000098
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XZIc' ,  BoxFolderID =  '2683098767' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000104
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001NuiQ3' ,  BoxFolderID =  '2906888579' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000110
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001p28S3' ,  BoxFolderID =  '30611907468' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000113
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9D' ,  BoxFolderID =  '2604522721' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000116
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9I' ,  BoxFolderID =  '3080713461' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000121
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001lpom8' ,  BoxFolderID =  '31521898284' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000122
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001fbrGZ' ,  BoxFolderID =  '3720523354' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000133
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9a' ,  BoxFolderID =  '2604548417' ,  JiraEpicKey =  'INVBAU-2470' WHERE EDM_Issuer_ID  = 600000140
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0010O00001mz2yl' ,  BoxFolderID =  '27549614558' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000146
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '0012000001CIW9k' ,  BoxFolderID =  '2989716513' ,  JiraEpicKey =  '' WHERE EDM_Issuer_ID  = 600000154
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  58 ,  Salesforce_Account_Id =  '00120000013XZJ5' ,  BoxFolderID =  '3129635017' ,  JiraEpicKey =  'INVBAU-2811' WHERE EDM_Issuer_ID  = 600000157
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001Hrunl' ,  BoxFolderID =  '2604523039' ,  JiraEpicKey =  'INVBAU-1048' WHERE EDM_Issuer_ID  = 600000025
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001bCTF8' ,  BoxFolderID =  '8378731289' ,  JiraEpicKey =  'INVBAU-1296' WHERE EDM_Issuer_ID  = 600000052
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '00120000013Y2wF' ,  BoxFolderID =  '2604521331' ,  JiraEpicKey =  'INVBAU-1426' WHERE EDM_Issuer_ID  = 600000062
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001CIW8j' ,  BoxFolderID =  '' ,  JiraEpicKey =  'INVBAU-868' WHERE EDM_Issuer_ID  = 600000076
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001CIW8m' ,  BoxFolderID =  '2604528189' ,  JiraEpicKey =  'INVBAU-4263' WHERE EDM_Issuer_ID  = 600000080
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001CIW95' ,  BoxFolderID =  '2906888579' ,  JiraEpicKey =  'INVBAU-20' WHERE EDM_Issuer_ID  = 600000109
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001CIW9F' ,  BoxFolderID =  '2604545677' ,  JiraEpicKey =  'INVBAU-905' WHERE EDM_Issuer_ID  = 600000118
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001akAqo' ,  BoxFolderID =  '6227268237' ,  JiraEpicKey =  'INVBAU-517' WHERE EDM_Issuer_ID  = 600000149
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '00120000013Xy8X' ,  BoxFolderID =  '5473354073' ,  JiraEpicKey =  'INVBAU-683' WHERE EDM_Issuer_ID  = 600000166
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0010O00001o0HPC' ,  BoxFolderID =  '38569752210' ,  JiraEpicKey =  'INVBAU-3384' WHERE EDM_Issuer_ID  = 600000171
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '00120000013X0ls' ,  BoxFolderID =  '4479944486' ,  JiraEpicKey =  'INVBAU-961' WHERE EDM_Issuer_ID  = 600000179
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001iXtZ5' ,  BoxFolderID =  '10951110770' ,  JiraEpicKey =  'INVBAU-1841' WHERE EDM_Issuer_ID  = 600000185
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0010O00001p1hb1' ,  BoxFolderID =  '38929759721' ,  JiraEpicKey =  'INVBAU-3420' WHERE EDM_Issuer_ID  = 600000192
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001QJMGm' ,  BoxFolderID =  '5473014225' ,  JiraEpicKey =  'INVBAU-687' WHERE EDM_Issuer_ID  = 600000193
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '00120000013Y3S6' ,  BoxFolderID =  '2604545499' ,  JiraEpicKey =  'INVBAU-916' WHERE EDM_Issuer_ID  = 600000201
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0012000001QKdiE' ,  BoxFolderID =  '3509516295' ,  JiraEpicKey =  'INVBAU-908' WHERE EDM_Issuer_ID  = 600000206
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '00120000013Wzsd' ,  BoxFolderID =  '2604548417' ,  JiraEpicKey =  'INVBAU-70' WHERE EDM_Issuer_ID  = 600000207
UPDATE T_MASTER_ISSUER
SET PrimaryAnalystPersonID =  11 ,  Salesforce_Account_Id =  '0010O00001kWpaO' ,  BoxFolderID =  '19183214011' ,  JiraEpicKey =  'INVBAU-2368' WHERE EDM_Issuer_ID  = 600000210

--Update t_master_sec Issuers to match Issuers table
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Mediclinic International PLC' WHERE ISSUER  =  'Al Noor Hospitals Group PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Amigo Holdings PLC' WHERE ISSUER  =  'Amigo Holdings PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Barclays PLC' WHERE ISSUER  =  'Barclays Bank PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Bioverativ Inc' WHERE ISSUER  =  'Bioverativ Inc'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Crystal Amber Asset Management' WHERE ISSUER  =  'Crystal Amber Fund Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Draper Fisher Jurvetson Intern' WHERE ISSUER  =  'Draper Esprit PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HEALTH HOLDCO LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HEALTH HOLDCO LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HEALTH HOLDCO LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HEALTH HOLDCO LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HEALTH HOLDCO LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON HOLDCO2 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Econic Technologies' WHERE ISSUER  =  'ECONIC TECH'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Econic Technologies' WHERE ISSUER  =  'ECONIC TECH'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Hostelworld Group Plc' WHERE ISSUER  =  'Hostelworld Group Plc'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'IH Holdings International Ltd' WHERE ISSUER  =  'IH HOLDINGS INTL'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'IH Holdings International Ltd' WHERE ISSUER  =  'IND HEAT'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'IH Holdings International Ltd' WHERE ISSUER  =  'IND HEAT'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Juno Therapeutics Inc' WHERE ISSUER  =  'Juno Therapeutics Inc'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'NewRiver REIT PLC' WHERE ISSUER  =  'NewRiver'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'NewRiver REIT PLC' WHERE ISSUER  =  'NewRiver Retail Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oakley Capital Ltd' WHERE ISSUER  =  'Oakley Capital Investments Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oxford Sciencs Innovation' WHERE ISSUER  =  'OXFORD PHARMA'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oxford Sciencs Innovation' WHERE ISSUER  =  'OXFORD PHARMA'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'P2P Global Investments PLC' WHERE ISSUER  =  'P2P Global Investments PLC/Fun'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Raven Property Group Ltd' WHERE ISSUER  =  'RAVEN RUSSIA LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Reynolds American Inc' WHERE ISSUER  =  'Reynolds American Inc'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Royal Bank of Scotland Group P' WHERE ISSUER  =  'Royal Bank of Scotland Group P'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Sphere Medical Holding PLC' WHERE ISSUER  =  'SPHERE MED LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Sphere Medical Holding PLC' WHERE ISSUER  =  'SPHERE MED LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Syncona Investments LP Inc' WHERE ISSUER  =  'Syncona Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Touchstone Innovations PLC' WHERE ISSUER  =  'Touchstone Innovations PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'USL Pharma International UK Lt' WHERE ISSUER  =  'USL PHARMA'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Metalysis Ltd' WHERE ISSUER  =  'WATH'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Metalysis Ltd' WHERE ISSUER  =  'WATH'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Metalysis Ltd' WHERE ISSUER  =  'WATH'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Metalysis Ltd' WHERE ISSUER  =  'WATH'

UPDATE T_MASTER_SEC SET  
ISSUER  = 'Metalysis Ltd' WHERE ISSUER  =  'Metalysis'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Accelerated Digital Ventures ' WHERE ISSUER  =  'ADV'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Mediclinic International PLC' WHERE ISSUER  =  'Al Noor Hospitals Group PLC '
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Welsh Carson Anderson & Stowe' WHERE ISSUER  =  'Abzena PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Halosource Corp' WHERE ISSUER  =  'Halosource Inc'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Ligand Pharmaceuticals Inc' WHERE ISSUER  =  'Vernalis PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Time out Group PLC' WHERE ISSUER  =  'Time out Group Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Royal Dutch Shell PLC' WHERE ISSUER  =  'BG Group Ltd'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Aston Martin Lagonda Global Ho' WHERE ISSUER  =  'MS Amlin PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Public Storage' WHERE ISSUER  =  'Public Storage INC'

UPDATE T_MASTER_SEC SET  
ISSUER  = 'Accelerated Digital Ventures ' WHERE ISSUER  =  'ADV'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'American Financial Exchange' WHERE ISSUER  =  'AFX'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'AJ Bell Holdings' WHERE ISSUER  =  'AJ BELL'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Arix Bioscience Plc' WHERE ISSUER  =  'ARIX BIO'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Autolus Therapeutics PLC' WHERE ISSUER  =  'AUTOLUS'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Beazley PLC' WHERE ISSUER  =  'Beazley Ireland Holdings PLC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Bodle Technologies' WHERE ISSUER  =  'BODLE'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Brandon Point Enterprises 1' WHERE ISSUER  =  'BRAN POINT'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Carrick Therapeutics' WHERE ISSUER  =  'CARRICK THERAP'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Cell Medica' WHERE ISSUER  =  'CELLMEDICA'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Cambridge Innovation Capital' WHERE ISSUER  =  'CIC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Cosmederm Bioscience' WHERE ISSUER  =  'COSMEDERM'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'DDF Parallel' WHERE ISSUER  =  'DDF'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Drayson Technologies' WHERE ISSUER  =  'DRAYSON'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Eve Sleep PLC' WHERE ISSUER  =  'EVE SLEEP'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Evofem Biosciences Inc' WHERE ISSUER  =  'EVOFEM'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Evofem Biosciences Inc' WHERE ISSUER  =  'EVOFEM BIOSCIENCES'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Evofem Biosciences Inc' WHERE ISSUER  =  'EVOFEM D'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Federated Wireless' WHERE ISSUER  =  'FED WIRELESS INC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Federated Wireless' WHERE ISSUER  =  'FEDERATED WIRELESS INC'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Fibre 7 UK ' WHERE ISSUER  =  'FIBRE 7'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'HawkEye 360' WHERE ISSUER  =  'HAWKEYE'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Kind Consumer Holdings' WHERE ISSUER  =  'KIND'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Kymab Group' WHERE ISSUER  =  'KYMAB'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Literacy Capital' WHERE ISSUER  =  'LITERACY CAP'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Mafic' WHERE ISSUER  =  'MAFIC S.A.'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Malin J1' WHERE ISSUER  =  'MALIN J1 LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Mereo Biopharma Group PLC' WHERE ISSUER  =  'MEREO'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Mission Therapeutics' WHERE ISSUER  =  'MISSION'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Ombu Group Ltd' WHERE ISSUER  =  'OMBU'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oxford Nanopore Technologies' WHERE ISSUER  =  'OXFORD NANO'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oxford Sciencs Innovation' WHERE ISSUER  =  'Oxford Pharmascience LTD'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Oxford Sciencs Innovation' WHERE ISSUER  =  'OXFORD SCIENCES'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Phoenix Group Holdings' WHERE ISSUER  =  'PHOENIX'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Precision Biopsy' WHERE ISSUER  =  'PRECISION BIO'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Proton Partners International' WHERE ISSUER  =  'PROTON PARTNERS'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'PsiOxus Therapeutics' WHERE ISSUER  =  'PSIOXUS'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Retail Money Market' WHERE ISSUER  =  'RATESETTER'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'RM2 International SA' WHERE ISSUER  =  'RM2 INTERNATIONAL'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Royal Bank of Scotland Group' WHERE ISSUER  =  'Royal Bank of Scotland Group P'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Sabina Estates Ltd' WHERE ISSUER  =  'SABINA'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'SciFluor Life Sciences' WHERE ISSUER  =  'SCIFLUOR LIFE'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Sphere Medical Holding PLC' WHERE ISSUER  =  'SPHERE MEDICAL HOLDINGS'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Spin Transfer Technologies ' WHERE ISSUER  =  'SPIN TRANSFER'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Ultrahaptics Holdings' WHERE ISSUER  =  'ULTRAHAPTICS'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'USL Pharma International UK Lt' WHERE ISSUER  =  'USL Pharma International UK Lt'
UPDATE T_MASTER_SEC SET  
ISSUER  = 'Yoyo Wallet' WHERE ISSUER  =  'YOYO'


--Update EDM_ISSUER_ID
UPDATE   dbo.T_MASTER_SEC
SET EDM_ISSUER_ID =  ISS.EDM_ISSUER_ID
FROM T_MASTER_SEC S 
INNER JOIN  T_MASTER_ISSUER ISS
ON S.ISSUER = ISS.issuer_Name  


COMMIT TRANSACTION

END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;



-- Write errors to table: dbo.LogProcErrors

EXECUTE dbo.usp_LogProcErrors



/*

-- this secion can be enabled if you want the error to print on the screen

DECLARE
@ERROR_SEVERITY INT,
@ERROR_STATE INT,
@ERROR_NUMBER INT,
@ERROR_LINE INT,
@ERROR_MESSAGE NVARCHAR(4000);


SELECT
@ERROR_SEVERITY = ERROR_SEVERITY(),
@ERROR_STATE = ERROR_STATE(),
@ERROR_NUMBER = ERROR_NUMBER(),
@ERROR_LINE = ERROR_LINE(),
@ERROR_MESSAGE = @strProcedureName + ' - ' + ERROR_MESSAGE() ;

RAISERROR('Msg %d, Line %d, :%s',
@ERROR_SEVERITY,
@ERROR_STATE,
@ERROR_NUMBER,
@ERROR_LINE,
@ERROR_MESSAGE);
*/

END CATCH

