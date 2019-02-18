
CREATE VIEW [reporting].[SisenseMasterPosition]
/******************************
** Desc: Sisense view over Master Position
**		 
** Auth: R. Walker
** Date: 14/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1785     14/02/2018  R.Walker	Initial version of view
*******************************/
AS 


SELECT [SOURCE]
      ,[POSITION_TYPE]
      ,[EDM_SEC_ID]
      ,[FUND_SHORT_NAME]
      ,[LONG_SHORT_IND]
      ,[POSITION_DATE]
      ,[QUANTITY]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
FROM [dbo].[T_MASTER_POS]



