USE [ResidentalData]
GO

/****** Object:  Table [dbo].[RefTariff]    Script Date: 09.08.2018 16:53:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefTariff](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TariffName] [nvarchar](50) NOT NULL,
	[TariffValue] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_RefTariff] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RefTariff] ADD  CONSTRAINT [DF_RefTariff_GUID]  DEFAULT (newid()) FOR [GUID]
GO


