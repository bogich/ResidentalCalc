USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spInsertPayerInfo]    Script Date: 09.08.2018 16:59:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertPayerInfo]
	-- Add the parameters for the stored procedure here
	@AccountGUID uniqueidentifier,
    @Surname nvarchar(50),
    @Name nvarchar(50),
    @GrandName nvarchar(50),
    @SNILS nvarchar(11),
    @Series nvarchar(10),
    @Number nvarchar(10),
    @IssueDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[PayerInfo]
           ([AccountGUID]
           ,[Surname]
           ,[Name]
           ,[GrandName]
           ,[SNILS]
           ,[Series]
           ,[Number]
           ,[IssueDate])
     VALUES
           (@AccountGUID
           ,@Surname
           ,@Name
           ,@GrandName
           ,@SNILS
           ,@Series
           ,@Number
           ,@IssueDate)
END
GO


