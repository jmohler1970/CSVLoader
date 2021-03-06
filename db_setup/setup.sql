CREATE DATABASE CSVLoader
GO

USE CSVLoader
GO


/* Based on: https://mockaroo.com/ */

CREATE TABLE [dbo].[Customer](
	[id] [int] NOT NULL identity(1,1) primary key,
	[member_id] [int] NOT NULL,	
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[state] [varchar](30) NOT NULL,
	[postalcode] [varchar](10) NOT NULL,
	[email] [varchar](80) NULL,
	[phone] [varchar](80) NULL,
	[timezone] [varchar](80) NOT NULL,
	[IP] [varchar](15) NOT NULL,
	[app_name] [varchar](20) NULL,
	[CreateDate] [smalldatetime] NOT NULL CONSTRAINT [DF_CSVLoader_Customer_CreateDate] DEFAULT GETDATE()
) ON [PRIMARY]
GO


CREATE INDEX ix_createDate ON dbo.Customer (
	CreateDate
	)
GO

CREATE INDEX ix_createDate_compressed ON dbo.Customer (
	CreateDate
	)
WITH (DATA_COMPRESSION = PAGE)
GO

CREATE INDEX ix_city ON dbo.Customer (
	City
	)
GO

CREATE INDEX ix_city_compressed ON dbo.Customer (
	City
	)
WITH (DATA_COMPRESSION = PAGE)
GO


CREATE INDEX ix_color_createdate ON dbo.Customer (
	City
	)
INCLUDE (
	CreateDate
	)	
GO




CREATE TABLE [dbo].[Interests](
	[id] [int] NOT NULL identity(1,1) primary key,
	[customer_id] [int] NOT NULL,	
	[genre] [varchar](80) NOT NULL,
	[plant] [varchar](50) NOT NULL,
	[active] [bit] NOT NULL,
	[refunded] [bit] NOT NULL,
	[product] [varchar](80) NOT NULL,
	[cctype] [varchar](50) NOT NULL,
	[CreateDate] [smalldatetime] NOT NULL CONSTRAINT [DF_CSVLoader_Interests_CreateDate] DEFAULT GETDATE()
) ON [PRIMARY]
GO

CREATE INDEX ix_genre ON dbo.Interests (
	Genre
	)
GO


CREATE TABLE [dbo].[Plants](
	[id] [int] NOT NULL identity(1,1) primary key,
	[plant] [varchar](40) NOT NULL,
	[plant_name] [varchar](255) NOT NULL,
	[geography] [char](2) NOT NULL,
	[notes] [varchar](max) NULL,
	[rnotes] [varchar](max) NULL,
	[studyyear] [int] NULL,
	[color] [varchar](20) NOT NULL,
	[reproduction] [varchar](10) NOT NULL,
	[CreateDate] [smalldatetime] NOT NULL CONSTRAINT [DF_CSVLoader_Plants_CreateDate] DEFAULT GETDATE()
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE);
GO




CREATE TABLE [dbo].[Plants_Sparse](
	[id] [int] NOT NULL identity(1,1) primary key,
	[plant] [varchar](40) NOT NULL,
	[plant_name] [varchar](255) NOT NULL,
	[geography] [char](2) NOT NULL,
	[notes] [varchar](max) SPARSE  NULL,
	[rnotes] [varchar](max) SPARSE NULL,
	[studyyear] [int] SPARSE NULL,
	[color] [varchar](20) NOT NULL,
	[reproduction] [varchar](10) NOT NULL,
	[CreateDate] [smalldatetime] NOT NULL CONSTRAINT [DF_CSVLoader_Plants_Sparse_CreateDate] DEFAULT GETDATE()
) ON [PRIMARY]
GO



CREATE LOGIN [CSVLoader_user] WITH PASSWORD='CSVLoader_user', DEFAULT_DATABASE=[CSVLoader], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Master]
GO
GRANT VIEW SERVER STATE TO CSVLoader_user
GO


USE [CSVLoader]
GO
CREATE USER [CSVLoader_user] FOR LOGIN [CSVLoader_user]
GO
USE [CSVLoader]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CSVLoader_user]
GO
USE [CSVLoader]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [CSVLoader_user]
GO

sp_addrolemember 'db_owner', 'CSVLoader_user'
GO




USE [CSVLoader]
GO
