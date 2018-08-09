USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertObjectAddress]    Script Date: 09.08.2018 16:59:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertObjectAddress]
	-- Add the parameters for the stored procedure here
	@SupplyResourceContractGUID uniqueidentifier,
    @FIASHouseGUID uniqueidentifier,
    @Apartment nvarchar(5),
    @LivingRoom nvarchar(5),
    @GIS_ObjectGUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ObjectAddress]
           ([SupplyResourceContractGUID]
           ,[FIASHouseGUID]
           ,[Apartment]
           ,[LivingRoom]
           ,[GIS_ObjectGUID])
     VALUES
           (@SupplyResourceContractGUID
           ,@FIASHouseGUID
           ,@Apartment
           ,@LivingRoom
           ,@GIS_ObjectGUID)
END
GO


