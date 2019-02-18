CREATE VIEW [Access.ManyWho].[NewPolicyThemeRegisterReadOnlyVw]
	AS 
	SELECT ptr.PolicyThemeRegisterId, ptr.PTPCategoryId, ptpc.PTPCategoryBK
			, ptp.PolicyThemeProcedureNameBK AS PolicyThemeNameBK, sod.SignOffDate as SignOffDate
			, ptprr.RoleId as PolicyThemeOwnerRoleId, r.RoleName AS PolicyThemeOwnerRoleName
			, ISNULL( rp.PersonId, -1) as CurrentAssignedOwnerPersonId, ISNULL( rp.EmployeeBK, 'UNKNOWN') as CurrentAssignedOwnerSalesforceUserId
			, ISNULL( rp.PersonsName, 'UNKNOWN') as CurrentAssignedOwnerPersonsName
			, ptr.PolicyThemeVersionNo, ptr.PolicyThemeExpiryDate, ptr.PolicyThemeDocumentStatus, ptr.ActiveFlag
			, ptr.ChangeStatus, ptr.ChangeReason, ptr.PolicyThemeSummary
			, ptrf.ReviewFrequencyName
			, ptr.DocumentationFolderLink
			, ptr.WorkflowVersionGUID, ptr.JoinGUID
			, ptr.PolicyThemeCreationDatetime, ptr.PolicyThemeLastModifiedDatetime
	FROM [Organisation].[PolicyThemeRegister] ptr
	    INNER JOIN [Organisation].[PolicyThemeReviewFrequencies] ptrf
		    ON ptr.PolicyThemeReviewFrequencyId = ptrf.PolicyThemeReviewFrequencyId
		INNER JOIN Organisation.PolicyThemeProcedureCategories ptpc
			ON ptr.PTPCategoryId = ptpc.PTPCategoryId
		INNER JOIN [Organisation].[PolicyThemeProcedures] ptp
			ON ptr.[PolicyThemeRegisterId] = ptp.[PolicyThemeRegisterId]
			AND ptpc.PTPCategoryId = ptp.PTPCategoryId
			AND ptpc.PTPRegisterLevel = 1 --True
			AND ptp.ActiveFlag = 1 --True
		INNER JOIN [Organisation].[PolicyThemeProcedureRoleRelationship] ptprr
			ON ptp.PolicyThemeProcedureId = ptprr.PolicyThemeProcedureId
			AND ptprr.PolicyThemeProcedureOwner = 1 --True
		INNER JOIN [Core].[Roles] r
			ON ptprr.RoleId = r.RoleId
			AND r.ActiveFlag = 1
			LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
				ON r.RoleId = rpr.RoleId
				AND rpr.ActiveFlag = 1
				INNER JOIN [Core].[Persons] rp
					ON rpr.PersonId = rp.PersonId
					AND rp.ActiveFlag = 1
		LEFT OUTER JOIN ( SELECT pte.PolicyThemeRegisterId, Cast( MAX(pte.[PolicyThemeEventCreationDatetime]) as Date) as SignOffDate
							FROM Organisation.PolicyThemeEvents pte
								INNER JOIN Organisation.PolicyThemeEventTypes et
									ON pte.PolicyThemeEventTypeId = et.PolicyThemeEventTypeId
							WHERE et.PolicyThemeEventTypeBK = 'ReviewSignedOff'
							GROUP BY pte.PolicyThemeRegisterId) sod
			ON ptr.PolicyThemeRegisterId = sod.PolicyThemeRegisterId
	;
