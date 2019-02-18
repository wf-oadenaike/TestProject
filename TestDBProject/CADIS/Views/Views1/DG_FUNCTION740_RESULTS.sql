CREATE VIEW "CADIS"."DG_FUNCTION740_RESULTS" AS 
SELECT ET."Id",ET."Frequency",ET."FrequencyDayMin",ET."FrequencyDayMax",ET."FrequencyStartMin",ET."FrequencyStartMax" FROM "dbo"."CircleProcessScheduledTaskFrequencies" ET WITH (NOLOCK)
