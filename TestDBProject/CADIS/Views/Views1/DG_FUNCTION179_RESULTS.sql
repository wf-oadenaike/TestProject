CREATE VIEW "CADIS"."DG_FUNCTION179_RESULTS" AS 
SELECT ET."SubCategoryId",ET."RiskOwnerId",ET."RiskSubCategory",ET."RiskCategoryId",ET."RiskOwner",ET."RiskAppetite" FROM "Access.ManyWho"."RiskSubCategoriesVw" ET WITH (NOLOCK)
