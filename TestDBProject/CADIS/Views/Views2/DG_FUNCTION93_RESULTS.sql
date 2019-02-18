CREATE VIEW "CADIS"."DG_FUNCTION93_RESULTS" AS 
SELECT ET."RFPEventId",ET."RFPId",ET."EventTypeId",ET."SubmittedByPersonId",ET."ReviewedById",ET."EventDetails",ET."EventDate",ET."ReviewComments",ET."EventTrueFalse",ET."DepartmentId",ET."JiraSubTaskKey",ET."DocumentationFolderLink",ET."JoinGUID",ET."RFPEventCreationDate",ET."RFPEventLastModifiedDatetime" FROM "Sales"."RFPEvents" ET WITH (NOLOCK)
