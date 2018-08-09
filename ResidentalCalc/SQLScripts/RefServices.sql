USE [ResidentalData]
GO

/****** Object:  Table [dbo].[RefServices]    Script Date: 09.08.2018 16:53:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefServices](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ServiceName] [nvarchar](50) NOT NULL,
	[TariffGUID] [uniqueidentifier] NOT NULL,
	[StandardGUID] [uniqueidentifier] NOT NULL,
	[NsiService51ID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RefServices] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RefServices] ADD  CONSTRAINT [DF_RefServices_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[RefServices]  WITH CHECK ADD  CONSTRAINT [FK_RefServices_RefNsiService51] FOREIGN KEY([NsiService51ID])
REFERENCES [dbo].[RefNsiService51] ([ID])
GO

ALTER TABLE [dbo].[RefServices] CHECK CONSTRAINT [FK_RefServices_RefNsiService51]
GO

ALTER TABLE [dbo].[RefServices]  WITH CHECK ADD  CONSTRAINT [FK_RefServices_RefStandards] FOREIGN KEY([StandardGUID])
REFERENCES [dbo].[RefStandard] ([GUID])
GO

ALTER TABLE [dbo].[RefServices] CHECK CONSTRAINT [FK_RefServices_RefStandards]
GO

ALTER TABLE [dbo].[RefServices]  WITH CHECK ADD  CONSTRAINT [FK_RefServices_RefTariff] FOREIGN KEY([TariffGUID])
REFERENCES [dbo].[RefTariff] ([GUID])
GO

ALTER TABLE [dbo].[RefServices] CHECK CONSTRAINT [FK_RefServices_RefTariff]
GO


