USE [ResidentalData]
GO

/****** Object:  Table [dbo].[SupplyResourceContract]    Script Date: 09.08.2018 16:54:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SupplyResourceContract](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ContractNumber] [nvarchar](100) NOT NULL,
	[SigningDateStart] [date] NOT NULL,
	[SigningDateEnd] [date] NULL,
	[ContractState] [bit] NOT NULL,
	[GIS_ContractRootGUID] [uniqueidentifier] NULL,
	[GIS_VersionNumber] [int] NULL,
 CONSTRAINT [PK_SupplyResourceContract] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SupplyResourceContract] ADD  CONSTRAINT [DF_SupplyResourceContract_GUID]  DEFAULT (newid()) FOR [GUID]
GO


