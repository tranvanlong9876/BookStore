USE [BookStoreManagement]
GO
/****** Object:  Table [dbo].[AccountDetail]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountDetail](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](200) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
	[IDRole] [int] NOT NULL,
 CONSTRAINT [PK_AccountDetail] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountInfo]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountInfo](
	[Username] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](30) NOT NULL,
	[HomeNo] [nvarchar](50) NULL,
	[District] [nvarchar](100) NULL,
	[Gender] [nvarchar](10) NULL,
	[DOB] [date] NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountRole]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountRole](
	[IDRole] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AccountRole] PRIMARY KEY CLUSTERED 
(
	[IDRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountSecurity]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountSecurity](
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[OneTimeCode] [nvarchar](200) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCategory]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BookCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookDetail]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookDetail](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](500) NOT NULL,
	[Title] [nvarchar](300) NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[Author] [nvarchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ImportDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BookDetail] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountCode] [nvarchar](50) NOT NULL,
	[DiscountPercent] [int] NOT NULL,
	[DiscountDescription] [nvarchar](200) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Discount_1] PRIMARY KEY CLUSTERED 
(
	[DiscountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [nvarchar](50) NOT NULL,
	[BookID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PriceEachBook] [float] NOT NULL,
	[PriceTotalBook] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderExecute]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderExecute](
	[OrderID] [nvarchar](50) NOT NULL,
	[StatusChangeFrom] [int] NOT NULL,
	[StatusChangeTo] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[DateOfCreate] [datetime] NOT NULL,
	[Type] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderHeader]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHeader](
	[OrderID] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[OrderTime] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[TotalPrice] [float] NOT NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[DeliveryAddress] [nvarchar](400) NULL,
	[PaymentType] [int] NOT NULL,
	[PaymentID] [varchar](50) NULL,
	[PaidAccount] [nvarchar](200) NULL,
	[PaidAmoundPaypal] [nvarchar](20) NULL,
	[deniedByAdmin] [bit] NULL,
 CONSTRAINT [PK_OrderHeader] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[StatusID] [int] NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[PaymentID] [int] NOT NULL,
	[PaymentName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 3/17/2022 10:50:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[RefundID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentID] [varchar](50) NOT NULL,
	[PaidAccount] [nvarchar](200) NOT NULL,
	[PaidAmoundPaypal] [nvarchar](20) NOT NULL,
	[TimeOccur] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
	[OrderID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Refund] PRIMARY KEY CLUSTERED 
(
	[RefundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'longtran1410', N'569da2a998e561b7b468bac8b8cb9d1194cf45910191a4959b893e5eb75f313c', N'Nguyễn Thành', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'nguyenvantai123', N'e17ff76591040e61659ab713261bbea843c3697511b5471c03124fa6788a592f', N'Nguyễn Văn Tài', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N's2my.nguyen', N'569da2a998e561b7b468bac8b8cb9d1194cf45910191a4959b893e5eb75f313c', N'Nguyễn My', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'tranvanlong9876', N'0655abaac98c144f9feb09dcac528c6a3acc17b19b86b44cd138e2f8b4865d34', N'Trần Văn Long', 1, 1)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'tranvanlong98763', N'e17ff76591040e61659ab713261bbea843c3697511b5471c03124fa6788a592f', N'Tran Van Long', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'tranvanlong98764', N'569da2a998e561b7b468bac8b8cb9d1194cf45910191a4959b893e5eb75f313c', N'Tran Van Long', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'tranvanlong98765', N'569da2a998e561b7b468bac8b8cb9d1194cf45910191a4959b893e5eb75f313c', N'Long Trần', 1, 2)
INSERT [dbo].[AccountDetail] ([Username], [Password], [FullName], [Status], [IDRole]) VALUES (N'vanlongpro14789', N'569da2a998e561b7b468bac8b8cb9d1194cf45910191a4959b893e5eb75f313c', N'Nguyen Tai', 1, 3)
GO
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'tranvanlong9876', N'0349140063', N'118/124', N'Tan Phu', N'M', CAST(N'2000-10-14' AS Date), N'traanvanlongo@gmail.com', N'https://i.ibb.co/fVWXpzL/Anh-12.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'tranvanlong98765', N'0382638255', N'118/125', N'Tan Binh', N'M', CAST(N'2022-03-24' AS Date), N'tranvanlongpro1@gmail.com', N'https://i.ibb.co/fVWXpzL/Anh-12.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N's2my.nguyen', N'0123456789', N'1111', N'Tam', N'F', CAST(N'2000-08-02' AS Date), N'traanvanlongo@gmail1.com', N'https://i.ibb.co/fVWXpzL/Anh-12.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'longtran1410', N'01234444', N'11231', N'112', N'M', CAST(N'2000-08-02' AS Date), N'tranvan1@gmail.com', N'https://i.ibb.co/fVWXpzL/Anh-12.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'tranvanlong98763', N'0382638254', NULL, NULL, N'F', NULL, N'traanvanlongo123@gmail.com', N'https://i.ibb.co/pRsXpC4/Anh-4.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'vanlongpro14789', N'0382638254', N'118/124', N'Tan Phu', N'M', CAST(N'2000-08-02' AS Date), N'tranvanlongo@gmail.com', N'images/default-avatar.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'nguyenvantai123', N'0377504378', N'118/124 Phan Huy Ích', N'Phường 15, Quận Tân Bình', N'M', CAST(N'2022-03-31' AS Date), N'nguyenvantai1234@gmail.com', N'https://i.ibb.co/PQZvjBR/Anh-8.jpg')
INSERT [dbo].[AccountInfo] ([Username], [PhoneNo], [HomeNo], [District], [Gender], [DOB], [Email], [Image]) VALUES (N'tranvanlong98764', N'0349140064', N'118/125', N'Tan Binh', N'M', CAST(N'2000-08-02' AS Date), N'traanvanlongooo@gmail.com', N'images/default-avatar.jpg')
GO
SET IDENTITY_INSERT [dbo].[AccountRole] ON 

INSERT [dbo].[AccountRole] ([IDRole], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[AccountRole] ([IDRole], [RoleName]) VALUES (2, N'User')
INSERT [dbo].[AccountRole] ([IDRole], [RoleName]) VALUES (3, N'Shipper')
SET IDENTITY_INSERT [dbo].[AccountRole] OFF
GO
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0349140062', N'd7a61bb8ed9df77bf791dc965310f854df246005a28fea211a436cba455ad263')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'03491400622456', N'8e03bc435a8e0365e5a8c54444d526c6fb94abd7219cc386a8793d9cd026cdb9')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'09833', N'7d45da69bf79e9abc12729d5881511908d4a88b9f3fad048dc9616d27ecb307d')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0349140062123', N'098c2c07ac48b3aca570a33e4f077cf3564750c7441457c35ad7674d2704b859')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0937707326', N'2a63c997bdb3673a265afcb4fa747818a0709e446fd66e99586c41bd7a7208cf')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0377504378', N'6a1539d31d8c1b03056361ee063174b67ad97176d7d335128bcf107791f39210')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'1241221313', N'66ce1025b771751f5ba39d5b2b66d9aa12ad0e49710af3b2575de8fafd5d2c08')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'21313131321', N'e642f658840e5eb1b128efcf6aff0d4a944c8cb29cc420bdcb1ed08ae8e72e19')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'1231239813192', N'0d392ae3be87cff2b6ceeecabf77bad6616d34190178df6adeb5f228530db3d8')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'123456', N'976e14b5b5a2c771e07762045369f28afb59aeb03a0a35ebedfbe1ac1bfba132')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0382638254', N'96c941c30d7a72e636fb9211d4aca8157a9248a3c88f09614b7ed1f707d6792b')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0382638255', N'e499bbb401a70b1d467e1dfde679675393a9da1773913df5fd464844445d1375')
INSERT [dbo].[AccountSecurity] ([PhoneNumber], [OneTimeCode]) VALUES (N'0982943101', N'344971929da14975ca0b2fcbc62a68774bf43b377edaa4a589c3f5f37c2dad26')
GO
SET IDENTITY_INSERT [dbo].[BookCategory] ON 

INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1, N'Java Desktop')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (2, N'Java Web')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (3, N'Java OOP')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (4, N'Data Structure And Algorithm')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1002, N'.Net And C#')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1003, N'Lập Trình Python')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1004, N'Software Testing')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1005, N'Software Requirement')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1006, N'Programming Fundamental')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1007, N'Internet of Things')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1008, N'E-Commerce')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1009, N'Working In Groups')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1010, N'Cách Ly 14 Ngày')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1011, N'Tiếng Nhật Dekiru')
INSERT [dbo].[BookCategory] ([CategoryID], [CategoryName]) VALUES (1012, N'Java OOP2')
SET IDENTITY_INSERT [dbo].[BookCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[BookDetail] ON 

INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (2, N'https://i.ibb.co/wd061DC/Sach-1.jpg', N'Java Desktop System: Third Edition Paperback', N'What are the usability implications of Java Desktop System actions? Will team members perform Java Desktop System work when assigned and in a timely fashion? Is Supporting Java Desktop System documentation required? If substitutes have been appointed, have they been briefed on the Java Desktop System goals and received regular communications as to the progress to date? Is there any existing Java Desktop System governance structure?

This easy Java Desktop System self-assessment will make you the trusted Java Desktop System domain master by revealing just what you need to know to be fluent and ready for any Java Desktop System challenge.

How do I reduce the effort in the Java Desktop System work to be done to get problems solved? How can I ensure that plans of action include every Java Desktop System task and that every Java Desktop System outcome is in place? How will I save time investigating strategic and tactical options and ensuring Java Desktop System costs are low? How can I deliver tailored Java Desktop System advice instantly with structured going-forward plans?

There’s no better guide through these mind-expanding questions than acclaimed best-selling author Gerard Blokdyk. Blokdyk ensures all Java Desktop System essentials are covered, from every angle: the Java Desktop System self-assessment shows succinctly and clearly that what needs to be clarified to organize the required activities and processes so that Java Desktop System outcomes are achieved.

Contains extensive criteria grounded in past and current successful projects and activities by experienced Java Desktop System practitioners. Their mastery, combined with the easy elegance of the self-assessment, provides its superior value to you in knowing how to ensure the outcome of any efforts in Java Desktop System are maximized with professional results.

Your purchase includes access details to the Java Desktop System self-assessment dashboard download which gives you your dynamically prioritized projects-ready tool and shows you exactly what to do next. Your exclusive instant access details can be found in your book.', N'Gerardus Blokdyk', 1998000, 4, 1, 1, CAST(N'2021-07-05T22:36:52.153' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (4, N'https://i.ibb.co/GnT5GmZ/Sach-2.jpg', N'Object-Oriented Programming and Java', N'Covering the latest in Java technologies, Object-Oriented Programming and Java teaches the subject in a systematic, fundamentals-first approach. It begins with the description of real-world object interaction scenarios and explains how they can be translated, represented and executed using object-oriented programming paradigm. By establishing a solid foundation in the understanding of object-oriented programming concepts and their applications, this book provides readers with the pre-requisites for writing proper object-oriented programs using Java.', N'Danny Poo, Derek Kiong, Swarnalatha Ashok', 980000, 8, 1010, 0, CAST(N'2021-07-14T13:21:53.373' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (10, N'https://i.ibb.co/7zH0XC4/Sach-3.jpg', N'OBJECT ORIENTED PROGRAMMING WITH JAVA', N'This self-readable and highly informative text presents the exhaustive coverage of the concepts of Object Oriented Programming with JAVA. A number of good illustrative examples are provided for each concept supported by well-crafted programs, thus making it useful for even those having no previous knowledge of programming. Starting from the preliminaries of the language and the basic principles of OOP, this textbook moves gradually towards advanced concepts like exception handling, multithreaded programming, GUI support by the language through AWT controls, string handling, file handling and basic utility classes. In addition, the well-planned material in the book', N'M. T. SOMASHEKARA, D. S. GURU, K. S. MANJUNATHA', 480000, 6, 3, 1, CAST(N'2022-03-17T22:36:01.950' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (11, N'https://i.ibb.co/3swVmvm/Sach-4.jpg', N'Web Applications with Javascript or Java', N'Today, web applications are the most important type of software applications. This textbook shows how to design and implement them, using a model-based engineering approach that covers general information management concepts and techniques and the two most relevant technology platforms: JavaScript and Java. The book provides an in-depth tutorial for theory-underpinned and example-based learning by doing it yourself, supported by quiz questions and practice projects. Volume 1 provides an', N'Gerd Wagner, Mircea Diaconescu', 3450000, 8, 2, 1, CAST(N'2021-07-06T12:25:45.247' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (18, N'https://i.ibb.co/JQgBYK1/Sach-8.jpg', N'Data Structures and Algorithms in Java', N'Data Structures and Algorithms in Java, Second Edition is designed to be easy to read and understand although the topic itself is complicated. Algorithms are the procedures that software programs use to manipulate data structures. Besides clear and simple example programs, the author includes a workshop as a small demonstration program executable on a Web browser. The programs demonstrate in graphical form what data structures look like and how they operate. In the second edition, the program is rewritten to improve operation and clarify the algorithms, the example programs are revised to work with the latest version of the Java JDK, and questions and exercises will be added at the end of each chapter making the book even more useful.', N'Robert Lafore', 120000, 0, 4, 1, CAST(N'2021-07-15T07:40:59.150' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (19, N'https://i.ibb.co/P18LWm1/Sach-6.jpg', N'Python Programming: An Introduction to Computer Science', N'Python Programming: An Introduction to Computer Science, 3rd Ed.', N'John Zelle', 1857562, 0, 1003, 1, CAST(N'2021-06-30T22:05:44.003' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (20, N'https://i.ibb.co/NZC7yKX/Sach-7.jpg', N'Lessons Learned in Software Testing: A Context-Driven Approach', N'The world''s leading software testing experts lend you their wisdom and years of experience to help you avoid the most common mistakes in testing software. Each lesson is an assertion related to software testing, followed by an explanation or example that shows you the how, when, and why of the testing lesson. More than just tips, tricks, and pitfalls to avoid, Lessons Learned in Software Testing speeds you through the critical testing phase of the software development project without the extensive trial and error it normally takes to do so. The ultimate resource for software testers and developers at every level of expertise, this guidebook features:
* Over 200 lessons gleaned from over 30 years of combined testing experience
* Tips, tricks, and common pitfalls to avoid by simply reading the book rather than finding out the hard way
* Lessons for all key topic areas, including test design, test management, testing strategies, and bug reporting
* Explanations and examples of each testing trouble spot help illustrate each lesson''s assertion', N'Cem Kaner, Bret Pettichord', 580000, 4, 1004, 1, CAST(N'2021-07-06T07:07:41.630' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (21, N'https://i.ibb.co/6sg4D62/Sach-8.jpg', N'Software Requirements (Developer Best Practices) (3rd Edition)', N'Now in its third edition, this classic guide to software requirements engineering has been fully updated with new topics, examples, and guidance. Two leaders in the requirements community have teamed up to deliver a contemporary set of practices covering the full range of requirements development and management activities on software projects.', N'Karl Wiegers, Joy Beatty', 3400000, 88, 1005, 1, CAST(N'2021-06-27T20:25:47.323' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (22, N'https://i.ibb.co/zVWL1yB/Sach-9.jpg', N'C# 8.0 and .NET Core 3.0 – Modern Cross-Platform Development: Build applications with C#, .NET Core, Entity Framework Core, ASP.NET Core, and ML.NET using Visual Studio Code, 4th Edition', N'In C# 8.0 and .NET Core 3.0 – Modern Cross-Platform Development, Fourth Edition, expert teacher Mark J. Price gives you everything you need to start programming C# applications.

This latest edition uses the popular Visual Studio Code editor to work across all major operating systems. It is fully updated and expanded with new chapters on Content Management Systems (CMS) and machine learning with ML.NET.

The book covers all the topics you need. Part 1 teaches the fundamentals of C#, including object-oriented programming, and new C# 8.0 features such as nullable reference types, simplified switch pattern matching, and default interface methods. Part 2 covers the .NET Standard APIs, such as managing and querying data, monitoring and improving performance, working with the filesystem, async streams, serialization, and encryption. Part 3 provides examples of cross-platform applications you can build and deploy, such as web apps using ASP.NET Core or mobile apps using Xamarin.Forms. The book introduces three technologies for building Windows desktop applications including Windows Forms, Windows Presentation Foundation (WPF), and Universal Windows Platform (UWP) apps, as well as web applications, web services, and mobile apps.', N'Mark J. Price', 892000, 1, 1002, 1, CAST(N'2021-06-30T22:02:51.743' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (23, N'https://i.ibb.co/7QS649x/Sach10.jpg', N'Computer Programming for Beginners: Fundamentals of Programming Terms and Concepts', N'If you are a newcomer to programming it’s easy to get lost in the technical jargon, before even getting to the language you want to learn.
What are statements, operators, and functions?
How to structure, build and deploy a program?
What is functional programming and object oriented programming?
How to store, manage and exchange data?
These are topics many programming guides don’t cover, as they are assumed to be general knowledge to most developers. That is why this guide has been created. It is the ultimate primer to all programming languages.', N'Nathan Clark', 69000, 8, 1006, 1, CAST(N'2021-07-05T22:38:39.750' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (24, N'https://i.ibb.co/RTyh8zJ/Sach-11.jpg', N'The Internet of Things (MIT Press Essential Knowledge series)', N'We turn on the lights in our house from a desk in an office miles away. Our refrigerator alerts us to buy milk on the way home. A package of cookies on the supermarket shelf suggests that we buy it, based on past purchases. The cookies themselves are on the shelf because of a “smart” supply chain. When we get home, the thermostat has already adjusted the temperature so that it''s toasty or bracing, whichever we prefer. This is the Internet of Things―a networked world of connected devices, objects, and people. In this book, Samuel Greengard offers a guided tour through this emerging world and how it will change the way we live and work.', N'Samuel Greengard', 690000, 4, 1007, 1, CAST(N'2021-07-06T12:29:19.653' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (25, N'https://i.ibb.co/WDdN2qR/Sach-12.jpg', N'The Complete E-Commerce Book: Design, Build & Maintain a Successful Web-based Business', N'The Complete E-Commerce Book offers a wealth of information on how to design, build and maintain a successful web-based business.... Many of the chapters are filled with advice and information on how to incorporate current e-business principles', N'Janice Reynolds', 4490000, 5, 1008, 1, CAST(N'2021-07-06T12:30:23.223' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (26, N'https://i.ibb.co/683frvP/Sach-13.jpg', N'Working in Groups: Communication Principles and Strategies -- Books a la Carte (7th Edition)', N'A practical approach that helps students learn how to work together in groups successfully
Working in Groups provides students with practical strategies, built on theory and research, for communicating and working successfully in groups. Utilizing the concept of balance as a unifying metaphor, authors Isa Engleberg and Dianna Wynn help students acquire the tools to apply group communication theories, methods, and skills effectively–helping them become more valuable and ethical group members. The Seventh Edition offers coverage of fresh topics as well as a new closing chapter on group presentations that better helps students master this key skill.
', N'Isa N. Engleberg', 2153000, 8, 1009, 0, CAST(N'2021-07-06T12:53:47.323' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (27, N'https://i.ibb.co/Bw6d6sF/Sach-Tieng-Nhat.jpg', N'Dekiru Nihongo Sơ Cấp – Giáo trình tiếng Nhật thực hành', N'Dekiru Nihongo Sơ Cấp là giáo trình tiếng Nhật luyện hội thoại giúp bạn nâng cao khả năng giao tiếp. Sách giúp bạn nâng cao khả năng truyền đạt ý tưởng, suy nghĩ của bản thân.

Giáo trình Dekiru Nihongo Sơ Cấp gồm 15 bài học. Mỗi bài học bao gồm nhiều chủ đề khác nhau trong đời sống như: Đồ ăn – Bữa ăn; Thời khóa biểu; Thành phố- Đất nước của tôi; Ngày nghỉ;…', N'Tiếng Nhật', 580000, 48, 1011, 1, CAST(N'2021-07-14T13:24:20.973' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (28, N'https://i.ibb.co/mzRG1jk/Sach10.jpg', N'Sách 12', N'Sách đẹp', N'Cem Kaner, Bret Pettichord', 580000, 10, 1012, 0, CAST(N'2022-03-05T11:54:15.373' AS DateTime))
INSERT [dbo].[BookDetail] ([BookID], [Image], [Title], [Description], [Author], [Price], [Quantity], [CategoryID], [Status], [ImportDate]) VALUES (29, N'https://i.ibb.co/NYy1r3J/Sach-14.jpg', N'The E-Commerce Book', N'New in the Second EditionContains over 60% new materialComplete and extensive glossary will be addedComplete revision and update of the security chapter (reflecting the recent Yahoo experience)Strengthened coverage of E-Business to BusinessIncreased and redesigned case studiesIncreased European and international coverageRevised, expanded, and enhanced illustrationsNew, attractive text design with features such as margin notesIncreased size of tables containing website contactsRedesigned cover', N'Steffano Korper, Juanita Ellis', 880000, 4, 1008, 1, CAST(N'2022-03-17T22:37:54.490' AS DateTime))
SET IDENTITY_INSERT [dbo].[BookDetail] OFF
GO
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'DISCOUNT001', 1, N'Giảm giá 1% giá trị đơn hàng', CAST(N'2021-07-03T10:46:52.573' AS DateTime), CAST(N'2022-07-15T06:47:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'FREESHIP15K', 15, N'Giảm giá 15% giá trị đơn hàng', CAST(N'2021-07-05T22:36:06.037' AS DateTime), CAST(N'2021-07-29T22:36:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'FREESHIP500', 50, N'Giảm giá 50% đơn hàng', CAST(N'2021-07-14T13:25:06.377' AS DateTime), CAST(N'2021-07-23T13:25:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'FREESHIP50K', 10, N'Giảm giá 10% giá trị đơn', CAST(N'2021-07-15T07:42:01.067' AS DateTime), CAST(N'2021-07-29T07:41:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'GIAMGIA20', 20, N'Giảm giá 20% giá trị đơn hàng', CAST(N'2021-06-30T21:53:49.603' AS DateTime), CAST(N'2022-07-08T21:52:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'GIAMGIA50', 50, N'Giảm giá 50% giá trị đơn hàng', CAST(N'2021-06-30T00:00:00.000' AS DateTime), CAST(N'2021-07-30T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'GIAMGIA501', 50, N'Giảm giá 100%', CAST(N'2022-02-25T09:44:16.467' AS DateTime), CAST(N'2022-03-12T09:44:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'GIAMGIA99', 99, N'Sốc, giảm luôn 99% giá trị đơn hàng', CAST(N'2021-07-03T10:37:00.000' AS DateTime), CAST(N'2021-07-10T10:37:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'GIAMGIA990', 50, N'Giảm giá 50% giá trị đơn', CAST(N'2022-03-17T22:38:19.047' AS DateTime), CAST(N'2022-03-24T22:38:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'HAOQUANG60', 60, N'Giảm giá 60% giá trị đơn hàng, tranh thủ ngay!', CAST(N'2021-07-06T12:54:12.077' AS DateTime), CAST(N'2021-07-31T12:54:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'HAOQUANG70', 70, N'Giảm giá 70% giá trị đơn hàng', CAST(N'2021-07-06T12:31:11.457' AS DateTime), CAST(N'2021-07-27T12:30:00.000' AS DateTime), 0)
INSERT [dbo].[Discount] ([DiscountCode], [DiscountPercent], [DiscountDescription], [CreateDate], [ExpireDate], [Status]) VALUES (N'SOCNGAY99', 99, N'Giảm giá 99%, còn gì hơn nữa cha', CAST(N'2021-07-06T12:59:34.847' AS DateTime), CAST(N'2021-08-07T12:59:00.000' AS DateTime), 0)
GO
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-111629-791000', 18, 2, 99800, 199600)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-111629-791000', 10, 2, 450000, 900000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-111629-791000', 11, 3, 3350000, 10050000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-112412-553970', 18, 1, 99800, 99800)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-112412-553970', 20, 1, 580000, 580000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-112412-553970', 22, 2, 892000, 1784000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-112412-553970', 10, 1, 450000, 450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-112412-553970', 11, 1, 3350000, 3350000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-224251-775834', 18, 1, 99800, 99800)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-05072021-224251-775834', 10, 1, 480000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-063151-730012', 21, 1, 3400000, 3400000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-063151-730012', 22, 5, 892000, 4460000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-063151-730012', 23, 1, 69000, 69000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-065528-513049', 21, 3, 3400000, 10200000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-065528-513049', 23, 2, 69000, 138000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-065557-426686', 23, 2, 69000, 138000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-065618-258060', 20, 2, 580000, 1160000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-065618-258060', 22, 3, 892000, 2676000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-123452-770536', 22, 3, 892000, 2676000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-123452-770536', 24, 3, 690000, 2070000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-123452-770536', 25, 3, 4490000, 13470000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 18, 4, 99800, 399200)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 2, 5, 1998000, 9990000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 19, 10, 1857562, 18575620)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 20, 10, 580000, 5800000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 4, 2, 950000, 1900000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 21, 2, 3400000, 6800000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 22, 1, 892000, 892000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 24, 1, 690000, 690000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 25, 1, 4490000, 4490000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 10, 1, 480000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 26, 10, 2153000, 21530000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-125635-444145', 11, 5, 3450000, 17250000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-130007-296724', 24, 6, 690000, 4140000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-130007-296724', 25, 1, 4490000, 4490000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-130007-296724', 26, 10, 2153000, 21530000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-134803-498177', 10, 1, 480000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-134803-498177', 11, 1, 3450000, 3450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-191520-636252', 24, 1, 690000, 690000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-191520-636252', 25, 1, 4490000, 4490000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06072021-191520-636252', 26, 1, 2153000, 2153000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-14072021-132627-658347', 22, 3, 892000, 2676000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-14072021-132627-658347', 10, 1, 480000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-14072021-132627-658347', 27, 2, 580000, 1160000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-14072021-132627-658347', 11, 1, 3450000, 3450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-15072021-074322-634121', 18, 1, 120000, 120000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-15072021-074322-634121', 22, 1, 892000, 892000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-15072021-074322-634121', 11, 1, 3450000, 3450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-25022022-094459-962577', 18, 4, 120000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-25022022-094459-962577', 10, 1, 480000, 480000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-25022022-094459-962577', 11, 1, 3450000, 3450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-28022022-092806-530574', 19, 1, 1857562, 1857562)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-28022022-092806-530574', 20, 5, 580000, 2900000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-28022022-092806-530574', 23, 1, 69000, 69000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06032022-145305-106160', 19, 1, 1857562, 1857562)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-06032022-145305-106160', 20, 2, 580000, 1160000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-09032022-125157-546223', 19, 1, 1857562, 1857562)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-09032022-125157-546223', 20, 1, 580000, 580000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-10032022-114845-349952', 19, 1, 1857562, 1857562)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-10032022-114845-349952', 11, 1, 3450000, 3450000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-17032022-224041-431436', 22, 1, 892000, 892000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-17032022-224041-431436', 23, 1, 69000, 69000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-17032022-224041-431436', 29, 1, 880000, 880000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-17032022-224355-567757', 19, 1, 1857562, 1857562)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [Quantity], [PriceEachBook], [PriceTotalBook]) VALUES (N'VN-17032022-224355-567757', 20, 1, 580000, 580000)
GO
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-09032022-125157-546223', 1, 5, N'Không muốn mua nữa.', N'tranvanlong98765', CAST(N'2022-03-10T11:24:03.707' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-09032022-125157-546223', 5, 5, N'Đơn hàng đã được tự động hủy thành công, chúng tôi sẽ xử lý và hoàn tiền (nếu có) cho bạn trong 24h đồng hồ.', N'tranvanlong98765', CAST(N'2022-03-10T11:25:03.707' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-28022022-092806-530574', 1, 5, N'tranvanlong98765đã yêu cầu hủy dơn hàng với lý do: Đổi ý không muốn mua nữa.', N'tranvanlong98765', CAST(N'2022-03-10T11:47:00.733' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-28022022-092806-530574', 5, 5, N'Đơn hàng đã được tự động hủy thành công, chúng tôi sẽ xử lý và hoàn tiền (nếu có) cho bạn trong 24h đồng hồ.', N'System', CAST(N'2022-03-10T11:48:00.733' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 1, 1, N'Đơn hàng đã đặt thành công, vui lòng chờ người bán gửi hàng nhé!', N'tranvanlong98765', CAST(N'2022-03-10T11:48:45.783' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 1, 1, N'Chúng tôi đã tiếp nhận đơn hàng và sẽ tiến hành giao vào ngày mai.', N'vanlongpro14789', CAST(N'2022-03-10T11:49:51.100' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 1, 2, N'Bắt đầu giao hàng.', N'vanlongpro14789', CAST(N'2022-03-10T11:50:04.757' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 2, 6, N'Long Trần đã yêu cầu hủy dơn hàng với lý do: Đổi ý không muốn mua nữa.', N'tranvanlong98765', CAST(N'2022-03-10T11:50:39.897' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 6, 6, N'Đơn hàng đã được gửi yêu cầu hủy đến quản trị viên, bạn vui lòng chờ chúng tôi duyệt nhé', N'System', CAST(N'2022-03-10T11:51:39.897' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-10032022-114845-349952', 6, 4, N'Yêu cầu hủy đơn hàng của bạn đã được chấp nhận, đồng thời Shipper tiến hành quá trình trả hàng.', N'Trần Văn Long', CAST(N'2022-03-13T11:18:34.070' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-17032022-224041-431436', 1, 1, N'Đơn hàng đã đặt thành công, vui lòng chờ người bán gửi hàng nhé!', N'tranvanlong98765', CAST(N'2022-03-17T22:40:41.577' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-17032022-224041-431436', 1, 1, N'Đơn hàng đang được chuẩn bị giao.', N'vanlongpro14789', CAST(N'2022-03-17T22:41:33.943' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-17032022-224041-431436', 1, 2, N'Tiến hành giao hàng.', N'vanlongpro14789', CAST(N'2022-03-17T22:41:44.663' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-17032022-224041-431436', 2, 3, N'Đơn hàng đã được giao thành công.', N'vanlongpro14789', CAST(N'2022-03-17T22:41:58.193' AS DateTime), 1)
INSERT [dbo].[OrderExecute] ([OrderID], [StatusChangeFrom], [StatusChangeTo], [Description], [Username], [DateOfCreate], [Type]) VALUES (N'VN-17032022-224355-567757', 1, 1, N'Đơn hàng đã đặt thành công, vui lòng chờ người bán gửi hàng nhé!', N'nguyenvantai123', CAST(N'2022-03-17T22:43:55.943' AS DateTime), 1)
GO
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-05072021-111629-791000', N'tranvanlong98765', CAST(N'2021-07-05T11:16:29.983' AS DateTime), 1, 111496, N'GIAMGIA99', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'34Y480778R332390B', N'sb-wkjot6009751@personal.example.com', N'4.85', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-05072021-112412-553970', N'longtran1410', CAST(N'2021-07-05T11:24:12.410' AS DateTime), 1, 3131899.75, N'GIAMGIA50', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'2UB03198WX7109922', N'sb-wkjot6009751@personal.example.com', N'136.17', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-05072021-224251-775834', N'tranvanlong98765', CAST(N'2021-07-05T22:42:51.940' AS DateTime), 1, 492830, N'FREESHIP15K', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'95R115760J3404213', N'sb-wkjot6009751@personal.example.com', N'21.43', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06032022-145305-106160', N'tranvanlong98764', CAST(N'2022-03-06T14:53:05.930' AS DateTime), 1, 3017562, NULL, N'118/125 Tan Binh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-063151-730012', N'tranvanlong98765', CAST(N'2021-07-06T06:31:51.293' AS DateTime), 1, 7929000, NULL, N'Ngã 5 Chuồng Chó Gần Quang Trung', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-065528-513049', N'tranvanlong98765', CAST(N'2021-07-06T06:55:28.763' AS DateTime), 1, 10338000, NULL, N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-065557-426686', N'tranvanlong98765', CAST(N'2021-07-06T06:55:57.843' AS DateTime), 1, 138000, NULL, N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-065618-258060', N'tranvanlong98765', CAST(N'2021-07-06T06:56:18.240' AS DateTime), 1, 3836000, NULL, N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-123452-770536', N'longtran1410', CAST(N'2021-07-06T12:34:52.580' AS DateTime), 1, 5464800, N'HAOQUANG70', N'Ngã 5 Chuồng Chó Hẻm 48 Bùi Thị Xuân', 2, N'9VY70395PN9563921', N'sb-wkjot6009751@personal.example.com', N'237.60', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-125635-444145', N's2my.nguyen', CAST(N'2021-07-06T12:56:35.850' AS DateTime), 1, 35518724, N'HAOQUANG60', N'Ngã 5 Chuồng Chó Hẻm 48 Bùi Thị Xuân', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-130007-296724', N's2my.nguyen', CAST(N'2021-07-06T13:00:07.850' AS DateTime), 1, 301598, N'SOCNGAY99', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'1UL55228XA9078135', N'sb-wkjot6009751@personal.example.com', N'13.11', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-134803-498177', N'tranvanlong98765', CAST(N'2021-07-06T13:48:03.047' AS DateTime), 1, 3930000, NULL, N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-06072021-191520-636252', N'tranvanlong98765', CAST(N'2021-07-06T19:15:20.670' AS DateTime), 1, 5866400, N'GIAMGIA20', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-09032022-125157-546223', N'tranvanlong98765', CAST(N'2022-03-09T12:51:57.787' AS DateTime), 5, 2413186.5, N'DISCOUNT001', N'118/125 Tan Binh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-10032022-114845-349952', N'tranvanlong98765', CAST(N'2022-03-10T11:48:45.783' AS DateTime), 4, 5307562, NULL, N'118/125 Tan Binh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-14072021-132627-658347', N'tranvanlong98765', CAST(N'2021-07-14T13:26:27.537' AS DateTime), 1, 3883000, N'FREESHIP500', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'26B55119L07193830', N'sb-wkjot6009751@personal.example.com', N'168.83', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-15072021-074322-634121', N'tranvanlong98765', CAST(N'2021-07-15T07:43:22.160' AS DateTime), 1, 4015800, N'FREESHIP50K', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'53C15408BJ613812B', N'sb-wkjot6009751@personal.example.com', N'174.60', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-17032022-224041-431436', N'tranvanlong98765', CAST(N'2022-03-17T22:40:41.577' AS DateTime), 3, 920500, N'GIAMGIA990', N'118/125 Tan Binh', 2, N'75X43757U8024472H', N'sb-wkjot6009751@personal.example.com', N'40.02', 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-17032022-224355-567757', N'nguyenvantai123', CAST(N'2022-03-17T22:43:55.943' AS DateTime), 1, 2437562, NULL, N'118/124 Phan Huy Ích Phường 15, Quận Tân Bình', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-25022022-094459-962577', N'tranvanlong98765', CAST(N'2022-02-25T09:44:59.307' AS DateTime), 1, 2205000, N'GIAMGIA501', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[OrderHeader] ([OrderID], [Username], [OrderTime], [Status], [TotalPrice], [DiscountCode], [DeliveryAddress], [PaymentType], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [deniedByAdmin]) VALUES (N'VN-28022022-092806-530574', N'tranvanlong98765', CAST(N'2022-02-28T09:28:06.837' AS DateTime), 5, 3861249.5, N'GIAMGIA20', N'118/124 Phan Huy Ích Phường 15, Tân bình, Thành Phố Hồ Chí Minh', 2, N'4RX91428888985223', N'sb-wkjot6009751@personal.example.com', N'167.88', 0)
GO
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (1, N'Chờ Lấy Hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (2, N'Đang Giao Hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (3, N'Đã Giao Hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (4, N'Đang Trả Hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (5, N'Đã Hủy Đơn Hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [StatusName]) VALUES (6, N'Đang Xem Xét Hủy Đơn')
GO
INSERT [dbo].[PaymentMethod] ([PaymentID], [PaymentName]) VALUES (1, N'Thanh Toán Khi Nhận Hàng')
INSERT [dbo].[PaymentMethod] ([PaymentID], [PaymentName]) VALUES (2, N'Paypal (Đã Thanh Toán)')
GO
SET IDENTITY_INSERT [dbo].[Refund] ON 

INSERT [dbo].[Refund] ([RefundID], [PaymentID], [PaidAccount], [PaidAmoundPaypal], [TimeOccur], [Status], [OrderID]) VALUES (1002, N'4RX91428888985223', N'sb-wkjot6009751@personal.example.com', N'167.88', CAST(N'2022-03-10T11:47:00.747' AS DateTime), 0, N'VN-28022022-092806-530574')
SET IDENTITY_INSERT [dbo].[Refund] OFF
GO
ALTER TABLE [dbo].[AccountDetail]  WITH CHECK ADD  CONSTRAINT [FK_AccountDetail_AccountRole] FOREIGN KEY([IDRole])
REFERENCES [dbo].[AccountRole] ([IDRole])
GO
ALTER TABLE [dbo].[AccountDetail] CHECK CONSTRAINT [FK_AccountDetail_AccountRole]
GO
ALTER TABLE [dbo].[AccountInfo]  WITH CHECK ADD  CONSTRAINT [FK_AccountInfo_AccountDetail] FOREIGN KEY([Username])
REFERENCES [dbo].[AccountDetail] ([Username])
GO
ALTER TABLE [dbo].[AccountInfo] CHECK CONSTRAINT [FK_AccountInfo_AccountDetail]
GO
ALTER TABLE [dbo].[BookDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookDetail_BookCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[BookCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[BookDetail] CHECK CONSTRAINT [FK_BookDetail_BookCategory]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_BookDetail] FOREIGN KEY([BookID])
REFERENCES [dbo].[BookDetail] ([BookID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_BookDetail]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_OrderHeader] FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderHeader] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_OrderHeader]
GO
ALTER TABLE [dbo].[OrderExecute]  WITH CHECK ADD  CONSTRAINT [FK_OrderExecuteCancel_OrderHeader] FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderHeader] ([OrderID])
GO
ALTER TABLE [dbo].[OrderExecute] CHECK CONSTRAINT [FK_OrderExecuteCancel_OrderHeader]
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_AccountDetail] FOREIGN KEY([Username])
REFERENCES [dbo].[AccountDetail] ([Username])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_AccountDetail]
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_Discount] FOREIGN KEY([DiscountCode])
REFERENCES [dbo].[Discount] ([DiscountCode])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_Discount]
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_OrderStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_OrderStatus]
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_PaymentMethod] FOREIGN KEY([PaymentType])
REFERENCES [dbo].[PaymentMethod] ([PaymentID])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_PaymentMethod]
GO
