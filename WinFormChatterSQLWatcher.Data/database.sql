USE [master]
GO
/****** Object:  Database [Chatter]    Script Date: 11/18/2005 13:55:20 ******/
CREATE DATABASE [Chatter] ON  PRIMARY 
( NAME = N'Chatter', FILENAME = N'D:\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\Chatter.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Chatter_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\Chatter_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'Chatter', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Chatter].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [Chatter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Chatter] SET ARITHABORT OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Chatter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Chatter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Chatter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Chatter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Chatter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Chatter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Chatter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Chatter] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Chatter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Chatter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Chatter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Chatter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Chatter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Chatter] SET  READ_WRITE 
GO
ALTER DATABASE [Chatter] SET RECOVERY FULL 
GO
ALTER DATABASE [Chatter] SET  MULTI_USER 
GO
ALTER DATABASE [Chatter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Chatter] SET DB_CHAINING OFF 

/***************************************************/

USE [Chatter]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 11/18/2005 13:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[int] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Person_ID] [int] NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[int] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

USE [Chatter]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 11/18/2005 13:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

USE [Chatter]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMessages]    Script Date: 11/18/2005 13:59:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_GetMessages]

AS

SELECT [Message], [Name]
FROM dbo.[Message]
JOIN dbo.Person ON id = [Message].Person_ID

GO
USE [Chatter]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertMessage]    Script Date: 11/18/2005 13:59:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_InsertMessage]
	@Message nvarchar(200),
	@Person_ID int
AS

INSERT INTO [Message] ([Message], Person_ID)
VALUES (@Message, @Person_ID)
GO
/****************************************/
INSERT INTO [Chatter].[dbo].[Person]
([Name])
VALUES('Larry')
GO
INSERT INTO [Chatter].[dbo].[Person]
([Name])
VALUES('Moe')
GO
INSERT INTO [Chatter].[dbo].[Person]
([Name])
VALUES('Curly')