USE [ResidentalData]
GO

/****** Object:  Table [dbo].[ObjectAddress]    Script Date: 09.08.2018 16:52:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ObjectAddress](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SupplyResourceContractGUID] [uniqueidentifier] NOT NULL,
	[FIASHouseGUID] [uniqueidentifier] NOT NULL,
	[Apartment] [nvarchar](5) NOT NULL,
	[LivingRoom] [nvarchar](5) NULL,
	[GIS_ObjectGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ObjectAddress] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ObjectAddress] ADD  CONSTRAINT [DF_ObjectAddress_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[ObjectAddress]  WITH CHECK ADD  CONSTRAINT [FK_ObjectAddress_SupplyResourceContract] FOREIGN KEY([SupplyResourceContractGUID])
REFERENCES [dbo].[SupplyResourceContract] ([GUID])
GO

ALTER TABLE [dbo].[ObjectAddress] CHECK CONSTRAINT [FK_ObjectAddress_SupplyResourceContract]
GO


