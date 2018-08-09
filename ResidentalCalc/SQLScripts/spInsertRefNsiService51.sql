USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertRefNsiService51]    Script Date: 09.08.2018 16:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertRefNsiService51]
	-- Add the parameters for the stored procedure here
	@Code nvarchar(20),
    @GUID uniqueidentifier,
    @IsActual bit,
    @Value nvarchar(50),
	@GIS_Modified date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[RefNsiService51]
           ([Code]
           ,[GUID]
           ,[IsActual]
           ,[Value]
		   ,[GIS_Modified])
     VALUES
           (@Code
           ,@GUID
           ,@IsActual
           ,@Value
		   ,@GIS_Modified)
END
GO


