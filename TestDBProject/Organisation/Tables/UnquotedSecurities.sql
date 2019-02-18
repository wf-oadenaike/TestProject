CREATE TABLE [Organisation].[UnquotedSecurities] (
    [UnquotedSecuritiesId]                     INT              IDENTITY (1, 1) NOT NULL,
    [UnquotedCompanyId]                        INT              NOT NULL,
    [CurrencyCode]                             CHAR (3)         NOT NULL,
    [AssetType]                                VARCHAR (128)    NULL,
    [StockName]                                NVARCHAR (256)   NOT NULL,
    [ShareClass]                               NVARCHAR (256)   NULL,
    [Tranche]                                  SMALLINT         DEFAULT ((1)) NOT NULL,
    [BrokerSalesforceId]                       VARCHAR (18)     NULL,
    [EstimatedPrice]                           DECIMAL (18, 6)  NULL,
    [EstimatedPriceDate]                       DATE             NULL,
    [InitialPrice]                             DECIMAL (18, 6)  NULL,
    [InitialPriceDate]                         DATE             NULL,
    [LatestPrice]                              DECIMAL (18, 6)  NULL,
    [LatestPriceDate]                          DATE             NULL,
    [ClosingDate]                              DATE             NULL,
    [CountryOfRisk]                            VARCHAR (256)    NULL,
    [CountryOfIncorporation]                   VARCHAR (256)    NULL,
    [Bible]                                    BIT              CONSTRAINT [DF_US_B] DEFAULT ((0)) NOT NULL,
    [BBGSetup]                                 BIT              CONSTRAINT [DF_US_BBGS] DEFAULT ((0)) NOT NULL,
    [Ticker]                                   VARCHAR (128)    NULL,
    [BBGID]                                    CHAR (12)        NULL,
    [BBGSecurityId]                            CHAR (7)         NULL,
    [BBGCompanyId]                             CHAR (7)         NULL,
    [NTSent]                                   BIT              CONSTRAINT [DF_US_NTS] DEFAULT ((0)) NOT NULL,
    [BBGUniqueId/FOID]                         VARCHAR (128)    NULL,
    [CustodianId]                              VARCHAR (64)     NULL,
    [Notes]                                    NVARCHAR (2000)  NULL,
    [WorkflowVersionGUID]                      UNIQUEIDENTIFIER NULL,
    [JoinGUID]                                 UNIQUEIDENTIFIER NOT NULL,
    [UnquotedSecuritiesCreationDate]           DATETIME         CONSTRAINT [DF_US_USCD] DEFAULT (getdate()) NOT NULL,
    [UnquotedSecuritiesCreatedByPersonId]      SMALLINT         NOT NULL,
    [UnquotedSecuritiesLastModifiedDate]       DATETIME         CONSTRAINT [DF_US_USLMD] DEFAULT (getdate()) NOT NULL,
    [UnquotedSecuritiesLastModifiedByPersonId] SMALLINT         NOT NULL,
    [CADIS_SYSTEM_INSERTED]                    DATETIME         CONSTRAINT [DF_US_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                     DATETIME         CONSTRAINT [DF_US_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                   NVARCHAR (50)    CONSTRAINT [DF_US_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                    INT              CONSTRAINT [DF_US_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                   ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                DATETIME         CONSTRAINT [DF_US_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedSecurities] PRIMARY KEY CLUSTERED ([UnquotedSecuritiesId] ASC),
    CONSTRAINT [UnquotedSecuritiesUnquotedCompanyId] FOREIGN KEY ([UnquotedCompanyId]) REFERENCES [Organisation].[UnquotedCompanies] ([UnquotedCompanyId])
);


GO
CREATE TRIGGER [Organisation].[UnquotedSecuritesTri]
ON [Organisation].[UnquotedSecurities]
FOR INSERT, UPDATE, DELETE
AS
BEGIN 
	DECLARE @Action as char(1);
    SET @Action = (
		CASE 
			WHEN EXISTS(SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
				THEN 'U'  -- Set to Updated.
			WHEN EXISTS(SELECT * FROM INSERTED)
				THEN 'I'  -- Set to Insert.
			WHEN EXISTS(SELECT * FROM DELETED)
				THEN 'D'  -- Set to Deleted.
			ELSE NULL -- Skip. It may have been a "failed delete".   
		END)
		
		IF @Action = 'I' OR @Action = 'U' 
				BEGIN 
					INSERT INTO [Organisation].[UnquotedSecuritiesAudit]
					   ([UnquotedSecuritiesAuditAction]
					   ,[UnquotedSecuritiesId]
					   ,[UnquotedCompanyId]
					   ,[CurrencyCode]
					   ,[AssetType]
					   ,[StockName]
					   ,[ShareClass]
					   ,[Tranche]
					   ,[BrokerSalesforceId]
					   ,[EstimatedPrice]
					   ,[EstimatedPriceDate]
					   ,[InitialPrice]
					   ,[InitialPriceDate]
					   ,[LatestPrice]
					   ,[LatestPriceDate]
					   ,[ClosingDate]
					   ,[CountryOfRisk]
					   ,[CountryOfIncorporation]
					   ,[BBGSetup]
					   ,[Ticker]
					   ,[BBGID]
					   ,[BBGSecurityId]
					   ,[BBGCompanyId]
					   ,[NTSent]
					   ,[BBGUniqueId/FOID]
					   ,[CustodianId]
					   ,[Notes]
					   ,[WorkflowVersionGUID]
					   ,[JoinGUID]
					   ,[UnquotedSecuritiesCreationDate]
					   ,[UnquotedSecuritiesCreatedByPersonId]
					   ,[UnquotedSecuritiesLastModifiedDate]
					   ,[UnquotedSecuritiesLastModifiedByPersonId])
				SELECT
				   @Action
				   ,UnquotedSecuritiesId
				   ,UnquotedCompanyId
				   ,CurrencyCode
				   ,AssetType
				   ,StockName
				   ,ShareClass
				   ,[Tranche]
				   ,BrokerSalesforceId
				   ,EstimatedPrice
				   ,EstimatedPriceDate
				   ,InitialPrice
				   ,InitialPriceDate
				   ,LatestPrice
				   ,LatestPriceDate
				   ,ClosingDate
				   ,CountryOfRisk
				   ,CountryOfIncorporation
				   ,BBGSetup
				   ,Ticker
				   ,BBGID
				   ,BBGSecurityId
				   ,BBGCompanyId
				   ,NTSent
				   ,[BBGUniqueId/FOID]
				   ,CustodianId
				   ,Notes
				   ,WorkflowVersionGUID
				   ,JoinGUID
				   ,UnquotedSecuritiesCreationDate
				   ,UnquotedSecuritiesCreatedByPersonId
				   ,UnquotedSecuritiesLastModifiedDate
				   ,UnquotedSecuritiesLastModifiedByPersonId
				   FROM INSERTED
				END
			ELSE IF @Action = 'D'
				BEGIN 
					INSERT INTO [Organisation].[UnquotedSecuritiesAudit]
					   ([UnquotedSecuritiesAuditAction]
					   ,[UnquotedSecuritiesId]
					   ,[UnquotedCompanyId]
					   ,[CurrencyCode]
					   ,[AssetType]
					   ,[StockName]
					   ,[ShareClass]
					   ,[Tranche]
					   ,[BrokerSalesforceId]
					   ,[EstimatedPrice]
					   ,[EstimatedPriceDate]
					   ,[InitialPrice]
					   ,[InitialPriceDate]
					   ,[LatestPrice]
					   ,[LatestPriceDate]
					   ,[ClosingDate]
					   ,[CountryOfRisk]
					   ,[CountryOfIncorporation]
					   ,[BBGSetup]
					   ,[Ticker]
					   ,[BBGID]
					   ,[BBGSecurityId]
					   ,[BBGCompanyId]
					   ,[NTSent]
					   ,[BBGUniqueId/FOID]
					   ,[CustodianId]
					   ,[Notes]
					   ,[WorkflowVersionGUID]
					   ,[JoinGUID]
					   ,[UnquotedSecuritiesCreationDate]
					   ,[UnquotedSecuritiesCreatedByPersonId]
					   ,[UnquotedSecuritiesLastModifiedDate]
					   ,[UnquotedSecuritiesLastModifiedByPersonId])
				SELECT
				   @Action
				   ,UnquotedSecuritiesId
				   ,UnquotedCompanyId
				   ,CurrencyCode
				   ,AssetType
				   ,StockName
				   ,ShareClass
				   ,Tranche
				   ,BrokerSalesforceId
				   ,EstimatedPrice
				   ,EstimatedPriceDate
				   ,InitialPrice
				   ,InitialPriceDate
				   ,LatestPrice
				   ,LatestPriceDate
				   ,ClosingDate
				   ,CountryOfRisk
				   ,CountryOfIncorporation
				   ,BBGSetup
				   ,Ticker
				   ,BBGID
				   ,BBGSecurityId
				   ,BBGCompanyId
				   ,NTSent
				   ,[BBGUniqueId/FOID]
				   ,CustodianId
				   ,Notes
				   ,WorkflowVersionGUID
				   ,JoinGUID
				   ,UnquotedSecuritiesCreationDate
				   ,UnquotedSecuritiesCreatedByPersonId
				   ,UnquotedSecuritiesLastModifiedDate
				   ,UnquotedSecuritiesLastModifiedByPersonId
				FROM DELETED
			END --IF
END
