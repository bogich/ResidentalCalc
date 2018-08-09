USE [ResidentalData]
GO

/****** Object:  UserDefinedFunction [dbo].[fnIsMeteringDevice]    Script Date: 09.08.2018 17:01:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnIsMeteringDevice]
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
	DECLARE @MeteringDeviceVolume decimal(18,2)
	DECLARE @DeviceMeteringNextVerificationDate date
	DECLARE @MeteringDeviceReadingDate date

	-- Add the T-SQL statements to compute the return value here
	SET @MeteringDeviceVolume = dbo.fnGetMeteringDeviceVolume(@MeteringDeviceGUID, @CalculationMonth, @CalculationYear)
	SET @DeviceMeteringNextVerificationDate = (SELECT DATEADD(YEAR, VerificationInterval, VerificationDate)
												FROM MeteringDevice
												WHERE GUID = @MeteringDeviceGUID)
	SET @MeteringDeviceReadingDate = (SELECT MAX(MeteringDeviceDate)
											FROM MeteringDeviceHistory
											WHERE MeteringDeviceGUID = @MeteringDeviceGUID
											AND MONTH(MeteringDeviceDate) = @CalculationMonth
											AND YEAR(MeteringDeviceDate) = @CalculationYear)
	
	IF (@MeteringDeviceVolume IS NOT NULL)AND(@DeviceMeteringNextVerificationDate > @MeteringDeviceReadingDate)
		SELECT @Result = @MeteringDeviceVolume
	ELSE
		SELECT @Result = NULL

	-- Return the result of the function
	RETURN @Result

END
GO


