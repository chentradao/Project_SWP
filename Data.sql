USE [master]
GO
/****** Object:  Database [SWP]    Script Date: 3/28/2025 2:27:21 PM ******/
CREATE DATABASE [SWP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SWP] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SWP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP] SET  MULTI_USER 
GO
ALTER DATABASE [SWP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP', N'ON'
GO
ALTER DATABASE [SWP] SET QUERY_STORE = ON
GO
ALTER DATABASE [SWP] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SWP]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](36) NULL,
	[Password] [nvarchar](36) NULL,
	[FullName] [nvarchar](50) NULL,
	[Gender] [char](1) NULL,
	[Phone] [nvarchar](11) NULL,
	[Email] [nvarchar](36) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[Role] [nvarchar](20) NOT NULL,
	[Image] [nvarchar](255) NULL,
	[GoogleID] [nvarchar](255) NULL,
	[CreateDate] [date] NOT NULL,
	[OrderQuality] [int] NULL,
	[TotalSpending] [int] NULL,
	[AccountStatus] [smallint] NOT NULL,
 CONSTRAINT [PK__Accounts__349DA586D5E203D7] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountVoucher]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountVoucher](
	[AccountID] [int] NOT NULL,
	[VoucherID] [int] NOT NULL,
 CONSTRAINT [PK_AccountVoucher] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogID] [int] IDENTITY(1,1) NOT NULL,
	[BlogTitle] [nvarchar](255) NULL,
	[BlogDescription] [text] NULL,
	[BlogThumbnail] [nvarchar](255) NULL,
	[BlogCategoryID] [int] NULL,
	[BlogAuthor] [int] NULL,
	[Date] [date] NULL,
	[Image] [nvarchar](255) NULL,
	[BlogStatus] [smallint] NULL,
 CONSTRAINT [PK__Blog__54379E50283593FC] PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogCategory]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogCategory](
	[BlogCategoryID] [int] NOT NULL,
	[BlogCategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_BlogCategory] PRIMARY KEY CLUSTERED 
(
	[BlogCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](150) NOT NULL,
	[CategoryStatus] [smallint] NOT NULL,
	[RootCategoryID] [int] NULL,
	[CategoryPath] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[AccountID] [int] NULL,
	[RateStar] [int] NULL,
	[ImageURL] [nvarchar](255) NULL,
	[Feedback] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK__Feedback__6A4BEDF6181FA412] PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedbackReply]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedbackReply](
	[ReplyID] [int] IDENTITY(1,1) NOT NULL,
	[FeedbackID] [int] NULL,
	[AccountID] [int] NULL,
	[ReplyText] [nvarchar](255) NULL,
	[ReplyDate] [datetime] NULL,
 CONSTRAINT [PK__Reply__C25E4629BA16C535] PRIMARY KEY CLUSTERED 
(
	[ReplyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlashSale]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlashSale](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Discount] [int] NOT NULL,
	[Quantity] [int] NULL,
	[TimeFrame] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_FlashSale] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [int] NULL,
 CONSTRAINT [PK__OrderDet__08D097C14CD5468C] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [nvarchar](100) NULL,
	[CustomerID] [int] NULL,
	[StaffID] [int] NULL,
	[CustomerName] [nvarchar](50) NULL,
	[OrderDate] [date] NULL,
	[ShippedDate] [date] NULL,
	[ShippingFee] [int] NULL,
	[TotalCost] [int] NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](11) NULL,
	[ShipAddress] [nvarchar](255) NULL,
	[Discount] [int] NULL,
	[Note] [nvarchar](100) NULL,
	[CancelNotification] [nvarchar](100) NULL,
	[PaymentMethod] [nvarchar](15) NULL,
	[OrderStatus] [smallint] NULL,
 CONSTRAINT [PK__Orders__C3905BAF3F8061BB] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[IdentityCode] [nvarchar](15) NULL,
	[Size] [nvarchar](10) NULL,
	[Color] [char](50) NULL,
	[Quantity] [int] NULL,
	[SoldQuantity] [int] NULL,
	[DateCreate] [date] NULL,
	[ImportPrice] [int] NULL,
	[Price] [int] NULL,
	[Image] [nvarchar](255) NULL,
	[Details] [nvarchar](max) NULL,
	[ProductStatus] [smallint] NULL,
 CONSTRAINT [PK__ProductD__3214EC27E0785C60] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](150) NOT NULL,
	[CategoryID] [int] NULL,
	[Date] [date] NULL,
	[Description] [nvarchar](255) NULL,
	[ProductStatus] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[SliderID] [int] IDENTITY(1,1) NOT NULL,
	[SliderTitle] [nvarchar](255) NULL,
	[SliderSubTitle] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](255) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[SliderAuthor] [int] NULL,
	[SliderStatus] [smallint] NULL,
 CONSTRAINT [PK__Slider__24BC9710B0B301A4] PRIMARY KEY CLUSTERED 
(
	[SliderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[VoucherID] [int] IDENTITY(1,1) NOT NULL,
	[VoucherName] [nvarchar](50) NOT NULL,
	[Discount] [int] NULL,
	[MaxDiscount] [int] NULL,
	[Quantity] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Description] [nvarchar](255) NULL,
	[VoucherStatus] [int] NULL,
 CONSTRAINT [PK__Voucher__3AEE79C1FFBD7167] PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlist]    Script Date: 3/28/2025 2:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[AccountID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (1, N'minhday', N'30122004', N'NguyenQuangMinh', N'M', N'0987654333', N'hihi1@gmail.com', N'Hanoi', N'customer', NULL, NULL, CAST(N'2025-02-06' AS Date), NULL, NULL, 1)
INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (2, N'minhhh', N'Minh2004@', N'nguyenquangminh', N'M', N'0926310990', N'minhttt2004@gmail.com', N'Số 2 Quang Trung, Xã Chiềng Ơn, Huyện Quỳnh Nhai, Tỉnh Sơn La', N'Customer', N'id2_best_2.jpg', NULL, CAST(N'2025-02-08' AS Date), NULL, NULL, 1)
INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (3, N'thuphg', N'Thuphg0@', N'ThuPhuong', NULL, N'0914345278', N'alooo@gmail.com', NULL, N'Customer', NULL, NULL, CAST(N'2025-02-08' AS Date), NULL, NULL, 1)
INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (4, N'duyhung', N'Hung2004@', N'duyhung', NULL, N'0123456789', N'hung123@gmail.com', NULL, N'Customer', NULL, NULL, CAST(N'2025-02-08' AS Date), NULL, NULL, 1)
INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (5, N'Hank', N'123456', N'Hank', N'M', N'0926310999', N'nguyenxuanhanh0440@gmail.com', NULL, N'staff', NULL, NULL, CAST(N'2025-03-07' AS Date), NULL, NULL, 1)
INSERT [dbo].[Accounts] ([AccountID], [UserName], [Password], [FullName], [Gender], [Phone], [Email], [Address], [Role], [Image], [GoogleID], [CreateDate], [OrderQuality], [TotalSpending], [AccountStatus]) VALUES (12, N'Hank12', N'Hanh2004@', N'Nguyễn Xuân Hanh', NULL, N'0926310998', N'hanhnxhe180944@fpt.edu.vn', NULL, N'admin', NULL, NULL, CAST(N'2025-03-19' AS Date), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
INSERT [dbo].[AccountVoucher] ([AccountID], [VoucherID]) VALUES (1, 2)
INSERT [dbo].[AccountVoucher] ([AccountID], [VoucherID]) VALUES (2, 2)
INSERT [dbo].[AccountVoucher] ([AccountID], [VoucherID]) VALUES (4, 2)
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (1, N'Chăm sóc da', 1, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (2, N'Trang điểm', 1, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (3, N'Nước hoa', 1, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (4, N'Chăm sóc mắt', 1, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (5, N'Kem dưỡng', 1, 1, N'1/Cham sóc da m?t')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (6, N'Serum(Tinh chất)', 1, 1, N'1/Cham sóc da toàn thân')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (7, N'Trang điểm mắt', 1, 2, N'2/Trang di?m m?t')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (8, N'Trang điểm môi', 1, 2, N'2/Trang di?m môi')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (9, N'Nước hoa mùa đông', 1, 3, N'3/Nu?c hoa n?')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (10, N'Nước hoa mùa hè', 1, 3, N'3/Nu?c hoa nam')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (11, N'Serum dành cho mắt', 1, 4, N'4/M?t n? du?ng da')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [CategoryStatus], [RootCategoryID], [CategoryPath]) VALUES (12, N'Kem dưỡng dành cho mắt', 1, 4, N'4/S?a r?a m?t')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FeedbackID], [ProductID], [AccountID], [RateStar], [ImageURL], [Feedback], [Date]) VALUES (1, 1, 2, 5, N'886f5127-90be-4358-8740-17875ac547a1.jpg', N'10', CAST(N'2025-03-07T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[FlashSale] ON 

INSERT [dbo].[FlashSale] ([SaleID], [ProductID], [StartTime], [EndTime], [Discount], [Quantity], [TimeFrame], [Status]) VALUES (2, 10, CAST(N'2025-03-28T00:00:00.000' AS DateTime), CAST(N'2025-03-28T00:00:00.000' AS DateTime), 50, 6, 1, 1)
INSERT [dbo].[FlashSale] ([SaleID], [ProductID], [StartTime], [EndTime], [Discount], [Quantity], [TimeFrame], [Status]) VALUES (3, 15, CAST(N'2025-03-28T00:00:00.000' AS DateTime), CAST(N'2025-03-28T00:00:00.000' AS DateTime), 60, 5, 1, 1)
SET IDENTITY_INSERT [dbo].[FlashSale] OFF
GO
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (7, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (7, 12, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (7, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (9, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (10, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (11, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (11, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (14, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (14, 20, 1, 3500000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (14, 30, 2, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (15, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (16, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (16, 12, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (16, 30, 2, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (17, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (17, 20, 1, 3500000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (17, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (18, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (18, 16, 2, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (18, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (19, 16, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (19, 18, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (22, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (22, 12, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (22, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (23, 15, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (24, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (24, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (25, 12, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (25, 16, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (26, 15, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (26, 19, 1, 4000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (27, 15, 1, 4600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (27, 17, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (28, 12, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (29, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (30, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (31, 10, 1, 3200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (33, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (33, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (34, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (35, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (35, 17, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (36, 16, 1, 2500000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (36, 17, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (36, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (43, 12, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (43, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (49, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (49, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (50, 8, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (50, 18, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (51, 8, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (51, 18, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (52, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (53, 16, 1, 2500000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (54, 8, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (54, 16, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (55, 30, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (56, 9, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (56, 17, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (58, 14, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (58, 16, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (59, 16, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (59, 19, 1, 4000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (60, 18, 2, 4000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (60, 19, 1, 4000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (61, 14, 2, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (61, 18, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (63, 17, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (63, 18, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (63, 19, 1, 4000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (63, 20, 2, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (63, 22, 1, 5000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (64, 6, 1, 3000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (64, 19, 2, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (64, 29, 1, 3200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (68, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (69, 19, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (70, 17, 1, 1000000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (70, 19, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (72, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (73, 19, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (74, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (75, 19, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (77, 19, 1, 980000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (79, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (80, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (81, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (82, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (83, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (84, 8, 1, 1800000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (85, 2, 1, 2200000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (86, 10, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (87, 10, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (88, 10, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (89, 10, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (90, 15, 1, 1600000)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (91, 1, 4, 1800000)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (7, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-02' AS Date), NULL, 0, 5800001, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Mậu Long, Huyện Yên Minh, Tỉnh Hà Giang', NULL, NULL, NULL, N'VNPAY', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (9, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-02' AS Date), NULL, 0, 1800001, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Sơn Vĩ, Huyện Mèo Vạc, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (10, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-03' AS Date), NULL, 0, 1800001, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Nguyễn Trãi, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (11, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-04' AS Date), NULL, 0, 3600000, N'minhttt2004@gmail.com', NULL, N'số 1 , Xã Xuân Nội, Huyện Trùng Khánh, Tỉnh Cao Bằng', NULL, NULL, N'', N'COD', 0)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (14, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-04' AS Date), NULL, 0, 8900000, N'minhttt2004@gmail.com', N'0936345204', N'Số 1, Phường Yên Nghĩa, Quận Hà Đông, Thành phố Hà Nội', NULL, NULL, N'không', N'COD', 0)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (15, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-05' AS Date), NULL, 0, 1260000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Ngọc Hà, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (16, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-05' AS Date), NULL, 0, 5320000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Xín Cái, Huyện Mèo Vạc, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (17, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-05' AS Date), NULL, 0, 4970000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'VNPAY', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (18, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-05' AS Date), NULL, 0, 3892000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'VNPAY', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (19, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-05' AS Date), NULL, 0, 2506000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Ngọc Hà, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'VNPAY', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (21, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 0, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (22, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 5800000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (23, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 3000000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Lũng Thầu, Huyện Đồng Văn, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (24, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-07' AS Date), NULL, 0, 3600000, N'minhttt2004@mail.com', N'0936345204', N'số 3, Phường Trung Liệt, Quận Đống Đa, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (25, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-07' AS Date), NULL, 0, 1960000, N'minhttt200@gmail.com', N'0936345204', N'số 1, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (26, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-07' AS Date), NULL, 0, 7000000, N'minhttt204@gmail.com', N'0936345204', N'Hanoi, Phường Tràng Tiền, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (27, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-07' AS Date), NULL, 0, 7600000, N'minhttt204@gmail.com', N'0936345204', N'Hanoi, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (28, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 1540000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (29, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 1800000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Hàng Bồ, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (30, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-07' AS Date), NULL, 0, 1800000, N'nguyenxuanhanh0440@gmail.com', N'0936345204', N'Hanoi, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (31, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 3200000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Phố Là, Huyện Đồng Văn, Tỉnh Hà Giang', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (32, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-07' AS Date), NULL, 0, 1800000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Hàng Bồ, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (33, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-08' AS Date), NULL, 0, 3600000, N'minhttt204@gmail.com', N'0936345204', N'số 1, Phường Phúc Lợi, Quận Long Biên, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (34, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 1800000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Tân Mai, Quận Hoàng Mai, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (35, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 4800000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Khương Đình, Quận Thanh Xuân, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (36, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (37, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (38, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (39, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (40, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (41, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (42, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (43, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-09' AS Date), NULL, 0, 4000000, N'nguyenxuanhanh040@gmail.com', N'0926310999', N'Hanoi, Xã Đặng Xá, Huyện Gia Lâm, Thành phố Hà Nội', NULL, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (44, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (45, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (46, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (47, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (48, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-08' AS Date), NULL, 0, 7300000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Phường Hàng Buồm, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (49, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-09' AS Date), NULL, 0, 3600000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Ngọc Hà, Thành phố Hà Giang, Tỉnh Hà Giang', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (50, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-09' AS Date), NULL, 0, 2580000, N'minhttt204@gmail.com', N'0936345204', N'số 1, Phường Thổ Quan, Quận Đống Đa, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (51, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-09' AS Date), NULL, 0, 4180000, N'minhttt204@gmail.com', N'0936345204', N'số 1, Phường Đồng Nhân, Quận Hai Bà Trưng, Thành phố Hà Nội', NULL, NULL, N'', N'COD', 0)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (52, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-09' AS Date), NULL, 0, 1800000, N'minhttt204@gmail.com', N'0936345204', N'số 1, Xã Ngọc Hồi, Huyện Thanh Trì, Thành phố Hà Nội', NULL, NULL, N'không', N'VNPay', 0)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (53, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-09' AS Date), NULL, 0, 2500000, N'minhttt204@gmail.com', N'0936345204', N'số 1, Phường Việt Hưng, Quận Long Biên, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (54, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-09' AS Date), NULL, 0, 2580000, N'nguyenxuanhanh0440@gmail.com', N'0936345204', N'Hanoi, Phường Đội Cấn, Quận Ba Đình, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (55, NULL, NULL, NULL, N'Hanh', CAST(N'2025-03-12' AS Date), NULL, 0, 1296300, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Xã Nam Hồng, Huyện Đông Anh, Thành phố Hà Nội', NULL, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (56, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-16' AS Date), NULL, 43500, 4343500, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Chương Dương, Quận Hoàn Kiếm, Thành phố Hà Nội', 500000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (57, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-16' AS Date), NULL, 29400, 1509400, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Giang Biên, Quận Long Biên, Thành phố Hà Nội', 500000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (58, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-16' AS Date), NULL, 32400, 2112400, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Láng Hạ, Quận Đống Đa, Thành phố Hà Nội', 500000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (59, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-16' AS Date), NULL, 44400, 4524400, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Lý Thái Tổ, Quận Hoàn Kiếm, Thành phố Hà Nội', 500000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (60, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-16' AS Date), NULL, 87500, 11587500, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Vân Hà, Huyện Đông Anh, Thành phố Hà Nội', 500000, N'VNPay', NULL, N'VNPay', 2)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (61, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-18' AS Date), NULL, 0, 2980000, N'minhttt2004@gmail.com', N'0936345204', N'yên nghĩa, Xã Hẹ Muông, Huyện Điện Biên, Tỉnh Điện Biên', 1, NULL, NULL, N'COD', 3)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (63, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-18' AS Date), NULL, 0, 12470000, N'minhttt2004@gmail.com', N'0936345204', N'yên nghĩa, Phường Quang Trung, Quận Đống Đa, Thành phố Hà Nội', 5, NULL, NULL, N'COD', 2)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (64, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-18' AS Date), NULL, 0, 8202500, N'minhttt2004@gmail.com', N'0936345204', N'Hanoi, Xã Làng Nhì, Huyện Trạm Tấu, Tỉnh Yên Bái', 1, NULL, N'', N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (65, NULL, 2, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 22000, 953000, NULL, N'0926310999', N'số 1, Phường Lĩnh Nam, Quận Hoàng Mai, Thành phố Hà Nội', 49000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (66, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 31000, 1831000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Khương Đình, Quận Thanh Xuân, Thành phố Hà Nội', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (67, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 31000, 1831000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Tây Mỗ, Quận Nam Từ Liêm, Thành phố Hà Nội', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (68, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 31000, 1831000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Đồng Nhân, Quận Hai Bà Trưng, Thành phố Hà Nội', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (69, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 22000, 1002000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Xuân Tảo, Quận Bắc Từ Liêm, Thành phố Hà Nội', 0, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (70, NULL, 2, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 46905, 1927905, NULL, N'0923610999', N'số 1, Xã Tả Lủng, Huyện Đồng Văn, Tỉnh Hà Giang', 99000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (71, NULL, 2, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 46905, 1927905, NULL, N'0923610999', N'số 1, Xã Tả Lủng, Huyện Đồng Văn, Tỉnh Hà Giang', 99000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (72, NULL, NULL, NULL, N'Xuân Hanh', CAST(N'2025-03-19' AS Date), NULL, 31000, 1831000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Hà Nội', 0, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (73, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 35000, 966000, NULL, N'0936345204', N'số 1, Xã Hồng An, Huyện Bảo Lạc, Tỉnh Cao Bằng', 49000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (74, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 44000, 1844000, NULL, N'0936345204', N'số 1, Xã Chiềng Mai, Huyện Mai Sơn, Tỉnh Sơn La', 0, N'VNPay', N'không', N'VNPay', 0)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (75, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 35000, 966000, NULL, N'0936345204', N'số 1, Xã Bằng Vân, Huyện Ngân Sơn, Tỉnh Bắc Kạn', 49000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (77, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 30000, 961000, NULL, N'0936345204', N'số 1, Xã Chiềng Đen, Thành phố Sơn La, Tỉnh Sơn La', 49000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (79, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 43550, 1753550, NULL, N'0936345204', N'số 1, Xã Thượng Lâm, Huyện Lâm Bình, Tỉnh Tuyên Quang', 90000, N'VNPay', NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (80, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-19' AS Date), NULL, 44000, 1844000, N'minhttt2004@gmail.com', N'0936345204', N'số 1, Xã Bum Tở, Huyện Mường Tè, Tỉnh Lai Châu', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (81, NULL, NULL, NULL, N'hanh', CAST(N'2025-03-20' AS Date), NULL, 44000, 1844000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Xã Huy Hạ, Huyện Phù Yên, Tỉnh Sơn La', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (82, NULL, NULL, NULL, N'hanh', CAST(N'2025-03-20' AS Date), NULL, 44000, 1844000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Xã Huy Hạ, Huyện Phù Yên, Tỉnh Sơn La', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (83, NULL, NULL, NULL, N'hanh', CAST(N'2025-03-20' AS Date), NULL, 44000, 1844000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Xã Huy Hạ, Huyện Phù Yên, Tỉnh Sơn La', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (84, NULL, NULL, NULL, N'hanh', CAST(N'2025-03-24' AS Date), NULL, 44000, 1844000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'số 1, Xã Huy Hạ, Huyện Phù Yên, Tỉnh Sơn La', 0, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (85, NULL, 2, NULL, N'nguyenquangminh', CAST(N'2025-03-25' AS Date), NULL, 32000, 2032000, N'nguyenxuanhanh0440@gmail.com', N'0936345204', N'số 1, Phường Nghĩa Tân, Quận Cầu Giấy, Thành phố Hà Nội', 200000, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (86, NULL, NULL, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-28' AS Date), NULL, 0, 835000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Quản Bạ, Huyện Quản Bạ, Tỉnh Hà Giang', 1, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (87, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-28' AS Date), NULL, 0, 835000, N'minhttt2004@gmail.com', N'0936345204', N'Hanoi, Xã Xuân Nội, Huyện Trùng Khánh, Tỉnh Cao Bằng', 1, NULL, NULL, N'VNPay', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (88, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-28' AS Date), NULL, 0, 830000, N'minhttt2004@gmail.com', N'0936345204', N'Hanoi, Xã Liên Hà, Huyện Đông Anh, Thành phố Hà Nội', 1, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (89, NULL, 2, NULL, N'minhhh', CAST(N'2025-03-28' AS Date), NULL, 35000, 835000, N'minhttt2004@gmail.com', N'0936345204', N'Hanoi, Xã Tú Nang, Huyện Yên Châu, Tỉnh Sơn La', 800000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (90, NULL, NULL, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-28' AS Date), NULL, 35000, 995000, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Ngọc Long, Huyện Yên Minh, Tỉnh Hà Giang', 640000, NULL, NULL, N'COD', 1)
INSERT [dbo].[Orders] ([OrderID], [OrderCode], [CustomerID], [StaffID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], [Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus]) VALUES (91, NULL, NULL, NULL, N'Nguyễn Xuân Hanh', CAST(N'2025-03-28' AS Date), NULL, 78500, 7278500, N'nguyenxuanhanh0440@gmail.com', N'0926310999', N'Hanoi, Xã Sán Xả Hồ, Huyện Hoàng Su Phì, Tỉnh Hà Giang', 0, NULL, NULL, N'VNPay', 8)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductDetail] ON 

INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (1, 1, NULL, N'30ml', NULL, 26, 4, NULL, 0, 1800000, N'P_images/Advanced Night Repair (Serum tái tạo da) 50ml.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (2, 1, NULL, N'50ml', NULL, 11, 1, NULL, 0, 2200000, N'P_images/Advanced Night Repair (Serum tái tạo da) 50ml.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (3, 1, NULL, N'100ml', NULL, 15, NULL, NULL, NULL, 4600000, N'P_images/Advanced Night Repair (Serum tái tạo da) 100ml.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (4, 2, NULL, N'50ml', NULL, 20, NULL, NULL, NULL, 3500000, N'P_images/Revitalizing Supreme+.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (5, 2, NULL, N'75ml', NULL, 11, NULL, NULL, NULL, 4100000, N'P_images/Revitalizing Supreme+.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (6, 3, NULL, N'30ml', NULL, 17, NULL, NULL, NULL, 3000000, N'P_images/Perfectionist Pro.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (7, 3, NULL, N'50ml', NULL, 13, NULL, NULL, NULL, 4300000, N'P_images/Perfectionist Pro.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (8, 4, NULL, N'50ml', NULL, 0, 9, NULL, 0, 1800000, N'P_images/DayWear.png', NULL, 0)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (9, 4, NULL, N'75ml', NULL, 16, NULL, NULL, NULL, 2500000, N'P_images/DayWear.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (10, 5, NULL, N'30ml', N'1N2 Ecru                                          ', 18, NULL, NULL, NULL, 1600000, N'P_images/1N2 Ecru.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (11, 5, NULL, N'30ml', N'1W0 Warm Porcelain                                ', 22, NULL, NULL, NULL, 1600000, N'P_images/1W0 Warm Porcelain.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (12, 5, NULL, N'30ml', N'1W1 Bone                                          ', 14, NULL, NULL, NULL, 1600000, N'P_images/1W1 Bone.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (13, 5, NULL, N'30ml', N'1W2 Sand                                          ', 18, NULL, NULL, NULL, 1600000, N'P_images/1W2 Sand.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (14, 6, NULL, N'30ml', N'3C1 DUSK                                          ', 15, 1, NULL, 0, 1600000, N'P_images/3C1 DUSK.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (15, 6, NULL, N'30ml', N'2C1 PURE BEIGE                                    ', 7, 1, NULL, 0, 1600000, N'P_images/2C1 PURE BEIGE.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (16, 6, NULL, N'30ml', N'3N1 IVORY BEIGE                                   ', 23, 2, NULL, 0, 1600000, N'P_images/3N1 IVORY BEIGE.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (17, 7, NULL, N'7ml', NULL, 34, 1, NULL, 0, 1000000, N'P_images/Sumptuous Extreme Lash Multiplying Volume Mascara (Mascara).png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (18, 8, NULL, NULL, N'Visionary                                         ', 10, 2, NULL, 0, 980000, N'P_images/Visionary.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (19, 8, NULL, NULL, N'Rebellious Rose                                   ', 8, 8, NULL, 0, 980000, N'P_images/Rebellious Rose.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (20, 8, NULL, NULL, N'Red Ego                                           ', 18, NULL, NULL, NULL, 980000, N'P_images/Red Ego.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (21, 8, NULL, NULL, N'No Concessions                                    ', 20, NULL, NULL, NULL, 980000, N'P_images/No Concessions.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (22, 9, NULL, N'30ml', NULL, 21, NULL, NULL, NULL, 3200000, N'P_images/Beautiful Magnolia Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (23, 9, NULL, N'50ml', NULL, 18, NULL, NULL, NULL, 4000000, N'P_images/Beautiful Magnolia Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (24, 9, NULL, N'100ml', NULL, 22, NULL, NULL, NULL, 5000000, N'P_images/Beautiful Magnolia Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (25, 10, NULL, N'30ml', NULL, 14, NULL, NULL, NULL, 3200000, N'P_images/Modern Muse.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (26, 10, NULL, N'50ml', NULL, 19, NULL, NULL, NULL, 4000000, N'P_images/Modern Muse.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (27, 10, NULL, N'100ml', NULL, 11, NULL, NULL, NULL, 5000000, N'P_images/Modern Muse.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (28, 11, NULL, N'30ml', NULL, 15, NULL, NULL, NULL, 3000000, N'P_images/Beautiful Belle Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (29, 11, NULL, N'50ml', NULL, 10, NULL, NULL, NULL, 3200000, N'P_images/Beautiful Belle Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (30, 11, NULL, N'100ml', NULL, 13, NULL, NULL, NULL, 4000000, N'P_images/Beautiful Belle Eau de Parfum Spray.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (31, 12, NULL, N'15ml', NULL, 15, NULL, NULL, NULL, 2860000, N'P_images/Advanced Night Repair Eye Concentrate Matrix Synchronized Multi-Recovery Complex.png', NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (32, 13, NULL, N'15ml', NULL, 26, NULL, NULL, NULL, 2600000, NULL, NULL, 1)
INSERT [dbo].[ProductDetail] ([ID], [ProductID], [IdentityCode], [Size], [Color], [Quantity], [SoldQuantity], [DateCreate], [ImportPrice], [Price], [Image], [Details], [ProductStatus]) VALUES (33, 14, NULL, N'50ml', N'd?                                                ', 30, NULL, NULL, 1800000, 3850000, N'', NULL, 1)
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (1, N'Advanced Night Repair', 1, CAST(N'2025-02-04' AS Date), N'Tái tạo da, giảm nếp nhăn, phục hồi da suốt đêm', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (2, N'Revitalizing Supreme+', 1, CAST(N'2025-02-04' AS Date), N'Dưỡng ẩm, chống lão hóa, giúp da săn chắc', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (3, N'Perfectionist Pro', 1, CAST(N'2025-02-04' AS Date), N'Giảm nếp nhăn và làm mịn da.', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (4, N'DayWear', 1, CAST(N'2025-02-04' AS Date), N'Cung cấp độ ẩm, chống oxy hóa, bảo vệ da', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (5, N'Double Wear Stay-in-Place Foundation', 2, CAST(N'2025-02-04' AS Date), N'Lâu trôi, che khuyết điểm hiệu quả, chống mồ hôi và dầu', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (6, N'Double Wear Stay-in-Place Powder Foundation', 2, CAST(N'2025-02-04' AS Date), N'Phấn nền lâu trôi, mịn màng, kết cấu tự nhiên', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (7, N'Sumptuous Extreme Lash Multiplying Volume Mascara', 2, CAST(N'2025-02-04' AS Date), N'Tạo độ dày và dài cho mi, không bị vón cục', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (8, N'Pure Color Matte Lipstick', 2, CAST(N'2025-02-04' AS Date), N'Son môi lâu trôi, dưỡng ẩm và có màu sắc rực rỡ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (9, N'Beautiful Magnolia Eau de Parfum Spray', 3, CAST(N'2025-02-04' AS Date), N'Nước hoa nữ với hương hoa cỏ ngọt ngào, nhẹ nhàng', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (10, N'Modern Muse', 3, CAST(N'2025-02-04' AS Date), N'Hương thơm quyến rũ, phức hợp từ hoa nhài, hoa hồng, và gỗ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (11, N'Beautiful Belle Eau de Parfum Spray', 3, CAST(N'2025-02-04' AS Date), N'Hương thơm nhẹ nhàng, thanh thoát từ hoa cỏ tự nhiên', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (12, N'Advanced Night Repair Eye Concentrate Matrix Synchronized Multi-Recovery Complex', 4, CAST(N'2025-02-04' AS Date), N'Giảm bọng mắt, quầng thâm, và nếp nhăn vùng mắt', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (13, N'Synchronized Multi-Recovery Eye Cream', 4, CAST(N'2025-02-04' AS Date), N'Dưỡng ẩm, chống lão hóa, làm sáng và săn chắc vùng da quanh mắt', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [Date], [Description], [ProductStatus]) VALUES (14, N'daywear', 1, NULL, N'dưỡng da', 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([VoucherID], [VoucherName], [Discount], [MaxDiscount], [Quantity], [StartDate], [EndDate], [Description], [VoucherStatus]) VALUES (1, N'None', 0, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Voucher] ([VoucherID], [VoucherName], [Discount], [MaxDiscount], [Quantity], [StartDate], [EndDate], [Description], [VoucherStatus]) VALUES (2, N'Discout30', 30, 500000, 97, NULL, NULL, NULL, 1)
INSERT [dbo].[Voucher] ([VoucherID], [VoucherName], [Discount], [MaxDiscount], [Quantity], [StartDate], [EndDate], [Description], [VoucherStatus]) VALUES (4, N'THANKS05', 5, 0, 9995, NULL, NULL, NULL, 1)
INSERT [dbo].[Voucher] ([VoucherID], [VoucherName], [Discount], [MaxDiscount], [Quantity], [StartDate], [EndDate], [Description], [VoucherStatus]) VALUES (5, N'WELCOME02', 20, 200000, 99998, NULL, NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[Voucher] OFF
GO
/****** Object:  Index [UQ__Accounts__349DA5870C0B83B7]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [UQ__Accounts__349DA5870C0B83B7] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Blog__54379E518166C2D8]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [UQ__Blog__54379E518166C2D8] UNIQUE NONCLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Categori__19093A2A80A4EF6C]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Feedback__6A4BEDF7388CC5ED]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Feedback] ADD  CONSTRAINT [UQ__Feedback__6A4BEDF7388CC5ED] UNIQUE NONCLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Reply__C25E4628F7A9317F]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[FeedbackReply] ADD  CONSTRAINT [UQ__Reply__C25E4628F7A9317F] UNIQUE NONCLUSTERED 
(
	[ReplyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Orders__C3905BAE87AF8A35]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [UQ__Orders__C3905BAE87AF8A35] UNIQUE NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ProductD__3214EC26561F0FC4]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[ProductDetail] ADD  CONSTRAINT [UQ__ProductD__3214EC26561F0FC4] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Products__B40CC6ECAA05BAD0]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Slider__24BC9711577E7CC4]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Slider] ADD  CONSTRAINT [UQ__Slider__24BC9711577E7CC4] UNIQUE NONCLUSTERED 
(
	[SliderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Voucher__3AEE79C0E4B42789]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Voucher] ADD  CONSTRAINT [UQ__Voucher__3AEE79C0E4B42789] UNIQUE NONCLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_VoucherName]    Script Date: 3/28/2025 2:27:22 PM ******/
ALTER TABLE [dbo].[Voucher] ADD  CONSTRAINT [UQ_VoucherName] UNIQUE NONCLUSTERED 
(
	[VoucherName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountVoucher]  WITH CHECK ADD  CONSTRAINT [FK_AccountVoucher_Accounts] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[AccountVoucher] CHECK CONSTRAINT [FK_AccountVoucher_Accounts]
GO
ALTER TABLE [dbo].[AccountVoucher]  WITH CHECK ADD  CONSTRAINT [FK_AccountVoucher_Voucher] FOREIGN KEY([VoucherID])
REFERENCES [dbo].[Voucher] ([VoucherID])
GO
ALTER TABLE [dbo].[AccountVoucher] CHECK CONSTRAINT [FK_AccountVoucher_Voucher]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK__Blog__BlogAuthor__5812160E] FOREIGN KEY([BlogAuthor])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK__Blog__BlogAuthor__5812160E]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_BlogCategory] FOREIGN KEY([BlogCategoryID])
REFERENCES [dbo].[BlogCategory] ([BlogCategoryID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_BlogCategory]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories] FOREIGN KEY([RootCategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__Accoun__59FA5E80] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__Accoun__59FA5E80]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__Produc__5AEE82B9] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__Produc__5AEE82B9]
GO
ALTER TABLE [dbo].[FeedbackReply]  WITH CHECK ADD  CONSTRAINT [FK__Reply__AccountID__619B8048] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[FeedbackReply] CHECK CONSTRAINT [FK__Reply__AccountID__619B8048]
GO
ALTER TABLE [dbo].[FeedbackReply]  WITH CHECK ADD  CONSTRAINT [FK__Reply__FeedbackI__628FA481] FOREIGN KEY([FeedbackID])
REFERENCES [dbo].[Feedback] ([FeedbackID])
GO
ALTER TABLE [dbo].[FeedbackReply] CHECK CONSTRAINT [FK__Reply__FeedbackI__628FA481]
GO
ALTER TABLE [dbo].[FlashSale]  WITH CHECK ADD  CONSTRAINT [FK_FlashSale_ProductDetail] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductDetail] ([ID])
GO
ALTER TABLE [dbo].[FlashSale] CHECK CONSTRAINT [FK_FlashSale_ProductDetail]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Order__59063A47] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__Order__59063A47]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Produ__5CD6CB2B] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductDetail] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__Produ__5CD6CB2B]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Customer__5BE2A6F2] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Customer__5BE2A6F2]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Accounts] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Accounts]
GO
ALTER TABLE [dbo].[ProductDetail]  WITH CHECK ADD  CONSTRAINT [FK__ProductDe__Produ__5CD6CB2B] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductDetail] CHECK CONSTRAINT [FK__ProductDe__Produ__5CD6CB2B]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Slider]  WITH CHECK ADD  CONSTRAINT [FK__Slider__SliderAu__6383C8BA] FOREIGN KEY([SliderAuthor])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Slider] CHECK CONSTRAINT [FK__Slider__SliderAu__6383C8BA]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK__Wishlist__Accoun__6477ECF3] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK__Wishlist__Accoun__6477ECF3]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
USE [master]
GO
ALTER DATABASE [SWP] SET  READ_WRITE 
GO
