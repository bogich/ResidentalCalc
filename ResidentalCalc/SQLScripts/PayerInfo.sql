USE [ResidentalData]
GO

/****** Object:  Table [dbo].[PayerInfo]    Script Date: 09.08.2018 16:53:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PayerInfo](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AccountGUID] [uniqueidentifier] NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[GrandName] [nvarchar](50) NULL,
	[SNILS] [nvarchar](11) NULL,
	[Series] [nvarchar](10) NULL,
	[Number] [nvarchar](10) NULL,
	[IssueDate] [date] NULL,
 CONSTRAINT [PK_ResidentalLivingOwner] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PayerInfo] ADD  CONSTRAINT [DF_ResidentalLivingOwner_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[PayerInfo]  WITH CHECK ADD  CONSTRAINT [FK_PayerInfo_Accounts] FOREIGN KEY([AccountGUID])
REFERENCES [dbo].[Accounts] ([GUID])
GO

ALTER TABLE [dbo].[PayerInfo] CHECK CONSTRAINT [FK_PayerInfo_Accounts]
GO


