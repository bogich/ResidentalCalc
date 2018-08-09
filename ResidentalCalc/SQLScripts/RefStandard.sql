USE [ResidentalData]
GO

/****** Object:  Table [dbo].[RefStandard]    Script Date: 09.08.2018 16:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefStandard](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StandardName] [nvarchar](100) NOT NULL,
	[StandardValue] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Standards] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RefStandard] ADD  CONSTRAINT [DF_Standards_GUID]  DEFAULT (newid()) FOR [GUID]
GO


