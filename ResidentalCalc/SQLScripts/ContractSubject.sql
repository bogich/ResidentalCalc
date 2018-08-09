USE [ResidentalData]
GO

/****** Object:  Table [dbo].[ContractSubject]    Script Date: 09.08.2018 16:52:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ContractSubject](
	[GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SupplyResourceContractGUID] [uniqueidentifier] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[ServiceGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AccountIndividualServices] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ContractSubject] ADD  CONSTRAINT [DF_AccountIndividualServices_GUID]  DEFAULT (newid()) FOR [GUID]
GO

ALTER TABLE [dbo].[ContractSubject]  WITH CHECK ADD  CONSTRAINT [FK_ContractSubject_RefServices] FOREIGN KEY([ServiceGUID])
REFERENCES [dbo].[RefServices] ([GUID])
GO

ALTER TABLE [dbo].[ContractSubject] CHECK CONSTRAINT [FK_ContractSubject_RefServices]
GO

ALTER TABLE [dbo].[ContractSubject]  WITH CHECK ADD  CONSTRAINT [FK_ContractSubject_SupplyResourceContract] FOREIGN KEY([SupplyResourceContractGUID])
REFERENCES [dbo].[SupplyResourceContract] ([GUID])
GO

ALTER TABLE [dbo].[ContractSubject] CHECK CONSTRAINT [FK_ContractSubject_SupplyResourceContract]
GO


