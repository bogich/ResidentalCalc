USE [ResidentalData]
GO

/****** Object:  Table [dbo].[ChargeInfo]    Script Date: 09.08.2018 16:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChargeInfo](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[CalculationGUID] [uniqueidentifier] NOT NULL,
	[ContractSubjectGUID] [uniqueidentifier] NOT NULL,
	[Volume] [decimal](18, 2) NOT NULL,
	[CalculationResult] [decimal](18, 2) NOT NULL,
	[VolumeDeterminingMethod] [nvarchar](1) NOT NULL,
	[MeteringDeviceGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ChargeInfo] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ChargeInfo] ADD  CONSTRAINT [DF_ChargeInfo_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[ChargeInfo]  WITH CHECK ADD  CONSTRAINT [FK_ChargeInfo_AccountIndividualServices] FOREIGN KEY([ContractSubjectGUID])
REFERENCES [dbo].[ContractSubject] ([GUID])
GO

ALTER TABLE [dbo].[ChargeInfo] CHECK CONSTRAINT [FK_ChargeInfo_AccountIndividualServices]
GO

ALTER TABLE [dbo].[ChargeInfo]  WITH CHECK ADD  CONSTRAINT [FK_ChargeInfo_Calculation] FOREIGN KEY([CalculationGUID])
REFERENCES [dbo].[Calculation] ([GUID])
GO

ALTER TABLE [dbo].[ChargeInfo] CHECK CONSTRAINT [FK_ChargeInfo_Calculation]
GO

ALTER TABLE [dbo].[ChargeInfo]  WITH CHECK ADD  CONSTRAINT [FK_ChargeInfo_MeteringDevice] FOREIGN KEY([MeteringDeviceGUID])
REFERENCES [dbo].[MeteringDevice] ([GUID])
GO

ALTER TABLE [dbo].[ChargeInfo] CHECK CONSTRAINT [FK_ChargeInfo_MeteringDevice]
GO


