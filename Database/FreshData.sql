USE [master]
GO
/****** Object:  Database [Cyber]    Script Date: 08/22/2015 20:25:38 ******/
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
/****** Object:  Table [dbo].[Relationship_Type]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Notification_Type]    Script Date: 08/22/2015 20:25:40 ******/
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
SET IDENTITY_INSERT [dbo].[Notification_Type] OFF
/****** Object:  Table [dbo].[Role_Type]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Language]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Post_Type]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Visible_Type]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[ChatBox]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Album]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[FriendList]    Script Date: 08/22/2015 20:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendList](
	[Id] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Profile_Photo]    Script Date: 08/22/2015 20:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Photo](
	[UserID] [nvarchar](128) NOT NULL,
	[ProfileImageUrl] [varchar](255) NULL,
	[CoverImageUrl] [varchar](255) NULL,
 CONSTRAINT [PK_Cyber_Profile_Photo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PostLike]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[SettingChatBox]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Friends]    Script Date: 08/22/2015 20:25:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friends](
	[FriendsListId] [nvarchar](128) NOT NULL,
	[FriendId] [nvarchar](128) NOT NULL,
	[FriendStatus] [int] NULL,
	[FriendSince] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FriendId] ASC,
	[FriendsListId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatReply]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  Table [dbo].[AlbumDetail]    Script Date: 08/22/2015 20:25:40 ******/
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
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentLike]    Script Date: 08/22/2015 20:25:40 ******/
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
/****** Object:  ForeignKey [FK_User_Relationship_Type]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Relationship_Type] FOREIGN KEY([Relationship])
REFERENCES [dbo].[Relationship_Type] ([RelationshipID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Relationship_Type]
GO
/****** Object:  ForeignKey [FK__ChatBox__FromUse__3B75D760]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__FromUse__3C69FB99]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([FromUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__ToUseId__3D5E1FD2]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatBox__ToUseId__3E52440B]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatBox]  WITH CHECK ADD FOREIGN KEY([ToUseId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Album__CreatedUs__34C8D9D1]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Album]  WITH CHECK ADD FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_Post_Post_Type]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Post_Type] FOREIGN KEY([PostType])
REFERENCES [dbo].[Post_Type] ([PostTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Post_Type]
GO
/****** Object:  ForeignKey [FK_Post_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
GO
/****** Object:  ForeignKey [FK_Post_User1]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User1] FOREIGN KEY([PostedOn])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User1]
GO
/****** Object:  ForeignKey [FK_Post_Visible_Type]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Visible_Type] FOREIGN KEY([VisibleType])
REFERENCES [dbo].[Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Visible_Type]
GO
/****** Object:  ForeignKey [FK__FriendLis__UserI__4316F928]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__FriendLis__UserI__440B1D61]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[FriendList]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_Role_Role_Type]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role_Type] FOREIGN KEY([RoleType])
REFERENCES [dbo].[Role_Type] ([RoleTypeID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Role_Type]
GO
/****** Object:  ForeignKey [FK_Role_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User]
GO
/****** Object:  ForeignKey [FK_Role_User1]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_User1] FOREIGN KEY([AssignedBy])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_User1]
GO
/****** Object:  ForeignKey [FK_Notification_Notification_Type]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Notification_Type] FOREIGN KEY([NotificationType])
REFERENCES [dbo].[Notification_Type] ([NotificationTypeID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Notification_Type]
GO
/****** Object:  ForeignKey [FK_Notification_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
/****** Object:  ForeignKey [FK_Profile_Photo_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Profile_Photo]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Photo_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Profile_Photo] CHECK CONSTRAINT [FK_Profile_Photo_User]
GO
/****** Object:  ForeignKey [FK_PostLike_Post]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_Post]
GO
/****** Object:  ForeignKey [FK_PostLike_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[PostLike]  WITH CHECK ADD  CONSTRAINT [FK_PostLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PostLike] CHECK CONSTRAINT [FK_PostLike_User]
GO
/****** Object:  ForeignKey [FK__SettingCh__ChatB__5441852A]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__Langu__5535A963]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language1])
REFERENCES [dbo].[Language] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__Langu__5629CD9C]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([Language2])
REFERENCES [dbo].[Language] ([Id])
GO
/****** Object:  ForeignKey [FK__SettingCh__User1__571DF1D5]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([User1])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__SettingCh__User2__5812160E]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[SettingChatBox]  WITH CHECK ADD FOREIGN KEY([User2])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Friends__FriendI__44FF419A]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Friends__FriendI__45F365D3]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__Friends__Friends__46E78A0C]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
/****** Object:  ForeignKey [FK__Friends__Friends__47DBAE45]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD FOREIGN KEY([FriendsListId])
REFERENCES [dbo].[FriendList] ([Id])
GO
/****** Object:  ForeignKey [FK__ChatReply__ChatB__3F466844]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__ChatReply__ChatB__403A8C7D]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([ChatBoxId])
REFERENCES [dbo].[ChatBox] ([Id])
GO
/****** Object:  ForeignKey [FK__ChatReply__UserI__412EB0B6]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK__ChatReply__UserI__4222D4EF]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[ChatReply]  WITH CHECK ADD FOREIGN KEY([UserIdReply])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_Comment_Post]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
/****** Object:  ForeignKey [FK_Comment_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
/****** Object:  ForeignKey [FK__AlbumDeta__Album__35BCFE0A]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
/****** Object:  ForeignKey [FK__AlbumDeta__Poste__36B12243]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[AlbumDetail]  WITH CHECK ADD FOREIGN KEY([PostedUserId])
REFERENCES [dbo].[User] ([UserID])
GO
/****** Object:  ForeignKey [FK_CommentLike_Comment]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_Comment] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([CommentID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_Comment]
GO
/****** Object:  ForeignKey [FK_CommentLike_User]    Script Date: 08/22/2015 20:25:40 ******/
ALTER TABLE [dbo].[CommentLike]  WITH CHECK ADD  CONSTRAINT [FK_CommentLike_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CommentLike] CHECK CONSTRAINT [FK_CommentLike_User]
GO
