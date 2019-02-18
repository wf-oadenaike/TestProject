CREATE VIEW [Access.ManyWho].[TCAOrderAccountsReadOnlyVw]
	AS 
SELECT
	   [OrderAccountId]
	  ,[OrderId]
      ,[Account]
	  ,[TotalShares]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [TCA].[TCAOrderAccounts];
