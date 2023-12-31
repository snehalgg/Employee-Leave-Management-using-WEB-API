USE [master]
GO
/****** Object:  Database [EmployeeLeaveManagementDB]    Script Date: 10/30/2023 5:57:57 PM ******/
CREATE DATABASE [EmployeeLeaveManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeLeaveManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EmployeeLeaveManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployeeLeaveManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\EmployeeLeaveManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeLeaveManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET QUERY_STORE = OFF
GO
USE [EmployeeLeaveManagementDB]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 10/30/2023 5:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Position] [nvarchar](50) NULL,
	[SeekLeaves] [int] NULL,
	[CasualLeaves] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveRequests]    Script Date: 10/30/2023 5:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveRequests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[LeaveType] [nvarchar](50) NULL,
	[Approved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([Id], [Name], [Username], [Password], [Position], [SeekLeaves], [CasualLeaves]) VALUES (1, N'snehal', N'snehal', N'snehal', N'employee', 10, 10)
INSERT [dbo].[Employees] ([Id], [Name], [Username], [Password], [Position], [SeekLeaves], [CasualLeaves]) VALUES (2, N'admin', N'admin', N'admin@123', N'admin', 0, 0)
INSERT [dbo].[Employees] ([Id], [Name], [Username], [Password], [Position], [SeekLeaves], [CasualLeaves]) VALUES (3, N'dhruv', N'dhruv', N'dhruv@123', N'manager', 15, 15)
INSERT [dbo].[Employees] ([Id], [Name], [Username], [Password], [Position], [SeekLeaves], [CasualLeaves]) VALUES (4, N'muazzam', N'muazzam', N'muazzam', N'employee', 15, 10)
INSERT [dbo].[Employees] ([Id], [Name], [Username], [Password], [Position], [SeekLeaves], [CasualLeaves]) VALUES (5, N'snehall', N'snehall', N'snehall', N'employee', 12, 12)
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveRequests] ON 

INSERT [dbo].[LeaveRequests] ([Id], [EmployeeId], [StartDate], [EndDate], [LeaveType], [Approved]) VALUES (4, 1, CAST(N'2023-05-11' AS Date), CAST(N'2023-05-13' AS Date), N'casual', 1)
INSERT [dbo].[LeaveRequests] ([Id], [EmployeeId], [StartDate], [EndDate], [LeaveType], [Approved]) VALUES (5, 1, CAST(N'2023-11-11' AS Date), CAST(N'2023-11-12' AS Date), N'casual', 1)
INSERT [dbo].[LeaveRequests] ([Id], [EmployeeId], [StartDate], [EndDate], [LeaveType], [Approved]) VALUES (6, 1, CAST(N'2023-10-12' AS Date), CAST(N'2023-10-14' AS Date), N'seek', 1)
SET IDENTITY_INSERT [dbo].[LeaveRequests] OFF
GO
ALTER TABLE [dbo].[LeaveRequests]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
USE [master]
GO
ALTER DATABASE [EmployeeLeaveManagementDB] SET  READ_WRITE 
GO
