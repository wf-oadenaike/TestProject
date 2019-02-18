CREATE FUNCTION [dbo].[RegexSelectAll]
(@input NVARCHAR (MAX), @pattern NVARCHAR (MAX), @matchDelimiter NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [Wim.Database.Functions].[GalaRegExCLR].[RegexSelectAll]

