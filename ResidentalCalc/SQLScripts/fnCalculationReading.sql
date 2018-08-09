USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnCalculationReading]    Script Date: 09.08.2018 17:00:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCalculationReading]
(
	-- Add the parameters for the function here
	@IsMeteringDevice decimal(18,2),
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
	DECLARE @CalculationResult decimal(18,2)
	DECLARE @CalculationTariff decimal(18,2)

	SET @CalculationTariff = dbo.fnGetContractSubjectTariff(@ContractSubjectGUID)
	SET @CalculationResult = @IsMeteringDevice * @CalculationTariff

	INSERT @ret
	SELECT @IsMeteringDevice, @CalculationTariff, @CalculationResult

	RETURN 
END
GO


