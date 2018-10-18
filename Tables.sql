USE [ERM_BI]
GO

/****** Object:  Table [dbo].[AccountingUnits]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AccountingUnits](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nchar](10) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[SubGeomarketID] [nvarchar](36) NULL,
	[SubSubSegmentID] [nvarchar](36) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[AR_Details]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AR_Details](
	[Period] [datetime] NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[ClientNumber] [nvarchar](50) NULL,
	[ClientID] [nvarchar](36) NULL,
	[CompanyID] [nvarchar](36) NULL,
	[LegalEntityID] [nvarchar](36) NULL,
	[AU_ID] [nvarchar](36) NULL,
	[AccountID] [nvarchar](36) NULL,
	[BusinessUnitID] [nvarchar](36) NULL,
	[Agreement] [nvarchar](150) NULL,
	[TransactionType] [nvarchar](10) NULL,
	[DocumentType] [nvarchar](50) NULL,
	[DocumentID] [nvarchar](36) NULL,
	[CurrencyID] [nvarchar](36) NOT NULL,
	[Amount] [numeric](21, 2) NOT NULL,
	[AmountUSD] [numeric](21, 2) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[BusinessUnits]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BusinessUnits](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nvarchar](9) NOT NULL,
	[Description] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[CashBatch]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CashBatch](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Number] [numeric](10, 0) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[Prepayment] [bit] NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[PaymentNumber] [nvarchar](25) NOT NULL,
	[CompanyID] [nvarchar](36) NULL,
	[ClientID] [nvarchar](36) NULL,
	[Agreement] [nvarchar](150) NOT NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[Amount] [numeric](15, 2) NOT NULL,
	[TypeName]  AS (CONVERT([nvarchar](50),'CashBatch')) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[ClientHierarchy]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClientHierarchy](
	[ClientID] [nvarchar](36) NOT NULL,
	[ParentClientID] [nvarchar](36) NULL,
	[SalesAccountID] [nvarchar](36) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Clients]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Clients](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[CRMID] [nvarchar](10) NULL,
	[Description] [nvarchar](150) NOT NULL,
	[AccountType] [nvarchar](16) NULL,
	[Intercompany] [bit] NOT NULL,
	[ActiveState] [nvarchar](16) NULL,
	[CreditRating] [nvarchar](16) NULL,
	[CreditAssessmentId] [nvarchar](10) NULL,
	[CreditAssessmentStatus] [nvarchar](16) NULL,
	[CreditLimit] [numeric](15, 2) NULL,
	[crmPostalCode] [nvarchar](50) NULL,
	[crmCountry] [nvarchar](150) NULL,
	[crmCity] [nvarchar](150) NULL,
	[crmStreetAddress] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Contracts]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Contracts](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[OwnerID] [nvarchar](36) NULL,
	[Code] [nchar](9) NOT NULL,
	[Description] [nvarchar](150) NOT NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[CompanyID] [nvarchar](36) NULL,
	[Date] [datetime] NULL,
	[Number] [nvarchar](20) NULL,
	[PTType] [nvarchar](8) NULL,
	[PTDaysFrom] [numeric](2, 0) NULL,
	[PTDaysTo] [numeric](5, 0) NULL,
	[PIC_ID] [nvarchar](20) NULL,
	[ChecklistRequired] [bit] NOT NULL,
	[TriggerDescription] [nvarchar](50) NULL,
	[ContractID] [nvarchar](10) NULL,
	[SourceID] [nvarchar](3) NULL,
	[crmContractID] [nvarchar](25) NULL,
	[crmCreatedBy] [nvarchar](20) NULL,
	[crmCreatedDate] [datetime] NULL,
	[crmEffectiveDate] [datetime] NULL,
	[crmExpiryDate] [datetime] NULL,
	[crmContractCurrency] [nvarchar](3) NULL,
	[crmContractValueUSD] [numeric](15, 2) NULL,
	[crmContractName] [nvarchar](150) NULL,
	[crmDFNName] [nvarchar](50) NULL,
	[DocumentFlowPeriodFrom] [numeric](2, 0) NULL,
	[DocumentFlowPeriodTo] [numeric](2, 0) NULL,
	[Amendment] [bit] NOT NULL,
	[AmendmentName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Currencies]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Currencies](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nvarchar](3) NOT NULL,
	[Description] [nvarchar](10) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[DocumentJournal]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DocumentJournal](
	[TypeName] [nvarchar](50) NOT NULL,
	[DocumentID] [nvarchar](36) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeName] ASC,
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[HFM_Companies]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HFM_Companies](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nvarchar](7) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[HFM_Geomarkets]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HFM_Geomarkets](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[ParentID] [nvarchar](36) NULL,
	[Code] [nvarchar](9) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[ManagementGeomarketID] [nvarchar](36) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[HFM_GL_Accounts]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HFM_GL_Accounts](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[ParentID] [nvarchar](36) NULL,
	[Code] [nvarchar](9) NOT NULL,
	[Description] [nvarchar](70) NOT NULL,
	[Intercompany] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[HFM_Technology]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HFM_Technology](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nvarchar](8) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[ParentID] [nvarchar](36) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[InternalRates]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InternalRates](
	[Period] [datetime] NOT NULL,
	[CurrencyID] [nvarchar](36) NOT NULL,
	[Rate] [numeric](10, 4) NOT NULL,
	[Multiplicity] [numeric](10, 0) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Invoice]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Invoice](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Date] [datetime2](0) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[CompanyID] [nvarchar](36) NULL,
	[ClientID] [nvarchar](36) NULL,
	[ContractID] [nvarchar](36) NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[Amount] [numeric](15, 2) NOT NULL,
	[FiscalInvoiceNo] [nvarchar](50) NOT NULL,
	[FiscalInvoiceDate] [datetime2](0) NOT NULL,
	[FiscalCurrencyID] [nvarchar](36) NULL,
	[FiscalAmount] [numeric](15, 2) NOT NULL,
	[TriggerDate] [datetime2](0) NOT NULL,
	[DueDateFrom] [datetime2](0) NOT NULL,
	[DueDateTo] [datetime2](0) NOT NULL,
	[Agreement] [nvarchar](150) NOT NULL,
	[DocNumber] [nvarchar](25) NULL,
	[KSReturnDate] [datetime2](0) NOT NULL,
	[KSDepartureDate] [datetime2](0) NOT NULL,
	[KSReturnStatus] [nvarchar](100) NOT NULL,
	[KSCommentReturnStatus] [nvarchar](300) NOT NULL,
	[TypeName]  AS (CONVERT([nvarchar](50),'Invoice')) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[JournalEntry]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[JournalEntry](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Number] [nchar](9) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[CompanyID] [nvarchar](36) NULL,
	[ClientID] [nvarchar](36) NULL,
	[Agreement] [nvarchar](150) NOT NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[Amount] [numeric](15, 2) NOT NULL,
	[TypeName]  AS (CONVERT([nvarchar](50),'JV')) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[LegalEntiites]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LegalEntiites](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[OwnerID] [nvarchar](36) NULL,
	[Code] [nvarchar](9) NOT NULL,
	[Description] [nvarchar](25) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[ManagementGeography]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ManagementGeography](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Code] [nvarchar](9) NOT NULL,
	[Description] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Memo]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Memo](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[CompanyID] [nvarchar](36) NULL,
	[ClientID] [nvarchar](36) NULL,
	[Agreement] [nvarchar](150) NOT NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[Amount] [numeric](15, 2) NOT NULL,
	[TypeName]  AS (CONVERT([nvarchar](50),'Memo')) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Revenue]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Revenue](
	[Period] [datetime] NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[ClientNumber] [nvarchar](50) NULL,
	[ClientID] [nvarchar](36) NULL,
	[CompanyID] [nvarchar](36) NULL,
	[AccountID] [nvarchar](36) NULL,
	[BusinessUnitID] [nvarchar](36) NULL,
	[CurrencyID] [nvarchar](36) NOT NULL,
	[Amount] [numeric](21, 2) NOT NULL,
	[AmountUSD] [numeric](21, 2) NOT NULL,
	[AU_ID] [nvarchar](36) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[SalesOrder]    Script Date: 10/18/2018 6:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SalesOrder](
	[ID] [nvarchar](36) NOT NULL,
	[DeletionMark] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[ClientID] [nvarchar](36) NULL,
	[CompanyID] [nvarchar](36) NULL,
	[CurrencyID] [nvarchar](36) NULL,
	[Agreement] [nvarchar](150) NOT NULL,
	[Amount] [numeric](15, 2) NOT NULL,
	[TypeName]  AS (CONVERT([nvarchar](50),'SalesOrder')) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[AccountingUnits]  WITH CHECK ADD FOREIGN KEY([SubGeomarketID])
REFERENCES [dbo].[HFM_Geomarkets] ([ID])
GO

ALTER TABLE [dbo].[AccountingUnits]  WITH CHECK ADD FOREIGN KEY([SubSubSegmentID])
REFERENCES [dbo].[HFM_Technology] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[HFM_GL_Accounts] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([AU_ID])
REFERENCES [dbo].[AccountingUnits] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([BusinessUnitID])
REFERENCES [dbo].[BusinessUnits] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([LegalEntityID])
REFERENCES [dbo].[LegalEntiites] ([ID])
GO

ALTER TABLE [dbo].[AR_Details]  WITH CHECK ADD FOREIGN KEY([DocumentType], [DocumentID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO

ALTER TABLE [dbo].[CashBatch]  WITH CHECK ADD FOREIGN KEY([TypeName], [ID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO

ALTER TABLE [dbo].[CashBatch]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[CashBatch]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[CashBatch]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[ClientHierarchy]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[ClientHierarchy]  WITH CHECK ADD FOREIGN KEY([ParentClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[ClientHierarchy]  WITH CHECK ADD FOREIGN KEY([SalesAccountID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[Contracts]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[Contracts]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[Contracts]  WITH CHECK ADD FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[HFM_Geomarkets]  WITH CHECK ADD FOREIGN KEY([ManagementGeomarketID])
REFERENCES [dbo].[ManagementGeography] ([ID])
GO

ALTER TABLE [dbo].[HFM_Geomarkets]  WITH CHECK ADD FOREIGN KEY([ParentID])
REFERENCES [dbo].[HFM_Geomarkets] ([ID])
GO

ALTER TABLE [dbo].[HFM_GL_Accounts]  WITH CHECK ADD FOREIGN KEY([ParentID])
REFERENCES [dbo].[HFM_GL_Accounts] ([ID])
GO

ALTER TABLE [dbo].[HFM_Technology]  WITH CHECK ADD FOREIGN KEY([ParentID])
REFERENCES [dbo].[HFM_Technology] ([ID])
GO

ALTER TABLE [dbo].[InternalRates]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([TypeName], [ID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([ContractID])
REFERENCES [dbo].[Contracts] ([ID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([FiscalCurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[JournalEntry]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[JournalEntry]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[JournalEntry]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[JournalEntry]  WITH CHECK ADD FOREIGN KEY([TypeName], [ID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO

ALTER TABLE [dbo].[LegalEntiites]  WITH CHECK ADD FOREIGN KEY([OwnerID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[Memo]  WITH CHECK ADD FOREIGN KEY([TypeName], [ID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO

ALTER TABLE [dbo].[Memo]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[Memo]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[Memo]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[HFM_GL_Accounts] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([AU_ID])
REFERENCES [dbo].[AccountingUnits] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([BusinessUnitID])
REFERENCES [dbo].[BusinessUnits] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ID])
GO

ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([CompanyID])
REFERENCES [dbo].[HFM_Companies] ([ID])
GO

ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[Currencies] ([ID])
GO

ALTER TABLE [dbo].[SalesOrder]  WITH CHECK ADD FOREIGN KEY([TypeName], [ID])
REFERENCES [dbo].[DocumentJournal] ([TypeName], [DocumentID])
GO


