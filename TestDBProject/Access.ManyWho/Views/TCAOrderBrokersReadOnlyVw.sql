CREATE VIEW [Access.ManyWho].[TCAOrderBrokersReadOnlyVw]
	AS 
SELECT
	   OrderBrokerId
	  ,OrderId
      ,Broker
	  ,sb.BrokerName
	  ,TotalShares
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [TCA].[TCAOrderBrokers] tob
  LEFT OUTER JOIN [Access.ManyWho].[SubBrokersVw] sb
  ON sb.BloombergId = tob.Broker;
