USE [ResidentalData]
GO

/****** Object:  Table [dbo].[MeteringDevice]    Script Date: 09.08.2018 16:52:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MeteringDevice](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ObjectAddressGUID] [uniqueidentifier] NOT NULL,
	[MeteringDeviceModel] [nvarchar](100) NOT NULL,
	[MeteringDeviceStamp] [nvarchar](100) NOT NULL,
	[MeteringDeviceNumber] [nvarchar](50) NOT NULL,
	[VerificationInterval] [int] NOT NULL,
	[InstallationDate] [date] NOT NULL,
	[VerificationDate] [date] NOT NULL,
	[GIS_MeteringDeviceGUID] [uniqueidentifier] NULL,
	[GIS_VersionNumber] [int] NULL,
 CONSTRAINT [PK_MeteringDevice] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MeteringDevice] ADD  CONSTRAINT [DF_MeteringDevice_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[MeteringDevice]  WITH CHECK ADD  CONSTRAINT [FK_MeteringDevice_ObjectAddress] FOREIGN KEY([ObjectAddressGUID])
REFERENCES [dbo].[ObjectAddress] ([GUID])
GO

ALTER TABLE [dbo].[MeteringDevice] CHECK CONSTRAINT [FK_MeteringDevice_ObjectAddress]
GO


