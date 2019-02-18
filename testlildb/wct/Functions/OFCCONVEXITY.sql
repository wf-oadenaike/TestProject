﻿CREATE FUNCTION [wct].[OFCCONVEXITY]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @IssueDate DATETIME NULL, @FirstCouponDate DATETIME NULL, @Rate FLOAT (53) NULL, @Yld FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OFCCONVEXITY]

