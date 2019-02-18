
CREATE PROCEDURE [ETL].[OperationsMergeWEIFFeederPrice]
AS
	MERGE INTO [Operation].[WEIFFeederFundPrice] Tar
	USING ( SELECT
		CONVERT(DATE,[ValuationDate]) AS [ValuationDate]
      ,CONVERT(DATE,[PriorDate]) AS [PriorDate]
      ,CONVERT(BIGINT,[Account]) AS [Account]
      ,[Class]
      ,[Series]
      ,[Name]
      ,[SEDOL]
      ,CONVERT(CHAR(3),[Currency]) AS [Currency]
      ,CONVERT(DECIMAL(18,6),[Units]) AS [Units]
      ,CONVERT(DECIMAL(18,2),[NetAssets]) AS [NetAssets]
      ,CONVERT(DECIMAL(18,2),[PriorNetAssets]) AS [PriorNetAssets]
      ,CONVERT(FLOAT,[NAVperUnit]) AS [NAVperUnit]
      ,CONVERT(FLOAT,[PriorNAVperUnit]) AS [PriorNAVperUnit]
      ,CONVERT(FLOAT,[NAVChange]) AS [NAVChange]
      ,CONVERT(FLOAT,[BidSpread]) AS [BidSpread]
      ,CONVERT(FLOAT,[BidPrice]) AS [BidPrice]
      ,CONVERT(FLOAT,[OfferSpread]) AS [OfferSpread]
      ,CONVERT(FLOAT,[OfferPrice]) AS [OfferPrice]
      ,CONVERT(FLOAT,[IndexChange]) AS [IndexChange]
      ,[Filename]
	FROM [Staging.NT].[FeederFundPrice]
			) as Src
	ON ( Tar.[ValuationDate] = Src.[ValuationDate]
	AND Tar.[Account] = Src.[Account]
	 AND tar.[Class] = Src.[Class]
		)
	WHEN NOT MATCHED THEN
		INSERT ([ValuationDate]
      ,[PriorDate]
      ,[Account]
      ,[Class]
      ,[Series]
      ,[Name]
      ,[SEDOL]
      ,[Currency]
      ,[Units]
      ,[NetAssets]
      ,[PriorNetAssets]
      ,[NAVperUnit]
      ,[PriorNAVperUnit]
      ,[NAVChange]
      ,[BidSpread]
      ,[BidPrice]
      ,[OfferSpread]
      ,[OfferPrice]
      ,[IndexChange]
      ,[Filename])
			VALUES (
			Src.[ValuationDate]
      ,Src.[PriorDate]
      ,Src.[Account]
      ,Src.[Class]
      ,Src.[Series]
      ,Src.[Name]
      ,Src.[SEDOL]
      ,Src.[Currency]
      ,Src.[Units]
      ,Src.[NetAssets]
      ,Src.[PriorNetAssets]
      ,Src.[NAVperUnit]
      ,Src.[PriorNAVperUnit]
      ,Src.[NAVChange]
      ,Src.[BidSpread]
      ,Src.[BidPrice]
      ,Src.[OfferSpread]
      ,Src.[OfferPrice]
      ,Src.[IndexChange]
      ,Src.[Filename])
 WHEN MATCHED AND (
 ISNULL(tar.[PriorDate],'01 Jan 2199') <> ISNULL(src.[PriorDate],'01 Jan 2199') OR
   tar.[Series] <> src.[Series] OR
   tar.[Name] <> src.[Name] OR
    ISNULL(tar.[SEDOL], 'ABCDE') <> ISNULL(src.[SEDOL], 'ABCDE')  OR
    ISNULL(tar.[Currency], 'ABC') <> ISNULL(src.[Currency], 'ABC') OR
    tar.[Units] <> src.[Units] OR
 tar.[NetAssets] <> src.[NetAssets] OR
ISNULL(tar.[PriorNetAssets],-9999.00) <> ISNULL(src.[PriorNetAssets],-9999.00) OR
ISNULL(tar.[NAVperUnit],-9999.00) <> ISNULL(src.[NAVperUnit],-9999.00) OR
ISNULL(tar.[PriorNAVperUnit],-9999.00)  <> ISNULL(src.[PriorNAVperUnit],-9999.00)  OR
ISNULL(tar.[NAVChange],-9999.00)  <> ISNULL(src.[NAVChange],-9999.00)  OR
ISNULL(tar.[BidSpread],-9999.00)  <> ISNULL(src.[BidSpread],-9999.00)  OR
ISNULL(tar.[BidPrice],-9999.00)  <> ISNULL(src.[BidPrice],-9999.00)  OR
ISNULL(tar.[OfferSpread],-9999.00)  <> ISNULL(src.[OfferSpread],-9999.00)  OR
ISNULL(tar.[OfferPrice],-9999.00)  <> ISNULL(src.[OfferPrice],-9999.00)  OR
ISNULL(tar.[IndexChange],-9999.00)  <> ISNULL(src.[IndexChange], -9999.00) OR
tar.[Filename] <> src.[Filename]
 ) THEN 
 UPDATE 
	SET PriorDate = src.PriorDate
      ,Series = src.Series
      ,Name = src.Name
      ,SEDOL = src.SEDOL
      ,Currency = src.Currency
      ,Units = src.Units
      ,NetAssets = src.NetAssets
      ,PriorNetAssets = src.PriorNetAssets
      ,NAVperUnit = src.NAVperUnit
      ,PriorNAVperUnit = src.PriorNAVperUnit
      ,NAVChange = src.NAVChange
      ,BidSpread = src.BidSpread
      ,BidPrice = src.BidPrice
      ,OfferSpread = src.OfferSpread
      ,OfferPrice = src.OfferPrice
      ,IndexChange = src.IndexChange
      ,Filename = src.Filename
	  ,CADIS_SYSTEM_LASTMODIFIED = GETDATE()
	;
RETURN 0

