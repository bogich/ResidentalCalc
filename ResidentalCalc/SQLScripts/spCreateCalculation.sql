USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spCreateCalculation]    Script Date: 09.08.2018 16:55:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCreateCalculation]
	-- Add the parameters for the stored procedure here
	@AccountGUID uniqueidentifier,
	@CalculationMonth int,
	@CalculationYear int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @RowGUID uniqueidentifier
	SET @RowGUID = NEWID()

	INSERT INTO [dbo].[Calculation]
           ([GUID]
		   ,[AccountGUID]
           ,[CalculationMonth]
           ,[CalculationYear])
     VALUES
           (@RowGUID
		   ,@AccountGUID
           ,@CalculationMonth
           ,@CalculationYear)

	EXEC dbo.spCreateChargeInfo @RowGUID, @AccountGUID, @CalculationMonth, @CalculationYear

END
GO


