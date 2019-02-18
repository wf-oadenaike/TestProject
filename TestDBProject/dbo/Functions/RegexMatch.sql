CREATE FUNCTION [dbo].[RegexMatch]
(@input NVARCHAR (MAX), @pattern NVARCHAR (MAX))
RETURNS BIT
AS
 EXTERNAL NAME [Wim.Database.Functions].[GalaRegExCLR].[RegexMatch]

