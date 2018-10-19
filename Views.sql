USE [ERM_BI]
GO

/****** Object:  View [dbo].[AR_Details_View]    Script Date: 10/19/2018 7:12:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[AR_Details_View]
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
	AR_Details.[Period] AS Period,
	AR_Details.Source AS Source,
	AR_Details.ClientNumber AS ClientNumber,
	Clients.ID AS ClientID,
	Clients.CRMID AS CRM_ID,
	Clients.Description AS ClientDescription,
	ParentClients.ID AS ParentClientID,
	ParentClients.Description AS ParentClientDescription,
	SalesAccounts.ID AS SalesAccountID,
	SalesAccounts.Description AS SalesAccountsDescription,
	Companies.ID AS CompanyID,
	Companies.Code AS CompanyCode,
	Companies.Description AS CompanyDescription,
	MngmtGeo.ID AS MngmtGeoID,
	MngmtGeo.Code AS MngmtGeoCode,
	MngmtGeo.Description AS MngmtGeoDescription,
	Geo.ID AS GeoID,
	Geo.Code AS GeoCode,
	Geo.Description AS GeoDescription,
	SubGeo.ID AS SubGeoID,
	SubGeo.Code AS SubGeoCode,
	SubGeo.Description AS SubGeoDescription,
	Seg.ID AS SegmentID,
	Seg.Code AS SegmentCode,
	Seg.Description AS SegmentDescription,
	SubSeg.ID AS SubSegmentID,
	SubSeg.Code AS SubSegmentCode,
	SubSeg.Description AS SubSegmentDescription,
	SubSubSeg.ID AS SubSubSegmentID,
	SubSubSeg.Code AS SubSubSegmentCode,
	SubSubSeg.Description AS SubSubSegmentDescription,
	AU.ID AS AU_ID,
	AU.Code AS AU_Code,
	AU.Description AS AU_Description,
	HFMAccounts.Code AS Account,
	HFMAccounts.ParentCode AS ParentAccount,
	BU.ID AS BU_ID,
	BU.Code AS BUCode,
	BU.Description AS BUDescription,
	AR_Details.TransactionType AS TransactionType,
	CASE
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN
				CASE
					WHEN AR_Details.Source = 'Oracle (MI)' AND Invoice.FiscalInvoiceNo <> ''
						THEN Invoice.FiscalInvoiceNo
					ELSE Invoice.DocNumber
				END
		WHEN AR_Details.DocumentType = 'JV'
			THEN ''
		WHEN AR_Details.DocumentType = 'CashBatch'
			THEN CAST(CashBatch.Number AS nvarchar(10))
		WHEN AR_Details.DocumentType = 'Memo'
			THEN Memo.Number
		WHEN AR_Details.DocumentType = 'SalesOrder'
			THEN SalesOrder.Number
	END AS InvoiceNo,
	CASE
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN Invoice.FiscalInvoiceNo
		ELSE ''
	END AS FiscalInvoiceNo,
	CASE
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN Invoice.FiscalInvoiceDate
		ELSE ''
	END AS FiscalInvoiceDate,
	CASE
		WHEN AR_Details.Source = ''
			THEN EOMONTH(AR_Details.Period)
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN Invoice.Date
		WHEN AR_Details.DocumentType = 'SalesOrder'
			THEN SalesOrder.Date
		WHEN AR_Details.DocumentType = 'Memo'
			THEN Memo.Date
		WHEN AR_Details.DocumentType = 'CashBatch'
			THEN CashBatch.Date
		WHEN AR_Details.DocumentType = 'JV'
			THEN JournalEntry.Date
	END AS InvoiceDate, 
	Curr.ID AS CurrencyID,
	Curr.Description AS Currency,
	CASE
		WHEN AR_Details.Source = ''
			THEN 0
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN Invoice.Amount
		WHEN AR_Details.DocumentType = 'SalesOrder'
			THEN SalesOrder.Amount
		WHEN AR_Details.DocumentType = 'Memo'
			THEN Memo.Amount
		WHEN AR_Details.DocumentType = 'CashBatch'
			THEN 0
		WHEN AR_Details.DocumentType = 'JV'
			THEN JournalEntry.Amount
	END AS InvoiceAmount, 
	CASE
		WHEN AR_Details.Source = ''
			THEN 0
		WHEN AR_Details.DocumentType = 'Invoice'
			THEN CAST(Invoice.Amount / InternalRates.Rate AS numeric(21,2))
		WHEN AR_Details.DocumentType = 'SalesOrder'
			THEN CAST(SalesOrder.Amount / InternalRates.Rate AS numeric(21,2))
		WHEN AR_Details.DocumentType = 'Memo'
			THEN CAST(Memo.Amount / InternalRates.Rate AS numeric(21,2))
		WHEN AR_Details.DocumentType = 'CashBatch'
			THEN 0
		WHEN AR_Details.DocumentType = 'JV'
			THEN CAST(JournalEntry.Amount / InternalRates.Rate AS numeric(21,2))
	END AS InvoiceAmountUSD, 
	AR_Details.Amount AS Amount,
	AR_Details.AmountUSD AS AmountUSD
FROM
	[dbo].[AR_Details] AS AR_Details
	LEFT JOIN [dbo].[Clients] AS Clients
	ON AR_Details.ClientID = Clients.ID
	LEFT JOIN [dbo].[ClientHierarchy] AS ClientHierarchy
	ON AR_Details.ClientID = ClientHierarchy.ClientID
		LEFT JOIN [dbo].[Clients] AS ParentClients
		ON ClientHierarchy.ParentClientID = ParentClients.ID
		LEFT JOIN [dbo].[Clients] AS SalesAccounts
		ON ClientHierarchy.SalesAccountID = SalesAccounts.ID
	LEFT JOIN [dbo].[HFM_Companies] AS Companies
	ON AR_Details.CompanyID = Companies.ID
	LEFT JOIN [dbo].[AccountingUnits] AS AU
	ON AR_Details.AU_ID = AU.ID
		LEFT JOIN [dbo].[HFM_Geomarkets] AS SubGeo
		ON AU.SubGeomarketID = SubGeo.ID
			LEFT JOIN [dbo].[HFM_Geomarkets] AS Geo
			ON SubGeo.ParentID = Geo.ID
			LEFT JOIN [dbo].[ManagementGeography] AS MngmtGeo
			ON SubGeo.ManagementGeomarketID = MngmtGeo.ID
		LEFT JOIN [dbo].[HFM_Technology] AS SubSubSeg
		ON AU.SubSubSegmentID = SubSubSeg.ID
			LEFT JOIN [dbo].[HFM_Technology] AS SubSeg
			ON SubSubSeg.ParentID = SubSeg.ID
				LEFT JOIN [dbo].[HFM_Technology] AS Seg
				ON SubSeg.ParentID = Seg.ID
	LEFT JOIN [dbo].[BusinessUnits] AS BU
	ON AR_Details.BusinessUnitID = BU.ID
	LEFT JOIN [dbo].[Currencies] AS Curr
	ON AR_Details.CurrencyID = Curr.ID
	LEFT JOIN HFMAccounts AS HFMAccounts
	ON AR_Details.AccountID = HFMAccounts.ID
	LEFT JOIN [dbo].[LegalEntiites] AS LE
	ON AR_Details.LegalEntityID = LE.ID
	LEFT JOIN [dbo].[Invoice] AS Invoice
	ON AR_Details.DocumentID = Invoice.ID
		AND AR_Details.DocumentType = Invoice.TypeName
	LEFT JOIN [dbo].[SalesOrder] AS SalesOrder
	ON AR_Details.DocumentID = SalesOrder.ID
		AND AR_Details.DocumentType = SalesOrder.TypeName
	LEFT JOIN [dbo].[Memo] AS Memo
	ON AR_Details.DocumentID = Memo.ID
		AND AR_Details.DocumentType = Memo.TypeName
	LEFT JOIN [dbo].[CashBatch] AS CashBatch
	ON AR_Details.DocumentID = CashBatch.ID
		AND AR_Details.DocumentType = CashBatch.TypeName
	LEFT JOIN [dbo].[JournalEntry] AS JournalEntry
	ON AR_Details.DocumentID = JournalEntry.ID
		AND AR_Details.DocumentType = JournalEntry.TypeName
	LEFT JOIN [dbo].[InternalRates] AS InternalRates
	ON AR_Details.CurrencyID = InternalRates.CurrencyID
		AND DATEADD(MONTH, 1, AR_Details.Period) = InternalRates.Period






GO

/****** Object:  View [dbo].[DSO_Details_View]    Script Date: 10/19/2018 7:12:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[DSO_Details_View]
AS

SELECT
	DSO_Details.[Period] AS Period,
	DSO_Details.Source AS Source,
	Clients.ID AS ClientID,
	Clients.CRMID AS CRM_ID,
	Clients.Description AS ClientDescription,
	ParentClients.ID AS ParentClientID,
	ParentClients.Description AS ParentClientDescription,
	SalesAccounts.ID AS SalesAccountID,
	SalesAccounts.Description AS SalesAccountsDescription,
	Companies.ID AS CompanyID,
	Companies.Code AS CompanyCode,
	Companies.Description AS CompanyDescription,
	MngmtGeo.ID AS MngmtGeoID,
	MngmtGeo.Code AS MngmtGeoCode,
	MngmtGeo.Description AS MngmtGeoDescription,
	Geo.ID AS GeoID,
	Geo.Code AS GeoCode,
	Geo.Description AS GeoDescription,
	SubGeo.ID AS SubGeoID,
	SubGeo.Code AS SubGeoCode,
	SubGeo.Description AS SubGeoDescription,
	Seg.ID AS SegmentID,
	Seg.Code AS SegmentCode,
	Seg.Description AS SegmentDescription,
	SubSeg.ID AS SubSegmentID,
	SubSeg.Code AS SubSegmentCode,
	SubSeg.Description AS SubSegmentDescription,
	SubSubSeg.ID AS SubSubSegmentID,
	SubSubSeg.Code AS SubSubSegmentCode,
	SubSubSeg.Description AS SubSubSegmentDescription,
	AU.ID AS AU_ID,
	AU.Code AS AU_Code,
	AU.Description AS AU_Description,
	BU.ID AS BU_ID,
	BU.Code AS BUCode,
	BU.Description AS BUDescription,
	DSO_Details.AR AS AR,
	DSO_Details.Billing0 AS Billing0,
	DSO_Details.Billing1 AS Billing1,
	DSO_Details.Billing2 AS Billing2,
	DSO_Details.Billing3 AS Billing3,
	DSO_Details.Billing4 AS Billing4,
	DSO_Details.Billing5 AS Billing5,
	DSO_Details.Billing6 AS Billing6,
	DSO_Details.Billing7 AS Billing7,
	DSO_Details.Billing8 AS Billing8,
	DSO_Details.Billing9 AS Billing9,
	DSO_Details.Billing10 AS Billing10,
	DSO_Details.Billing11 AS Billing11,
	DSO_Details.Billing12 AS Billing12,
	DSO_Details.Billing13 AS Billing13,
	DSO_Details.Billing14 AS Billing14,
	DSO_Details.Billing15 AS Billing15,
	DSO_Details.Billing16 AS Billing16,
	DSO_Details.Billing17 AS Billing17,
	DSO_Details.Billing18 AS Billing18,
	DSO_Details.Billing19 AS Billing19,
	DSO_Details.Billing20 AS Billing20,
	DSO_Details.Billing21 AS Billing21,
	DSO_Details.Billing22 AS Billing22,
	DSO_Details.Billing23 AS Billing23,
	DSO_Details.Billing24 AS Billing24
FROM
	[dbo].[DSO_Details] AS DSO_Details
	LEFT JOIN [dbo].[Clients] AS Clients
	ON DSO_Details.ClientID = Clients.ID
	LEFT JOIN [dbo].[ClientHierarchy] AS ClientHierarchy
	ON DSO_Details.ClientID = ClientHierarchy.ClientID
		LEFT JOIN [dbo].[Clients] AS ParentClients
		ON ClientHierarchy.ParentClientID = ParentClients.ID
		LEFT JOIN [dbo].[Clients] AS SalesAccounts
		ON ClientHierarchy.SalesAccountID = SalesAccounts.ID
	LEFT JOIN [dbo].[HFM_Companies] AS Companies
	ON DSO_Details.CompanyID = Companies.ID
	LEFT JOIN [dbo].[AccountingUnits] AS AU
	ON DSO_Details.AU_ID = AU.ID
		LEFT JOIN [dbo].[HFM_Geomarkets] AS SubGeo
		ON AU.SubGeomarketID = SubGeo.ID
			LEFT JOIN [dbo].[HFM_Geomarkets] AS Geo
			ON SubGeo.ParentID = Geo.ID
			LEFT JOIN [dbo].[ManagementGeography] AS MngmtGeo
			ON SubGeo.ManagementGeomarketID = MngmtGeo.ID
		LEFT JOIN [dbo].[HFM_Technology] AS SubSubSeg
		ON AU.SubSubSegmentID = SubSubSeg.ID
			LEFT JOIN [dbo].[HFM_Technology] AS SubSeg
			ON SubSubSeg.ParentID = SubSeg.ID
				LEFT JOIN [dbo].[HFM_Technology] AS Seg
				ON SubSeg.ParentID = Seg.ID
	LEFT JOIN [dbo].[BusinessUnits] AS BU
	ON DSO_Details.BusinessUnitID = BU.ID





GO

/****** Object:  View [dbo].[Revenue_Details_View]    Script Date: 10/19/2018 7:12:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[Revenue_Details_View]
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
	Clients.ID AS ClientID,
	Clients.CRMID AS CRM_ID,
	Clients.Description AS ClientDescription,
	ParentClients.ID AS ParentClientID,
	ParentClients.Description AS ParentClientDescription,
	SalesAccounts.ID AS SalesAccountID,
	SalesAccounts.Description AS SalesAccountsDescription,
	Companies.ID AS CompanyID,
	Companies.Code AS CompanyCode,
	Companies.Description AS CompanyDescription,
	MngmtGeo.ID AS MngmtGeoID,
	MngmtGeo.Code AS MngmtGeoCode,
	MngmtGeo.Description AS MngmtGeoDescription,
	Geo.ID AS GeoID,
	Geo.Code AS GeoCode,
	Geo.Description AS GeoDescription,
	SubGeo.ID AS SubGeoID,
	SubGeo.Code AS SubGeoCode,
	SubGeo.Description AS SubGeoDescription,
	Seg.ID AS SegmentID,
	Seg.Code AS SegmentCode,
	Seg.Description AS SegmentDescription,
	SubSeg.ID AS SubSegmentID,
	SubSeg.Code AS SubSegmentCode,
	SubSeg.Description AS SubSegmentDescription,
	SubSubSeg.ID AS SubSubSegmentID,
	SubSubSeg.Code AS SubSubSegmentCode,
	SubSubSeg.Description AS SubSubSegmentDescription,
	AU.ID AS AU_ID,
	AU.Code AS AU_Code,
	AU.Description AS AU_Description,
	HFMAccounts.Code AS Account,
	HFMAccounts.ParentCode AS ParentAccount,
	BU.ID AS BU_ID,
	BU.Code AS BUCode,
	BU.Description AS BUDescription,
	Curr.ID AS CurrencyID,
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
	LEFT JOIN [dbo].[AccountingUnits] AS AU
	ON Revenue.AU_ID = AU.ID
		LEFT JOIN [dbo].[HFM_Geomarkets] AS SubGeo
		ON AU.SubGeomarketID = SubGeo.ID
			LEFT JOIN [dbo].[HFM_Geomarkets] AS Geo
			ON SubGeo.ParentID = Geo.ID
			LEFT JOIN [dbo].[ManagementGeography] AS MngmtGeo
			ON SubGeo.ManagementGeomarketID = MngmtGeo.ID
		LEFT JOIN [dbo].[HFM_Technology] AS SubSubSeg
		ON AU.SubSubSegmentID = SubSubSeg.ID
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


