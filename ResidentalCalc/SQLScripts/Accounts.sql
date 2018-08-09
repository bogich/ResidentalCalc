USE [ResidentalData]
GO

/****** Object:  Table [dbo].[Accounts]    Script Date: 09.08.2018 16:50:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Accounts](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ObjectAddressGUID] [uniqueidentifier] NOT NULL,
	[AccountNumber] [nvarchar](30) NOT NULL,
	[AccountState] [bit] NOT NULL,
	[LivingPersonsNumber] [int] NOT NULL,
	[GIS_AccountGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_ObjectAddress] FOREIGN KEY([ObjectAddressGUID])
REFERENCES [dbo].[ObjectAddress] ([GUID])
GO

ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_ObjectAddress]
GO


