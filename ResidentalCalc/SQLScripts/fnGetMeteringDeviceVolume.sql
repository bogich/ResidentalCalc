USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnGetMeteringDeviceVolume]    Script Date: 09.08.2018 17:01:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetMeteringDeviceVolume]
(
	-- Add the parameters for the function here
	@MeteringDeviceGUID uniqueidentifier,
	@Month int,
	@Year int
)
RETURNS decimal(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @MeteringDeviceVolume decimal(18,2)
	DECLARE @CurReading decimal(18,2)
	DECLARE @PrevReading decimal(18,2)
	DECLARE @CalculationDate date
	
	-- Add the T-SQL statements to compute the return value here
	
	SET @CalculationDate = CAST(CONCAT(@Year, '-', @Month,'-1') AS date)
	
	SET @CurReading =
	(SELECT
	MeteringDeviceValue
	FROM
	MeteringDeviceHistory
	WHERE
	MeteringDeviceGUID = @MeteringDeviceGUID
	AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(@CalculationDate, 'yyyy-MM')
	AND MeteringDeviceDate = (SELECT MAX(MeteringDeviceDate)
								FROM MeteringDeviceHistory
								WHERE MeteringDeviceGUID = @MeteringDeviceGUID
								AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(@CalculationDate, 'yyyy-MM')))
	
	SET @PrevReading =
	(SELECT
	MeteringDeviceValue
	FROM
	MeteringDeviceHistory
	WHERE
	MeteringDeviceGUID = @MeteringDeviceGUID
	AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM')
	AND MeteringDeviceDate = (SELECT MAX(MeteringDeviceDate)
								FROM MeteringDeviceHistory
								WHERE MeteringDeviceGUID = @MeteringDeviceGUID
								AND FORMAT(MeteringDeviceDate, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -1, @CalculationDate), 'yyyy-MM')))
	
	SELECT @MeteringDeviceVolume = @CurReading - @PrevReading

	-- Return the result of the function
	RETURN @MeteringDeviceVolume

END
GO


