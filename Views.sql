USE [ERM_BI]
GO

/****** Object:  View [dbo].[RevenueDetails]    Script Date: 8/14/2018 12:30:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[RevenueDetails]
AS

WITH HFMAccounts (ID, Code, ParentID, ParentCode) AS
(
	SELECT Accounts.ID, Accounts.Code, Accounts.ParentID, Accounts.Code AS ParentCode FROM [dbo].[HFM_GL_Accounts] AS Accounts
		INNER JOIN [dbo].[HFM_GL_Accounts] AS ParentAccounts
		ON Accounts.ParentID = ParentAccounts.ID AND ParentAccounts.ParentID IS NULL
	UNION ALL
	SELECT Accounts.ID, Accounts.Code, Accounts.ParentID, HFMAccounts.ParentCode FROM [dbo].[HFM_GL_Accounts] AS Accounts
	INNER JOIN HFMAccounts
		ON HFMAccounts.ID = Accounts.ParentID
)


SELECT
	Revenue.[Period] AS Period,
	Revenue.Source AS Source,
	Revenue.ClientNumber AS ClientNumber,
	Clients.CRMID AS CRM_ID,
	Clients.Description AS ClientDescription,
	ParentClients.Description AS ParentClientDescription,
	SalesAccounts.Description AS SalesAccountsDescription,
	Companies.Code AS CompanyCode,
	Companies.Description AS CompanyDescription,
	MngmtGeo.Code AS MngmtGeoCode,
	MngmtGeo.Description AS MngmtGeoDescription,
	Geo.Code AS GeoCode,
	Geo.Description AS GeoDescription,
	SubGeo.Code AS SubGeoCode,
	SubGeo.Description AS SubGeoDescription,
	Seg.Code AS SegmentCode,
	Seg.Description AS SegmentDescription,
	SubSeg.Code AS SubSegmentCode,
	SubSeg.Description AS SubSegmentDescription,
	SubSubSeg.Code AS SubSubSegmentCode,
	SubSubSeg.Description AS SubSubSegmentDescription,
	HFMAccounts.Code AS Account,
	HFMAccounts.ParentCode AS ParentAccount,
	BU.Code AS BUCode,
	BU.Description AS BUDescription,
	Curr.Description AS Currency,
	Revenue.Amount AS Amount,
	Revenue.AmountUSD AS AmountUSD
FROM
	[dbo].[Revenue] AS Revenue
	LEFT JOIN [dbo].[Clients] AS Clients
	ON Revenue.ClientID = Clients.ID
	LEFT JOIN [dbo].[ClientHierarchy] AS ClientHierarchy
	ON Revenue.ClientID = ClientHierarchy.ClientID
		LEFT JOIN [dbo].[Clients] AS ParentClients
		ON ClientHierarchy.ParentClientID = ParentClients.ID
		LEFT JOIN [dbo].[Clients] AS SalesAccounts
		ON ClientHierarchy.SalesAccountID = SalesAccounts.ID
	LEFT JOIN [dbo].[HFM_Companies] AS Companies
	ON Revenue.CompanyID = Companies.ID
	LEFT JOIN [dbo].[HFM_Geomarkets] AS SubGeo
	ON Revenue.SubGeomarketID = SubGeo.ID
		LEFT JOIN [dbo].[HFM_Geomarkets] AS Geo
		ON SubGeo.ParentID = Geo.ID
		LEFT JOIN [dbo].[ManagementGeography] AS MngmtGeo
		ON SubGeo.ManagementGeomarketID = MngmtGeo.ID
	LEFT JOIN [dbo].[HFM_Technology] AS SubSubSeg
	ON Revenue.SubSubSegmentID = SubSubSeg.ID
		LEFT JOIN [dbo].[HFM_Technology] AS SubSeg
		ON SubSubSeg.ParentID = SubSeg.ID
			LEFT JOIN [dbo].[HFM_Technology] AS Seg
			ON SubSeg.ParentID = Seg.ID
	LEFT JOIN [dbo].[BusinessUnits] AS BU
	ON Revenue.BusinessUnitID = BU.ID
	LEFT JOIN [dbo].[Currencies] AS Curr
	ON Revenue.CurrencyID = Curr.ID
	LEFT JOIN HFMAccounts AS HFMAccounts
	ON Revenue.AccountID = HFMAccounts.ID


GO


