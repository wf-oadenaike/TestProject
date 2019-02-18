CREATE FUNCTION [dbo].[RegexReplace]
(@expression NVARCHAR (MAX), @pattern NVARCHAR (MAX), @replace NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [Wim.Database.Functions].[GalaRegExCLR].[RegexReplace]

