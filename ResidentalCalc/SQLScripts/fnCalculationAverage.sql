USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnCalculationAverage]    Script Date: 09.08.2018 17:00:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCalculationAverage]
(
	-- Add the parameters for the function here
	@IsAverageVolume decimal(18,2),
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
	DECLARE @CalculationVolume decimal(18,2)
	DECLARE @CalculationTariff decimal(18,2)
	DECLARE @CalculationResult decimal(18,2)
	
	SET @CalculationTariff = dbo.fnGetContractSubjectTariff(@ContractSubjectGUID)
	SET @CalculationResult = @IsAverageVolume * @CalculationTariff
	
	INSERT @ret
	SELECT @IsAverageVolume, @CalculationTariff, @CalculationResult

	RETURN 
END
GO


