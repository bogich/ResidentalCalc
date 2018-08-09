USE [ResidentalData]
GO

/****** Object:  Table [dbo].[RefNsiService51]    Script Date: 09.08.2018 16:53:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefNsiService51](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[IsActual] [bit] NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
	[GIS_Modified] [date] NOT NULL,
 CONSTRAINT [PK_RefNsiService51] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RefNsiService51] ADD  CONSTRAINT [DF_RefNsiService51_ID]  DEFAULT (newid()) FOR [ID]
GO


