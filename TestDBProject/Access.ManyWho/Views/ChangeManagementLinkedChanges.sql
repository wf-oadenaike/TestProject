CREATE view [Access.ManyWho].[ChangeManagementLinkedChanges]
as
SELECT [LinkId]
      ,[ChangeId1]
	  ,cmr1.ChangeTitle as 'ChangeTitle1'
      ,[ChangeId2]
	  ,cmr2.ChangeTitle as 'ChangeTitle2'
	  ,l.isactive
      ,l.[JoinGUID]
      ,l.[CADIS_SYSTEM_INSERTED]
      ,l.[CADIS_SYSTEM_UPDATED]
      ,l.[CADIS_SYSTEM_CHANGEDBY]
      ,l.[CADIS_SYSTEM_PRIORITY]
      ,l.[CADIS_SYSTEM_TIMESTAMP]
      ,l.[CADIS_SYSTEM_LASTMODIFIED]
  FROM [ChangeManagement].[LinkedChanges] l
		join ChangeManagement.ChangeManagementRegister cmr1 on l.ChangeId1 = cmr1.ChangeID
		join ChangeManagement.ChangeManagementRegister cmr2 on l.ChangeId2 = cmr2.ChangeID
