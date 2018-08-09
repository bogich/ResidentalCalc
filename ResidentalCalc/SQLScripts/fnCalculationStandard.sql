USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnCalculationStandard]    Script Date: 09.08.2018 17:00:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCalculationStandard]
(
	-- Add the parameters for the function here
	@AccountGUID uniqueidentifier,
	@ContractSubjectGUID uniqueidentifier
)
RETURNS 
@ret TABLE
(
	-- Add the column definitions for the TABLE variable here
	Volume decimal(18,2),
	Tariff decimal(18,2),
	Result decimal(18,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	DECLARE @Result decimal(18,2)
	DECLARE @CalculationTariff decimal(18,2)
	DECLARE @CalculationStandard decimal(18,2)
	DECLARE @LivingPersonsNumber int
	DECLARE @Volume decimal(18,2)

	SET @CalculationTariff = dbo.fnGetContractSubjectTariff(@ContractSubjectGUID)
	SET @CalculationStandard = dbo.fnGetContractSubjectStandard(@ContractSubjectGUID)
	SET @LivingPersonsNumber = dbo.fnGetAccountLivingPersonsNumber(@AccountGUID)
	SET @Volume = @CalculationStandard * @LivingPersonsNumber
	SET @Result = @Volume * @CalculationTariff

	INSERT @ret
	SELECT @Volume, @CalculationStandard, @Result

	RETURN 
END
GO


