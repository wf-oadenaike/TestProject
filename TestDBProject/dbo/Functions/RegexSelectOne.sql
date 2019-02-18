CREATE FUNCTION [dbo].[RegexSelectOne]
(@input NVARCHAR (MAX), @pattern NVARCHAR (MAX), @matchIndex INT)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [Wim.Database.Functions].[GalaRegExCLR].[RegexSelectOne]

