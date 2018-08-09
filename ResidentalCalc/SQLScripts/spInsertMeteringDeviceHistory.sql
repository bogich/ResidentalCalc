USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertMeteringDeviceHistory]    Script Date: 09.08.2018 16:59:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertMeteringDeviceHistory]
	-- Add the parameters for the stored procedure here
	@MeteringDeviceGUID uniqueidentifier,
    @MeteringDeviceValue decimal(18,2),
    @MeteringDeviceDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[MeteringDeviceHistory]
           ([MeteringDeviceGUID]
           ,[MeteringDeviceValue]
           ,[MeteringDeviceDate])
     VALUES
           (@MeteringDeviceGUID
           ,@MeteringDeviceValue
           ,@MeteringDeviceDate)
END
GO


