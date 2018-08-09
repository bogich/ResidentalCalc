USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertSupplyResourceContract]    Script Date: 09.08.2018 16:59:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertSupplyResourceContract]
	-- Add the parameters for the stored procedure here
	@ContractNumber nvarchar(100),
	@SigningDateStart date,
	@SigningDateEnd date = '2079-01-01',
	@ContractState bit,
	@GIS_ContractRootGUID uniqueidentifier,
	@GIS_VersionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[SupplyResourceContract]
           ([ContractNumber]
           ,[SigningDateStart]
           ,[SigningDateEnd]
           ,[ContractState]
		   ,[GIS_ContractRootGUID]
		   ,[GIS_VersionNumber])
     VALUES
           (@ContractNumber
           ,@SigningDateStart
           ,@SigningDateEnd
           ,@ContractState
		   ,@GIS_ContractRootGUID
		   ,@GIS_VersionNumber)
END
GO


