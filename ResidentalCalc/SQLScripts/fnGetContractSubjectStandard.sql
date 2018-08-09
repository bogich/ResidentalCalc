USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnGetContractSubjectStandard]    Script Date: 09.08.2018 17:00:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetContractSubjectStandard]
(
	-- Add the parameters for the function here
	@ContractSubjectGUID uniqueidentifier
)
RETURNS decimal(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result decimal(18,2)

	-- Add the T-SQL statements to compute the return value here
	SELECT
		@Result = StandardValue
	FROM 
		Accounts
		LEFT JOIN ObjectAddress ON Accounts.ObjectAddressGUID = ObjectAddress.GUID
		LEFT JOIN SupplyResourceContract ON ObjectAddress.SupplyResourceContractGUID = SupplyResourceContract.GUID
		LEFT JOIN ContractSubject ON SupplyResourceContract.GUID = ContractSubject.SupplyResourceContractGUID
		LEFT JOIN RefServices ON ContractSubject.ServiceGUID = RefServices.GUID
		LEFT JOIN RefStandard ON RefServices.StandardGUID = RefStandard.GUID
	WHERE
		ContractSubject.GUID = @ContractSubjectGUID

	-- Return the result of the function
	RETURN @Result

END
GO


