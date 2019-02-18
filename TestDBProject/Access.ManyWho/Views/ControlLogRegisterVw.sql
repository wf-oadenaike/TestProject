

CREATE VIEW [Access.ManyWho].[ControlLogRegisterVw]
	AS SELECT clr.ControlLogRegisterId,
	clr.ControlDescription,
	clr.ControlLogCategoryId,
	clr.ControlLogFrequencyId,
	clr.AdhocFrequencyYesNo,
	clr.EvidenceDescription,
	clr.OwnerRoleId,
	clr.OwnerThirdPartyId,
	clr.JoinGUID,
	clr.ControlLogRegisterCreationDatetime,
	clr.ControlLogRegisterLastModifiedDatetime
	 FROM [Audit].[ControlLogRegister] clr
	 	
	 ;
