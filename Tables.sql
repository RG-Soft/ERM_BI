USE [ERM_BI]
GO

/****** Object:  Table [dbo].[BusinessUnits]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[ClientHierarchy]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[Clients]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[Currencies]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[HFM_Companies]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[HFM_Geomarkets]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[HFM_GL_Accounts]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[HFM_Technology]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[ManagementGeography]    Script Date: 8/14/2018 12:07:08 PM ******/
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

/****** Object:  Table [dbo].[Revenue]    Script Date: 8/14/2018 12:07:08 PM ******/
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
	[SubGeomarketID] [nvarchar](36) NULL,
	[SubSubSegmentID] [nvarchar](36) NULL,
	[AccountID] [nvarchar](36) NULL,
	[BusinessUnitID] [nvarchar](36) NULL,
	[CurrencyID] [nvarchar](36) NOT NULL,
	[Amount] [numeric](21, 2) NOT NULL,
	[AmountUSD] [numeric](21, 2) NOT NULL
) ON [PRIMARY]

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

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[HFM_GL_Accounts] ([ID])
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

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([SubGeomarketID])
REFERENCES [dbo].[HFM_Geomarkets] ([ID])
GO

ALTER TABLE [dbo].[Revenue]  WITH CHECK ADD FOREIGN KEY([SubSubSegmentID])
REFERENCES [dbo].[HFM_Technology] ([ID])
GO


