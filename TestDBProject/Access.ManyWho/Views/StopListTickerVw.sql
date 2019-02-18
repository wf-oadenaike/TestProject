
CREATE VIEW [Access.ManyWho].[StopListTickerVw]
	AS
	Select 
	[PARSEKEYABLE_DESCRIPTION] as TICKER,
	[SECURITY_NAME]
	from [dbo].[T_MASTER_SEC]
	Union
	Select 
	TICKER,
	[SECURITY_NAME] 
	from [dbo].[T_REF_STOCK_TICKER]

