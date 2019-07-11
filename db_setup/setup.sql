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
WITH (DATA_COMPRESSION = PAGE)
GO

/*
INSERT INTO Customer
VALUES (123, 'Bob', 'Jones', '1000 W. Main St.', 'California City', 'CA', '99999', 'bob@email.erg', '0', 'PST', '127.0.0.1', 'Google', getDate())
*/


CREATE LOGIN [CSVLoader_user] WITH PASSWORD='CSVLoader_user', DEFAULT_DATABASE=[CSVLoader], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
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
USE [CSVLoader]
GO
