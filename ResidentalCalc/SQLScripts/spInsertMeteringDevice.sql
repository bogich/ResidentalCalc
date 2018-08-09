USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertMeteringDevice]    Script Date: 09.08.2018 16:58:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertMeteringDevice]
	-- Add the parameters for the stored procedure here
	@ObjectAddressGUID uniqueidentifier,
    @MeteringDeviceModel nvarchar(100),
    @MeteringDeviceStamp nvarchar(100),
    @MeteringDeviceNumber nvarchar(50),
    @VerificationInterval int,
    @InstallationDate date,
    @VerificationDate date,
    @GIS_MeteringDeviceGUID uniqueidentifier,
	@GIS_VersionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[MeteringDevice]
           ([ObjectAddressGUID]
           ,[MeteringDeviceModel]
           ,[MeteringDeviceStamp]
           ,[MeteringDeviceNumber]
           ,[VerificationInterval]
           ,[InstallationDate]
           ,[VerificationDate]
           ,[GIS_MeteringDeviceGUID]
		   ,[GIS_VersionNumber])
     VALUES
           (@ObjectAddressGUID
           ,@MeteringDeviceModel
           ,@MeteringDeviceStamp
           ,@MeteringDeviceNumber
           ,@VerificationInterval
           ,@InstallationDate
           ,@VerificationDate
           ,@GIS_MeteringDeviceGUID
		   ,@GIS_VersionNumber)
END
GO


