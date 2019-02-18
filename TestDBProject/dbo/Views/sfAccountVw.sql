﻿

CREATE VIEW [dbo].[sfAccountVw]
AS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[MxAccountVw]
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R. Dixon,	24/08/2018 DAP-1753 - Used to illustrate Salesforce Account Details given Account Siv Id
-------------------------------------------------------------------------------------- 

SELECT	AccountSivId, AccountName + ' - ' + BillingStreet + ', ' + BillingCity + ', ' + BillingPostcode AS AccountName
FROM	[Sales.BP].sfAccountVw

