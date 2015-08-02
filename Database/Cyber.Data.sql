USE [master]
GO
/****** Object:  Database [Cyber]    Script Date: 2/8/2015 3:20:15 PM ******/
CREATE DATABASE [Cyber]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cyber', FILENAME = N'e:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cyber.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cyber_log', FILENAME = N'e:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Cyber_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Cyber] SET COMPATIBILITY_LEVEL = 110
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
/****** Object:  Table [dbo].[Comment]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comment](
	[PostID] [varchar](50) NOT NULL,
	[CommentID] [varchar](50) NOT NULL,
	[CommentContent] [nvarchar](255) NOT NULL,
	[CommentedDate] [datetime] NOT NULL,
	[CommentedBy] [varchar](50) NOT NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_Cyber_Comment_1] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommentLike]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommentLike](
	[CommentID] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CommentLike] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Friend]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Friend](
	[UserID] [varchar](50) NOT NULL,
	[FriendID] [varchar](50) NOT NULL,
	[FriendStatus] [bit] NOT NULL,
	[FriendSince] [datetime] NULL,
 CONSTRAINT [PK_Cyber_Friend] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Membership]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Membership](
	[UserID] [varchar](50) NOT NULL,
	[Username] [varchar](255) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[LastTimeLogIn] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Cyber_Membership] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notification](
	[UserID] [varchar](50) NOT NULL,
	[NotificationID] [varchar](50) NOT NULL,
	[NotificationTypeID] [int] NOT NULL,
	[NotificationContent] [nvarchar](255) NOT NULL,
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
/****** Object:  Table [dbo].[Notification_Type]    Script Date: 2/8/2015 3:20:16 PM ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[UserID] [varchar](50) NOT NULL,
	[PostID] [varchar](50) NOT NULL,
	[PostTypeID] [int] NOT NULL,
	[PostContent] [text] NOT NULL,
	[PostedDate] [datetime] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[VisibleTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Cyber_Post_1] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post_Type]    Script Date: 2/8/2015 3:20:16 PM ******/
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
/****** Object:  Table [dbo].[PostLike]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PostLike](
	[PostID] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PostLike] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Photo]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Photo](
	[UserID] [varchar](50) NOT NULL,
	[ProfileImageUrl] [varchar](255) NULL,
	[CoverImageUrl] [varchar](255) NULL,
 CONSTRAINT [PK_Cyber_Profile_Photo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Relationship_Type]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Relationship_Type](
	[RelationshipID] [int] NOT NULL,
	[RelationshipName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cyber_Relationship_Type] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[UserID] [varchar](50) NOT NULL,
	[RoleTypeID] [int] NOT NULL,
	[AssignedDate] [datetime] NOT NULL,
	[AssignedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cyber_Role] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role_Type]    Script Date: 2/8/2015 3:20:16 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/8/2015 3:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [varchar](50) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[BirthDay] [date] NOT NULL,
	[Gender] [bit] NOT NULL,
	[RelationshipID] [int] NOT NULL,
	[About] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Work] [nvarchar](255) NULL,
	[ContactNumber] [varchar](50) NULL,
	[Studied] [nvarchar](255) NULL,
 CONSTRAINT [PK_Cyber_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visible_Type]    Script Date: 2/8/2015 3:20:16 PM ******/
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
INSERT [dbo].[Membership] ([UserID], [Username], [Email], [Password], [LastTimeLogIn], [CreatedDate], [Status]) VALUES (N'00000000-0000-0000-0000-000000000000', N'apham24', N'apham24@csc.com', N'1452312231361991668585222201581489921523646172921780', CAST(0x0000A4E800FC258E AS DateTime), CAST(0x0000A4E800FC258E AS DateTime), 1)
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (0, N'Single')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (1, N'Engaged')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (2, N'Married')
INSERT [dbo].[Relationship_Type] ([RelationshipID], [RelationshipName]) VALUES (3, N'Divorced')
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [BirthDay], [Gender], [RelationshipID], [About], [Address], [Work], [ContactNumber], [Studied]) VALUES (N'00000000-0000-0000-0000-000000000000', N'An', N'Pham', CAST(0x1C1A0B00 AS Date), 0, 0, NULL, NULL, NULL, NULL, NULL)
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([CommentedBy])
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
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [FK_Friend_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [FK_Friend_User]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [FK_Friend_User1] FOREIGN KEY([FriendID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [FK_Friend_User1]
GO
ALTER TABLE [dbo].[Membership]  WITH CHECK ADD  CONSTRAINT [FK_Membership_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Membership] CHECK CONSTRAINT [FK_Membership_User]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Notification_Type] FOREIGN KEY([NotificationTypeID])
REFERENCES [dbo].[Notification_Type] ([NotificationTypeID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Notification_Type]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Post_Type] FOREIGN KEY([PostTypeID])
REFERENCES [dbo].[Post_Type] ([PostTypeID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Post_Type]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Visible_Type] FOREIGN KEY([VisibleTypeID])
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
ALTER TABLE [dbo].[Profile_Photo]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Photo_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Profile_Photo] CHECK CONSTRAINT [FK_Profile_Photo_User]
GO
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Role_Type] FOREIGN KEY([RoleTypeID])
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
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Relationship_Type] FOREIGN KEY([RelationshipID])
REFERENCES [dbo].[Relationship_Type] ([RelationshipID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Relationship_Type]
GO
USE [master]
GO
ALTER DATABASE [Cyber] SET  READ_WRITE 
GO
