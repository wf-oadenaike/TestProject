CREATE VIEW "CADIS"."DG_FUNCTION412_RESULTS" AS 
SELECT ET."ICAAPChangeId",ET."ICAAPRegisterId",ET."ChangeAmount",ET."PercentageChange",ET."ICAAPChangeDueTo",ET."ICAAPAmendmentDate",ET."ICAAPChangeStatus",ET."AmendedByPersonId",ET."DocumentationFolderLink",ET."JoinGUID",ET."ICAAPChangeCreationDatetime",ET."ICAAPChangeLastModifiedDatetime" FROM "Investment"."ICAAPChanges" ET WITH (NOLOCK)
