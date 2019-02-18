CREATE VIEW [Access.ManyWho].[ThirdPartiesVw]
	AS 
	SELECT t.[ThirdPartyId],
	       t.[ThirdPartyName],
	       t.[ActiveFlag],
	       t.[ControlId],
	       t.[SourceSystemId],
	      ss.[SourceSystemName],
		   t.[DisplayOrder]
	FROM [Core].[ThirdParties] t
		INNER JOIN Audit.SourceSystemsVw ss
		ON t.SourceSystemId = ss.SourceSystemId
