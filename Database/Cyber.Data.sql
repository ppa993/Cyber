USE [master]
GO
/****** Object:  Database [Cyber]    Script Date: 1/8/2015 12:17:29 PM ******/
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
/****** Object:  Table [dbo].[Cyber_Comment]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Comment](
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
/****** Object:  Table [dbo].[Cyber_Friend]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Friend](
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
/****** Object:  Table [dbo].[Cyber_Like]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Like](
	[LikeID] [varbinary](50) NOT NULL,
	[LikeOf] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cyber_Like] PRIMARY KEY CLUSTERED 
(
	[LikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cyber_Membership]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Membership](
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
/****** Object:  Table [dbo].[Cyber_Notification]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Notification](
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
/****** Object:  Table [dbo].[Cyber_Notification_Type]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Notification_Type](
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
/****** Object:  Table [dbo].[Cyber_Post]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Post](
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
/****** Object:  Table [dbo].[Cyber_Post_Type]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Post_Type](
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
/****** Object:  Table [dbo].[Cyber_Profile_Photo]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Profile_Photo](
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
/****** Object:  Table [dbo].[Cyber_Role]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Role](
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
/****** Object:  Table [dbo].[Cyber_Role_Type]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Role_Type](
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
/****** Object:  Table [dbo].[Cyber_User]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_User](
	[UserID] [varchar](50) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[BirthDay] [date] NOT NULL,
	[About] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Relationship] [nvarchar](255) NULL,
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
/****** Object:  Table [dbo].[Cyber_Visible_Type]    Script Date: 1/8/2015 12:17:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cyber_Visible_Type](
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
ALTER TABLE [dbo].[Cyber_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Comment_Cyber_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Cyber_Post] ([PostID])
GO
ALTER TABLE [dbo].[Cyber_Comment] CHECK CONSTRAINT [FK_Cyber_Comment_Cyber_Post]
GO
ALTER TABLE [dbo].[Cyber_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Comment_Cyber_User] FOREIGN KEY([CommentedBy])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Comment] CHECK CONSTRAINT [FK_Cyber_Comment_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Friend]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Friend_Cyber_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Friend] CHECK CONSTRAINT [FK_Cyber_Friend_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Friend]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Friend_Cyber_User1] FOREIGN KEY([FriendID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Friend] CHECK CONSTRAINT [FK_Cyber_Friend_Cyber_User1]
GO
ALTER TABLE [dbo].[Cyber_Like]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Like_Cyber_Comment] FOREIGN KEY([LikeOf])
REFERENCES [dbo].[Cyber_Comment] ([CommentID])
GO
ALTER TABLE [dbo].[Cyber_Like] CHECK CONSTRAINT [FK_Cyber_Like_Cyber_Comment]
GO
ALTER TABLE [dbo].[Cyber_Like]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Like_Cyber_Post] FOREIGN KEY([LikeOf])
REFERENCES [dbo].[Cyber_Post] ([PostID])
GO
ALTER TABLE [dbo].[Cyber_Like] CHECK CONSTRAINT [FK_Cyber_Like_Cyber_Post]
GO
ALTER TABLE [dbo].[Cyber_Membership]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Membership_Cyber_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Membership] CHECK CONSTRAINT [FK_Cyber_Membership_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Notification_Cyber_Notification_Type] FOREIGN KEY([NotificationTypeID])
REFERENCES [dbo].[Cyber_Notification_Type] ([NotificationTypeID])
GO
ALTER TABLE [dbo].[Cyber_Notification] CHECK CONSTRAINT [FK_Cyber_Notification_Cyber_Notification_Type]
GO
ALTER TABLE [dbo].[Cyber_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Notification_Cyber_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Notification] CHECK CONSTRAINT [FK_Cyber_Notification_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Post]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Post_Cyber_Post_Type] FOREIGN KEY([PostTypeID])
REFERENCES [dbo].[Cyber_Post_Type] ([PostTypeID])
GO
ALTER TABLE [dbo].[Cyber_Post] CHECK CONSTRAINT [FK_Cyber_Post_Cyber_Post_Type]
GO
ALTER TABLE [dbo].[Cyber_Post]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Post_Cyber_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Post] CHECK CONSTRAINT [FK_Cyber_Post_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Post]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Post_Cyber_Visible_Type] FOREIGN KEY([VisibleTypeID])
REFERENCES [dbo].[Cyber_Visible_Type] ([VisibleTypeID])
GO
ALTER TABLE [dbo].[Cyber_Post] CHECK CONSTRAINT [FK_Cyber_Post_Cyber_Visible_Type]
GO
ALTER TABLE [dbo].[Cyber_Profile_Photo]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Profile_Photo_Cyber_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Profile_Photo] CHECK CONSTRAINT [FK_Cyber_Profile_Photo_Cyber_User]
GO
ALTER TABLE [dbo].[Cyber_Role]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Role_Cyber_Role_Type] FOREIGN KEY([RoleTypeID])
REFERENCES [dbo].[Cyber_Role_Type] ([RoleTypeID])
GO
ALTER TABLE [dbo].[Cyber_Role] CHECK CONSTRAINT [FK_Cyber_Role_Cyber_Role_Type]
GO
ALTER TABLE [dbo].[Cyber_Role]  WITH CHECK ADD  CONSTRAINT [FK_Cyber_Role_Cyber_User] FOREIGN KEY([AssignedBy])
REFERENCES [dbo].[Cyber_User] ([UserID])
GO
ALTER TABLE [dbo].[Cyber_Role] CHECK CONSTRAINT [FK_Cyber_Role_Cyber_User]
GO
USE [master]
GO
ALTER DATABASE [Cyber] SET  READ_WRITE 
GO
