USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnGetAccountLivingPersonsNumber]    Script Date: 09.08.2018 17:01:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetAccountLivingPersonsNumber]
(
	-- Add the parameters for the function here
	@AccountGUID uniqueidentifier
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = LivingPersonsNumber FROM Accounts WHERE GUID = @AccountGUID

	-- Return the result of the function
	RETURN @Result

END
GO


