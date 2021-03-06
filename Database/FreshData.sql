USE [master]
GO
/****** Object:  Database [Cyber]    Script Date: 7/9/2015 1:16:14 AM ******/
CREATE DATABASE [Cyber]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cyber', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cyber.mdf' , SIZE = 3328KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cyber_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cyber_log.LDF' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [Cyber] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cyber] SET  MULTI_USER 
GO
ALTER DATABASE [Cyber] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cyber] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cyber] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cyber] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Cyber]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlbumDetail]    Script Date: 7/9/2015 1:16:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[PostID] [varchar](50) NULL,
	[Filter] [nvarchar](1000) NULL,
 CONSTRAINT [PK__AlbumDet__3214EC07B09EF071] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CalendarEvents]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChatBox]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChatReply]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommentLike]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FriendList]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Friends]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MyEvents]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MySetting]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification_Type]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post_Type]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PostLike]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Relationship_Type]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role_Type]    Script Date: 7/9/2015 1:16:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role_Type](
	[RoleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[RoleTypeName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Cyber_Role_Type] PRIMARY KEY CLUSTERED 
(
	[RoleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SettingChatBox]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 7/9/2015 1:16:14 AM ******/
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
	[BirthDay] [datetime] NOT NULL,
	[Gender] [bit] NOT NULL,
	[Relationship] [int] NOT NULL,
	[About] [nvarchar](max) NULL,
	[Email] [varchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Work] [nvarchar](255) NULL,
	[ContactNumber] [varchar](50) NULL,
	[Studied] [nvarchar](255) NULL,
	[RegisteredDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Cyber_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visible_Type]    Script Date: 7/9/2015 1:16:14 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Language] ON 

INSERT [dbo].[Language] ([Id], [Name]) VALUES (1, N'English')
INSERT [dbo].[Language] ([Id], [Name]) VALUES (2, N'Việt Nam')
INSERT [dbo].[Language] ([Id], [Name]) VALUES (3, N'日本')
SET IDENTITY_INSERT [dbo].[Language] OFF
SET IDENTITY_INSERT [dbo].[Notification_Type] ON 

INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (1, N'Post')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (2, N'CommentMyPost')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (3, N'CommentOthers')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (4, N'LikeMyPost')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (5, N'LikeMyComment')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (6, N'AcceptFriendRequest')
INSERT [dbo].[Notification_Type] ([NotificationTypeID], [NotificationTypeName]) VALUES (7, N'CancelFriendRequest')
SET IDENTITY_INSERT [dbo].[Notification_Type] OFF
SET IDENTITY_INSERT [dbo].[Post_Type] ON 

INSERT [dbo].[Post_Type] ([PostTypeID], [PostTypeName]) VALUES (1, N'Status')
INSERT [dbo].[Post_Type] ([PostTypeID], [PostTypeName]) VALUES (2, N'Photo')
SET IDENTITY_INSERT [dbo].[Post_Type] OFF
SET IDENTITY_INSERT [dbo].[Relationship_Type] ON 

INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (1, N'Single')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (2, N'Engaged')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (3, N'Married')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (4, N'Divorced')
SET IDENTITY_INSERT [dbo].[Relationship_Type] OFF
SET IDENTITY_INSERT [dbo].[Role_Type] ON 

INSERT [dbo].[Role_Type] ([RoleTypeID], [RoleTypeName]) VALUES (1, N'SuperAdmin')
INSERT [dbo].[Role_Type] ([RoleTypeID], [RoleTypeName]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[Role_Type] OFF
SET IDENTITY_INSERT [dbo].[Visible_Type] ON 

INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (1, N'Public')
INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (2, N'Friend')
INSERT [dbo].[Visible_Type] ([VisibleTypeID], [VisibleTypeName]) VALUES (3, N'Private')
SET IDENTITY_INSERT [dbo].[Visible_Type] OFF
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK__Album__CreatedUs__3E52440B] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK__Album__CreatedUs__3E52440B]
GO
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD  CONSTRAINT [FK__AlbumDeta__Album__5BE2A6F2] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumDetail] CHECK CONSTRAINT [FK__AlbumDeta__Album__5BE2A6F2]
GO
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD  CONSTRAINT [FK__AlbumDeta__Poste__5CD6CB2B] FOREIGN KEY([PostedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[AlbumDetail] CHECK CONSTRAINT [FK__AlbumDeta__Poste__5CD6CB2B]
GO
ALTER TABLE [dbo].[CalendarEvents]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEvents_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CalendarEvents] CHECK CONSTRAINT [FK_CalendarEvents_User]
GO
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD  CONSTRAINT [FK__ChatBox__FromUse__412EB0B6] FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatBox] CHECK CONSTRAINT [FK__ChatBox__FromUse__412EB0B6]
GO
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD  CONSTRAINT [FK__ChatBox__FromUse__4222D4EF] FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatBox] CHECK CONSTRAINT [FK__ChatBox__FromUse__4222D4EF]
GO
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD  CONSTRAINT [FK__ChatBox__ToUseId__4316F928] FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatBox] CHECK CONSTRAINT [FK__ChatBox__ToUseId__4316F928]
GO
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD  CONSTRAINT [FK__ChatBox__ToUseId__440B1D61] FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatBox] CHECK CONSTRAINT [FK__ChatBox__ToUseId__440B1D61]
GO
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD  CONSTRAINT [FK__ChatReply__UserI__46E78A0C] FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatReply] CHECK CONSTRAINT [FK__ChatReply__UserI__46E78A0C]
GO
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD  CONSTRAINT [FK__ChatReply__UserI__47DBAE45] FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ChatReply] CHECK CONSTRAINT [FK__ChatReply__UserI__47DBAE45]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_Comment] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([CommentID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_Comment]
GO
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_User]
GO
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD  CONSTRAINT [FK__FriendLis__UserI__4CA06362] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FriendList] CHECK CONSTRAINT [FK__FriendLis__UserI__4CA06362]
GO
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD  CONSTRAINT [FK__FriendLis__UserI__4D94879B] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FriendList] CHECK CONSTRAINT [FK__FriendLis__UserI__4D94879B]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK__Friends__FriendI__4E88ABD4] FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK__Friends__FriendI__4E88ABD4]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK__Friends__FriendI__4F7CD00D] FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK__Friends__FriendI__4F7CD00D]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
ALTER TABLE [dbo].[MyEvents]  WITH CHECK ADD  CONSTRAINT [FK_MyEvents_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MyEvents] CHECK CONSTRAINT [FK_MyEvents_User]
GO
ALTER TABLE [dbo].[MySetting]  WITH CHECK ADD  CONSTRAINT [FK_MySetting_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MySetting] CHECK CONSTRAINT [FK_MySetting_User]
GO
ALTER TABLE [dbo].[MySetting]  WITH CHECK ADD  CONSTRAINT [FK_MySetting_Visible_Type] FOREIGN KEY([DefaultMyPostVisibility])
REFERENCES [dbo].[Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[MySetting] CHECK CONSTRAINT [FK_MySetting_Visible_Type]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Notification_Type] FOREIGN KEY([NotificationType])
REFERENCES [dbo].[Notification_Type] ([NotificationTypeID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Notification_Type]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Post_Type] FOREIGN KEY([PostType])
REFERENCES [dbo].[Post_Type] ([PostTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Post_Type]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User1] FOREIGN KEY([PostedOn])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User1]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Visible_Type] FOREIGN KEY([VisibleType])
REFERENCES [dbo].[Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Visible_Type]
GO
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_Post]
GO
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_User]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_User] FOREIGN KEY([Reporter])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_User]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role_Type] FOREIGN KEY([RoleType])
REFERENCES [dbo].[Role_Type] ([RoleTypeID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role_Type]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User1] FOREIGN KEY([AssignedBy])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User1]
GO
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language1])
REFERENCES [dbo].[Language] ([Id])
GO
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language2])
REFERENCES [dbo].[Language] ([Id])
GO
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD  CONSTRAINT [FK__SettingCh__User1__6383C8BA] FOREIGN KEY([User1])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[SettingChatBox] CHECK CONSTRAINT [FK__SettingCh__User1__6383C8BA]
GO
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD  CONSTRAINT [FK__SettingCh__User2__6477ECF3] FOREIGN KEY([User2])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[SettingChatBox] CHECK CONSTRAINT [FK__SettingCh__User2__6477ECF3]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Relationship_Type] FOREIGN KEY([Relationship])
REFERENCES [dbo].[Relationship_Type] ([RelationshipID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Relationship_Type]
GO
USE [master]
GO
ALTER DATABASE [Cyber] SET  READ_WRITE 
GO
