

CREATE VIEW [Access.ManyWho].[ControlLogFrequencyVw]
	AS SELECT [ControlLogFrequencyId],
			  [FrequencyName]
	 FROM [Audit].[ControlLogFrequency]
	 ;
