USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertAccount]    Script Date: 09.08.2018 16:55:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertAccount]
	-- Add the parameters for the stored procedure here
	@ObjectAddressGUID uniqueidentifier,
    @AccountNumber nvarchar(30),
    @AccountState bit,
    @LivingPersonsNumber int,
    @GIS_AccountGUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Accounts]
           ([ObjectAddressGUID]
           ,[AccountNumber]
           ,[AccountState]
           ,[LivingPersonsNumber]
           ,[GIS_AccountGUID])
     VALUES
           (@ObjectAddressGUID
           ,@AccountNumber
           ,@AccountState
           ,@LivingPersonsNumber
           ,@GIS_AccountGUID)
END
GO


