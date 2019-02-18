/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW  Reporting.vw_ReasonCode
AS
SELECT  [Code]
      ,[Description]
      ,[Narrative]
  FROM [dbo].[T_BBG_ReasonCode]