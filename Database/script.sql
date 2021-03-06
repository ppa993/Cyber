USE [master]
GO
/****** Object:  Database [Cyber]    Script Date: 09/04/2015 00:42:02 ******/
CREATE DATABASE [Cyber] ON  PRIMARY 
( NAME = N'Cyber', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Cyber.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cyber_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Cyber_log.LDF' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Cyber] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cyber].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cyber] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Cyber] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Cyber] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Cyber] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Cyber] SET ARITHABORT OFF
GO
ALTER DATABASE [Cyber] SET AUTO_CLOSE ON
GO
ALTER DATABASE [Cyber] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Cyber] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Cyber] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Cyber] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Cyber] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Cyber] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Cyber] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Cyber] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Cyber] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Cyber] SET  ENABLE_BROKER
GO
ALTER DATABASE [Cyber] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Cyber] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Cyber] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Cyber] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Cyber] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Cyber] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Cyber] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Cyber] SET  READ_WRITE
GO
ALTER DATABASE [Cyber] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Cyber] SET  MULTI_USER
GO
ALTER DATABASE [Cyber] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Cyber] SET DB_CHAINING OFF
GO
USE [Cyber]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Language] ON
INSERT [dbo].[Language] ([Id], [Name]) VALUES (1, N'English')
INSERT [dbo].[Language] ([Id], [Name]) VALUES (2, N'Việt Nam')
INSERT [dbo].[Language] ([Id], [Name]) VALUES (3, N'日本')
SET IDENTITY_INSERT [dbo].[Language] OFF
/****** Object:  Table [dbo].[Relationship_Type]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Relationship_Type](
	[RelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cyber_Relationship_Type] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Relationship_Type] ON
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (1, N'Single')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (2, N'Engaged')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (3, N'Married')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (4, N'Divorced')
SET IDENTITY_INSERT [dbo].[Relationship_Type] OFF
/****** Object:  Table [dbo].[Post_Type]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post_Type](
	[PostTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PostTypeName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Cyber_Post_Type] PRIMARY KEY CLUSTERED 
(
	[PostTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Post_Type] ON
INSERT [dbo].[Post_Type] ([PostTypeID], [PostTypeName]) VALUES (1, N'Status')
INSERT [dbo].[Post_Type] ([PostTypeID], [PostTypeName]) VALUES (2, N'Photo')
SET IDENTITY_INSERT [dbo].[Post_Type] OFF
/****** Object:  Table [dbo].[Role_Type]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role_Type](
	[RoleTypeID] [int] NOT NULL,
	[RoleTypeName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Cyber_Role_Type] PRIMARY KEY CLUSTERED 
(
	[RoleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification_Type]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notification_Type](
	[NotificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationTypeName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Cyber_Notification_Type] PRIMARY KEY CLUSTERED 
(
	[NotificationTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Notification_Type] ON
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (1, N'Post')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (2, N'CommentMyPost')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (3, N'CommentOthers')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (4, N'LikeMyPost')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (5, N'LikeMyComment')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (6, N'AcceptFriendRequest')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (7, N'CancelFriendRequest')
SET IDENTITY_INSERT [dbo].[Notification_Type] OFF
/****** Object:  Table [dbo].[Visible_Type]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Visible_Type](
	[VisibleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VisibleTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cyber_Visible_Type] PRIMARY KEY CLUSTERED 
(
	[VisibleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Visible_Type] ON
INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (1, N'Public')
INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (2, N'Friend')
INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (3, N'Private')
SET IDENTITY_INSERT [dbo].[Visible_Type] OFF
/****** Object:  Table [dbo].[User]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [nvarchar](128) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[BirthDay] [date] NOT NULL,
	[Gender] [bit] NOT NULL,
	[Relationship] [int] NOT NULL,
	[About] [nvarchar](max) NULL,
	[Email] [varchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Work] [nvarchar](255) NULL,
	[ContactNumber] [varchar](50) NULL,
	[Studied] [nvarchar](255) NULL,
 CONSTRAINT [PK_Cyber_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [UserName], [BirthDay], [Gender], [Relationship], [About], [Email], [Address], [Work], [ContactNumber], [Studied]) VALUES (N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'An', N'Phạm', N'user1', CAST(0xA2110B00 AS Date), 1, 1, NULL, N'user1@gmail.com', NULL, NULL, NULL, NULL)
/****** Object:  Table [dbo].[ChatBox]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatBox](
	[Id] [nvarchar](128) NOT NULL,
	[FromUseId] [nvarchar](128) NULL,
	[ToUseId] [nvarchar](128) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[AlbumId] [nvarchar](128) NOT NULL,
	[CreatedUserId] [nvarchar](128) NULL,
	[AlbumName] [nvarchar](256) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Album] ([AlbumId], [CreatedUserId], [AlbumName], [CreatedDate], [Deleted], [DeletedDate]) VALUES (N'avatare640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'Avatar', CAST(0x0000A5030007FA7E AS DateTime), 0, NULL)
INSERT [dbo].[Album] ([AlbumId], [CreatedUserId], [AlbumName], [CreatedDate], [Deleted], [DeletedDate]) VALUES (N'covere640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'Cover', CAST(0x0000A5030007FA7E AS DateTime), 0, NULL)
INSERT [dbo].[Album] ([AlbumId], [CreatedUserId], [AlbumName], [CreatedDate], [Deleted], [DeletedDate]) VALUES (N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'Uploat', CAST(0x0000A5030007FA7E AS DateTime), 0, NULL)
/****** Object:  Table [dbo].[CalendarEvents]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CalendarEvents](
	[EventID] [varchar](50) NOT NULL,
	[EventTitle] [nvarchar](255) NOT NULL,
	[EventDate] [date] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_CalendarEvents] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notification](
	[UserID] [nvarchar](128) NOT NULL,
	[NotificationID] [varchar](50) NOT NULL,
	[NotificationType] [int] NOT NULL,
	[NotificationContent] [nvarchar](255) NOT NULL,
	[NotificationItemID] [nvarchar](255) NOT NULL,
	[NotificationDate] [datetime] NOT NULL,
	[Seen] [bit] NOT NULL,
 CONSTRAINT [PK_Cyber_Notification_1] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MySetting]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MySetting](
	[SettingID] [varchar](50) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[DefaultMyPostVisibility] [int] NOT NULL,
	[DefaultOtherPostVisibility] [int] NOT NULL,
	[AllowOtherToPost] [bit] NOT NULL,
	[ShowBirthday] [int] NOT NULL,
 CONSTRAINT [PK_MySetting] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[MySetting] ([SettingID], [UserID], [DefaultMyPostVisibility], [DefaultOtherPostVisibility], [AllowOtherToPost], [ShowBirthday]) VALUES (N'038f5d72-52f0-4f83-9b1c-2371724fb395', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 2, 2, 1, 1)
/****** Object:  Table [dbo].[MyEvents]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MyEvents](
	[EventID] [varchar](50) NOT NULL,
	[EventTitle] [nvarchar](255) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MyEvents] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FriendList]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendList](
	[Id] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[FriendList] ([Id], [UserId], [CreatedDate]) VALUES (N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5020120212C AS DateTime))
/****** Object:  Table [dbo].[Role]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[UserID] [nvarchar](128) NOT NULL,
	[RoleType] [int] NOT NULL,
	[AssignedDate] [datetime] NOT NULL,
	[AssignedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Cyber_Role] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reports](
	[ReportID] [varchar](50) NOT NULL,
	[ReportType] [bit] NOT NULL,
	[ReportItem] [varchar](50) NOT NULL,
	[ReportContent] [nvarchar](max) NULL,
	[Reporter] [nvarchar](128) NOT NULL,
	[ReportedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[PostID] [varchar](50) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[PostedOn] [nvarchar](128) NOT NULL,
	[PostType] [int] NOT NULL,
	[PostContent] [nvarchar](max) NOT NULL,
	[PostedDate] [datetime] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[VisibleType] [int] NOT NULL,
 CONSTRAINT [PK_Cyber_Post_1] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Post] ([PostID], [UserID], [PostedOn], [PostType], [PostContent], [PostedDate], [LastModified], [VisibleType]) VALUES (N'1c54a36acc0c44afb270ab71ac350132', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 1, N'it''s me !', CAST(0x0000A503006BC16C AS DateTime), CAST(0x0000A503006BC16C AS DateTime), 2)
INSERT [dbo].[Post] ([PostID], [UserID], [PostedOn], [PostType], [PostContent], [PostedDate], [LastModified], [VisibleType]) VALUES (N'789d7e63a1164c28878541e404435f80', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 1, N'xx', CAST(0x0000A50700E1D121 AS DateTime), CAST(0x0000A50700E1D121 AS DateTime), 2)
INSERT [dbo].[Post] ([PostID], [UserID], [PostedOn], [PostType], [PostContent], [PostedDate], [LastModified], [VisibleType]) VALUES (N'bd33b743391a4a33ba11a2dc04ef57bf', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 1, N'áds', CAST(0x0000A50300BE6987 AS DateTime), CAST(0x0000A50300BE6987 AS DateTime), 2)
INSERT [dbo].[Post] ([PostID], [UserID], [PostedOn], [PostType], [PostContent], [PostedDate], [LastModified], [VisibleType]) VALUES (N'cfd676a3a85e4d3dbe534efd028ba799', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 1, N'ahah', CAST(0x0000A503006BF0C8 AS DateTime), CAST(0x0000A503006BF0C8 AS DateTime), 2)
INSERT [dbo].[Post] ([PostID], [UserID], [PostedOn], [PostType], [PostContent], [PostedDate], [LastModified], [VisibleType]) VALUES (N'd4cd9f33e4dd4d789b25e47548bb3594', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', 1, N'aaa', CAST(0x0000A50700DE9B07 AS DateTime), CAST(0x0000A50700DE9B07 AS DateTime), 2)
/****** Object:  Table [dbo].[PostLike]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PostLike](
	[PostLikeID] [varchar](50) NOT NULL,
	[PostID] [varchar](50) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_PostLike] PRIMARY KEY CLUSTERED 
(
	[PostLikeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Friends]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friends](
	[FriendsListId] [nvarchar](128) NOT NULL,
	[FriendId] [nvarchar](128) NOT NULL,
	[FriendStatus] [bit] NOT NULL,
	[FriendSince] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FriendId] ASC,
	[FriendsListId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SettingChatBox]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingChatBox](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChatBoxId] [nvarchar](128) NULL,
	[User1] [nvarchar](128) NULL,
	[Language1] [int] NULL,
	[User2] [nvarchar](128) NULL,
	[Language2] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatReply]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatReply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChatBoxId] [nvarchar](128) NULL,
	[UserIdReply] [nvarchar](128) NULL,
	[Content] [nvarchar](max) NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [varchar](50) NOT NULL,
	[PostID] [varchar](50) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
	[CommentedDate] [datetime] NOT NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_Cyber_Comment_1] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlbumDetail]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [nvarchar](128) NULL,
	[PostedUserId] [nvarchar](128) NULL,
	[PostedDate] [datetime] NOT NULL,
	[Url] [nvarchar](256) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[Hide] [bit] NOT NULL,
	[PostID] [nvarchar](50) NULL,
	[Filter] [nvarchar](1000) NULL,
 CONSTRAINT [PK__AlbumDet__3214EC07B09EF071] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AlbumDetail] ON
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (1, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5030007FA81 AS DateTime), N'~/Content/Images/Avatar/men2.png', 0, NULL, 0, 1, NULL, NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (2, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5030007FA81 AS DateTime), N'~/Content/Images/Cover/cover5.jpg', 0, NULL, 0, 1, NULL, NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (8, N'avatare640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5080153B55B AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (87).jpg', 0, NULL, 1, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (9, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5080153BAB6 AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (79).jpg', 1, CAST(0x0000A508015E13EF AS DateTime), 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (10, N'covere640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5080165A7EA AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (75).jpg', 0, NULL, 1, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (11, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A50801682B52 AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (55).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (12, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A50801682B4E AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (70).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (13, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A50801682EEA AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (53).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (14, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A50801691364 AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (71).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (15, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A50801691375 AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (59).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (16, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A508016915FD AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (22).jpg', 0, NULL, 0, 0, N'', NULL)
INSERT [dbo].[AlbumDetail] ([Id], [AlbumId], [PostedUserId], [PostedDate], [Url], [Deleted], [DeletedDate], [Active], [Hide], [PostID], [Filter]) VALUES (17, N'uploade640a8ed-283d-46b8-85d0-6d11e1d7bea1', N'e640a8ed-283d-46b8-85d0-6d11e1d7bea1', CAST(0x0000A5080169160B AS DateTime), N'~/Content/Images/UserUpload/wallpaper_hd_by_sinhvienit (30).jpg', 0, NULL, 0, 0, N'', N'filter: grayscale(0%) blur(0px) brightness(100%) contrast(100%) hue-rotate(0deg) opacity(100%) invert(0%) saturate(15%) sepia(0%); -webkit-filter: grayscale(0%) blur(0px) brightness(100%) contrast(100%) hue-rotate(0deg) opacity(100%) invert(0%) saturate(15%) sepia(0%); -moz-filter: grayscale(0%) blur(0px) brightness(100%) contrast(100%) hue-rotate(0deg) opacity(100%) invert(0%) saturate(15%) sepia(0%); -ms-filter: grayscale(0%) blur(0px) brightness(100%) contrast(100%) hue-rotate(0deg) opacity(100%) invert(0%) saturate(15%) sepia(0%); -o-filter: grayscale(0%) blur(0px) brightness(100%) contrast(100%) hue-rotate(0deg) opacity(100%) invert(0%) saturate(15%) sepia(0%); ')
SET IDENTITY_INSERT [dbo].[AlbumDetail] OFF
/****** Object:  Table [dbo].[CommentLike]    Script Date: 09/04/2015 00:42:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommentLike](
	[CommentLikeID] [varchar](50) NOT NULL,
	[CommentID] [varchar](50) NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_CommentLike] PRIMARY KEY CLUSTERED 
(
	[CommentLikeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_User_Relationship_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Relationship_Type] FOREIGN KEY([Relationship])
REFERENCES [dbo].[Relationship_Type] ([RelationshipID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Relationship_Type]
GO
/****** Object:  ForeignKey [FK__ChatBox__FromUse__3D5E1FD2]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__FromUse__3E52440B]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__ToUseId__3F466844]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__ToUseId__403A8C7D]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Album__CreatedUs__3A81B327]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Album]  WITH CHECK ADD FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_CalendarEvents_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[CalendarEvents]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEvents_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CalendarEvents] CHECK CONSTRAINT [FK_CalendarEvents_User]
GO
/****** Object:  ForeignKey [FK_Notification_Notification_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Notification_Type] FOREIGN KEY([NotificationType])
REFERENCES [dbo].[Notification_Type] ([NotificationTypeID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Notification_Type]
GO
/****** Object:  ForeignKey [FK_Notification_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
/****** Object:  ForeignKey [FK_MySetting_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[MySetting]  WITH CHECK ADD  CONSTRAINT [FK_MySetting_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MySetting] CHECK CONSTRAINT [FK_MySetting_User]
GO
/****** Object:  ForeignKey [FK_MySetting_Visible_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[MySetting]  WITH CHECK ADD  CONSTRAINT [FK_MySetting_Visible_Type] FOREIGN KEY([DefaultMyPostVisibility])
REFERENCES [dbo].[Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[MySetting] CHECK CONSTRAINT [FK_MySetting_Visible_Type]
GO
/****** Object:  ForeignKey [FK_MyEvents_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[MyEvents]  WITH CHECK ADD  CONSTRAINT [FK_MyEvents_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MyEvents] CHECK CONSTRAINT [FK_MyEvents_User]
GO
/****** Object:  ForeignKey [FK__FriendLis__UserI__48CFD27E]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__FriendLis__UserI__49C3F6B7]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_Role_Role_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role_Type] FOREIGN KEY([RoleType])
REFERENCES [dbo].[Role_Type] ([RoleTypeID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role_Type]
GO
/****** Object:  ForeignKey [FK_Role_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User]
GO
/****** Object:  ForeignKey [FK_Role_User1]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User1] FOREIGN KEY([AssignedBy])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User1]
GO
/****** Object:  ForeignKey [FK_Reports_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_User] FOREIGN KEY([Reporter])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_User]
GO
/****** Object:  ForeignKey [FK_Post_Post_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Post_Type] FOREIGN KEY([PostType])
REFERENCES [dbo].[Post_Type] ([PostTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Post_Type]
GO
/****** Object:  ForeignKey [FK_Post_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
GO
/****** Object:  ForeignKey [FK_Post_User1]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User1] FOREIGN KEY([PostedOn])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User1]
GO
/****** Object:  ForeignKey [FK_Post_Visible_Type]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Visible_Type] FOREIGN KEY([VisibleType])
REFERENCES [dbo].[Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Visible_Type]
GO
/****** Object:  ForeignKey [FK_PostLike_Post]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_Post]
GO
/****** Object:  ForeignKey [FK_PostLike_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_User]
GO
/****** Object:  ForeignKey [FK__Friends__FriendI__4AB81AF0]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Friends__FriendI__4BAC3F29]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Friends__Friends__4CA06362]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
/****** Object:  ForeignKey [FK__Friends__Friends__4D94879B]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__ChatB__5CD6CB2B]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__Langu__5DCAEF64]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language1])
REFERENCES [dbo].[Language] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__Langu__5EBF139D]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language2])
REFERENCES [dbo].[Language] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__User1__5FB337D6]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([User1])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__SettingCh__User2__60A75C0F]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([User2])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatReply__ChatB__412EB0B6]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__ChatReply__ChatB__4222D4EF]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__ChatReply__UserI__4316F928]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatReply__UserI__440B1D61]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_Comment_Post]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
/****** Object:  ForeignKey [FK_Comment_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
/****** Object:  ForeignKey [FK__AlbumDeta__Album__5BE2A6F2]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD  CONSTRAINT [FK__AlbumDeta__Album__5BE2A6F2] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumDetail] CHECK CONSTRAINT [FK__AlbumDeta__Album__5BE2A6F2]
GO
/****** Object:  ForeignKey [FK__AlbumDeta__Poste__5CD6CB2B]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD  CONSTRAINT [FK__AlbumDeta__Poste__5CD6CB2B] FOREIGN KEY([PostedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[AlbumDetail] CHECK CONSTRAINT [FK__AlbumDeta__Poste__5CD6CB2B]
GO
/****** Object:  ForeignKey [FK_CommentLike_Comment]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_Comment] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([CommentID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_Comment]
GO
/****** Object:  ForeignKey [FK_CommentLike_User]    Script Date: 09/04/2015 00:42:04 ******/
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_User]
GO
