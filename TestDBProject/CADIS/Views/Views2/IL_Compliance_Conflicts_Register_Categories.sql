CREATE VIEW "CADIS"."IL_Compliance_Conflicts_Register_Categories" AS 
SELECT V."ConflictsRegisterCategoryId" AS "Conflicts Register Category ID",V."ConflictsRegisterCategory" AS "Conflicts Register Category",V."ConflictsRegisterCategoryDescription" AS "Conflicts Register Category Description",V."CreationDate" AS "Creation Date" FROM "Compliance"."ConflictsRegisterCategories" V
