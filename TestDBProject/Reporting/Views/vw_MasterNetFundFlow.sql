
CREATE VIEW [Reporting].[vw_MasterNetFundFlow]
/******************************
** Desc: Reporting view over Master Net Fund Flow
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


SELECT [FILE_NAME]
      ,[FILE_TYPE]
      ,[FILE_DATE]
      ,[NUMBER_OF_RECORDS]
      ,[CONSOLIDATION]
      ,[ACCOUNT_NUMBER]
      ,[FUND_SHORT_NAME]
      ,[FROM_DATE]
      ,[THROUGH_DATE]
      ,[TASTDESCMED]
      ,[TNARRLONG]
      ,[ABASBSE]
      ,[NET_AMOUNT__BASE]
      ,[AMKTVAL]
      ,[ARLSDGAIN]
      ,[AEXCHGNLS]
      ,[RECOGNITION_DATE]
      ,[NTRANCATG]
      ,[ASSET_IDENTIFIER]
      ,[CTEMPLTYPE]
      ,[CVALNTYPEO]
      ,[TSHAREPAR]
      ,[REVERSAL_INDICATOR]
      ,[ALOTCOSTGNLS]
      ,[DTRANPROC]
      ,[CSORTCDE3]
      ,[ERROR_CODE]
      ,[CONSOLIDATION_AUDIT_INDICATOR_FLAG]
      ,[IEXTLREF]
      ,[CASSETLIAB]
      ,[ACCRUED_INTEREST]
      ,[DSET]
      ,[ACCRUAL_CHANGE_FROM_SECURITY_MOVEMENTS_OFFSET]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [dbo].[T_MASTER_NET_FUND_FLOW]



