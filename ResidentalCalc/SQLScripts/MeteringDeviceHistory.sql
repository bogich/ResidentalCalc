USE [ResidentalData]
GO

/****** Object:  Table [dbo].[MeteringDeviceHistory]    Script Date: 09.08.2018 16:52:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MeteringDeviceHistory](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[MeteringDeviceGUID] [uniqueidentifier] NOT NULL,
	[MeteringDeviceValue] [decimal](18, 2) NOT NULL,
	[MeteringDeviceDate] [date] NOT NULL,
 CONSTRAINT [PK_MeteringDeviceHistory] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MeteringDeviceHistory] ADD  CONSTRAINT [DF_MeteringDeviceHistory_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[MeteringDeviceHistory]  WITH CHECK ADD  CONSTRAINT [FK_MeteringDeviceHistory_MeteringDevice] FOREIGN KEY([MeteringDeviceGUID])
REFERENCES [dbo].[MeteringDevice] ([GUID])
GO

ALTER TABLE [dbo].[MeteringDeviceHistory] CHECK CONSTRAINT [FK_MeteringDeviceHistory_MeteringDevice]
GO


