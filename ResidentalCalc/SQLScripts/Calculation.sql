USE [ResidentalData]
GO

/****** Object:  Table [dbo].[Calculation]    Script Date: 09.08.2018 16:51:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Calculation](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AccountGUID] [uniqueidentifier] NOT NULL,
	[CalculationMonth] [int] NOT NULL,
	[CalculationYear] [int] NOT NULL,
	[GIS_PaymentDocumentNumber] [nvarchar](18) NULL,
 CONSTRAINT [PK_Calculations] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Calculation] ADD  CONSTRAINT [DF_Calculations_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[Calculation]  WITH CHECK ADD  CONSTRAINT [FK_Calculations_Accounts] FOREIGN KEY([AccountGUID])
REFERENCES [dbo].[Accounts] ([GUID])
GO

ALTER TABLE [dbo].[Calculation] CHECK CONSTRAINT [FK_Calculations_Accounts]
GO


