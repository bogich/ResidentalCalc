USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertCalculationData]    Script Date: 09.08.2018 16:58:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertCalculationData]
	-- Add the parameters for the stored procedure here
	@RowGUID uniqueidentifier,
	@ContractSubjectGUID uniqueidentifier,
	@MeteringDeviceGUID uniqueidentifier,
	@CalculationResult decimal(18,2),
	@CalculationVolume decimal(18,2),
	@VolumeDeterminingMethod nvarchar(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN TRAN
		INSERT INTO dbo.ChargeInfo(CalculationGUID, ContractSubjectGUID, Volume, CalculationResult, VolumeDeterminingMethod, MeteringDeviceGUID)
			VALUES (@RowGUID, @ContractSubjectGUID, @CalculationVolume, @CalculationResult, @VolumeDeterminingMethod, @MeteringDeviceGUID)
	COMMIT TRAN
END
GO


