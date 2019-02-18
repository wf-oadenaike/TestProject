CREATE VIEW [Access.ManyWho].[MasterSecuritiesVw]
AS 
/******************************
** Desc:
** Auth: J.Brennan
** Date: 16/11/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1506     16/11/2017  J.Brennan   Initial version 
** DAP-1550		13/12/2017	R.Dixon		removed union with T_MASTER_SHARECLASS as not required.
*******************************/
SELECT CASE WHEN [SECURITY_NAME] = ' ' THEN 'UNKNOWN' 
            WHEN [SECURITY_NAME] IS NULL THEN 'UNKNOWN' ELSE [SECURITY_NAME] END as Name
	  ,CASE WHEN [PARSEKEYABLE_DESCRIPTION] = ' ' THEN 'UNKNOWN' 
            WHEN [PARSEKEYABLE_DESCRIPTION] IS NULL THEN 'UNKNOWN' ELSE [PARSEKEYABLE_DESCRIPTION] END as Ticker
      ,[UNIQUE_BLOOMBERG_ID] as BloombergId
	  ,[EDM_SEC_ID] as EDM_SEC_ID
	  ,[SECURITY_DESCRIPTION]
	  ,(CASE WHEN [SECURITY_NAME] = ' ' THEN 'UNKNOWN' 
            WHEN [SECURITY_NAME] IS NULL THEN 'UNKNOWN' ELSE [SECURITY_NAME] END) + ' (' + [SECURITY_DESCRIPTION] + ')' as CustomName
	  ,[SECURITY_ISO_CCY]
  FROM [dbo].[T_MASTER_SEC]
  WHERE [UNIQUE_BLOOMBERG_ID] IS NOT NULL
 UNION
 SELECT [LONG_NAME] 
	  , [SHORT_NAME]
	  , [SHORT_NAME]
	  , NULL
	  , NULL
	  ,NULL
	  ,NULL
  FROM [dbo].[T_MASTER_FND]
  /*
  UNION
 SELECT [SHARECLASS] 
	  , [TICKER]
	  , [UNIQUE_BLOOMBERG_ID]
	  , NULL
	  , NULL
	  ,NULL
	  ,NULL
  FROM [dbo].[T_MASTER_SHARECLASS]
  WHERE [UNIQUE_BLOOMBERG_ID] NOT IN (SELECT [UNIQUE_BLOOMBERG_ID]
                                      FROM [dbo].[T_MASTER_SEC]) 

*/

