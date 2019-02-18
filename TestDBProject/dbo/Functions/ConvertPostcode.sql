CREATE FUNCTION [dbo].[ConvertPostcode]
(@PostCode NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [Wim.Database.Functions].[GalaCLR].[ConvertPostcode]

