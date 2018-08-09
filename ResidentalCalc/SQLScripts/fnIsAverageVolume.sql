USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnIsAverageVolume]    Script Date: 09.08.2018 17:01:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnIsAverageVolume]
(
	-- Add the parameters for the function here
	@MeteringDeviceGUID uniqueidentifier,
	@CalculationMonth int,
	@CalculationYear int
)
RETURNS decimal(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result decimal(18,2)
	DECLARE @ReadingOneMonthAgo int
	DECLARE @ReadingTwoMonthAgo int
	DECLARE @ReadingThreeMonthAgo int
	DECLARE @MinReading decimal(18,2)
	DECLARE @MaxReading decimal(18,2)
	DECLARE @CountReading int
	DECLARE @CalculationDate date = CONCAT('01-', @CalculationMonth, '-', @CalculationYear)

	-- Add the T-SQL statements to compute the return value here
	SET @ReadingOneMonthAgo =
					(SELECT COUNT(*)
					FROM MeteringDeviceHistory
					WHERE MeteringDeviceGUID = @MeteringDeviceGUID
					AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM'))

	SET @ReadingTwoMonthAgo =
					(SELECT COUNT(*)
					FROM MeteringDeviceHistory
					WHERE MeteringDeviceGUID = @MeteringDeviceGUID
					AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -2, @CalculationDate), 'yyyy-MM'))
	
	SET @ReadingThreeMonthAgo =
					(SELECT COUNT(*)
					FROM MeteringDeviceHistory
					WHERE MeteringDeviceGUID = @MeteringDeviceGUID
					AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -3, @CalculationDate), 'yyyy-MM'))
	
	IF (@ReadingOneMonthAgo > 0)AND(@ReadingTwoMonthAgo > 0)AND(@ReadingThreeMonthAgo > 0)
		BEGIN
			SET @MinReading = 
						(SELECT MIN(MeteringDeviceValue)
						FROM MeteringDeviceHistory
						WHERE MeteringDeviceGUID = @MeteringDeviceGUID
						AND FORMAT(MeteringDeviceDate, 'yyyy-MM') BETWEEN FORMAT(DATEADD(MONTH, -6, @CalculationDate), 'yyyy-MM') AND FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM'))
			SET @MaxReading =
						(SELECT MAX(MeteringDeviceValue)
						FROM MeteringDeviceHistory
						WHERE MeteringDeviceGUID = @MeteringDeviceGUID
						AND FORMAT(MeteringDeviceDate, 'yyyy-MM') BETWEEN FORMAT(DATEADD(MONTH, -6, @CalculationDate), 'yyyy-MM') AND FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM'))
			SET @CountReading =
						(SELECT COUNT(DISTINCT FORMAT(MeteringDeviceDate, 'yyyy-MM'))
						FROM MeteringDeviceHistory
						WHERE MeteringDeviceGUID = @MeteringDeviceGUID
						AND FORMAT(MeteringDeviceDate, 'yyyy-MM') BETWEEN FORMAT(DATEADD(MONTH, -6, @CalculationDate), 'yyyy-MM') AND FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM'))

			SELECT @Result = (@MaxReading - @MinReading) / @CountReading
		END
	ELSE
		BEGIN
			SELECT @Result = NULL
		END

	-- Return the result of the function
	RETURN @Result

END
GO


