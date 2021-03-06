ALTER DATABASE [phu_bdd] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [phu_bdd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [phu_bdd] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [phu_bdd] SET ANSI_NULLS ON 
GO
ALTER DATABASE [phu_bdd] SET ANSI_PADDING ON 
GO
ALTER DATABASE [phu_bdd] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [phu_bdd] SET ARITHABORT ON 
GO
ALTER DATABASE [phu_bdd] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [phu_bdd] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [phu_bdd] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [phu_bdd] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [phu_bdd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [phu_bdd] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [phu_bdd] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [phu_bdd] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [phu_bdd] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [phu_bdd] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [phu_bdd] SET  DISABLE_BROKER 
GO
ALTER DATABASE [phu_bdd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [phu_bdd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [phu_bdd] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [phu_bdd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [phu_bdd] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [phu_bdd] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [phu_bdd] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [phu_bdd] SET RECOVERY FULL 
GO
ALTER DATABASE [phu_bdd] SET  MULTI_USER 
GO
ALTER DATABASE [phu_bdd] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [phu_bdd] SET DB_CHAINING OFF 
GO
ALTER DATABASE [phu_bdd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [phu_bdd] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'phu_bdd', N'ON'
GO
USE [phu_bdd]
GO
/****** Object:  Table [dbo].[evenement]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evenement](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [text] NOT NULL,
	[localisation_id] [int] NOT NULL,
	[max_people] [int] NOT NULL,
	[actual_people] [int] NOT NULL,
	[description] [text] NOT NULL,
	[validate] [int] NOT NULL,
	[date_event] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[event_user]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_user](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[localisation]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[localisation](
	[localisation_id] [int] IDENTITY(1,1) NOT NULL,
	[address] [text] NOT NULL,
	[cp] [int] NOT NULL,
	[city] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[localisation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[UserId] [int] NOT NULL,
	[user_mail] [text] NULL,
	[admin] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 17/04/2014 16:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[evenement] ADD  DEFAULT ((0)) FOR [actual_people]
GO
ALTER TABLE [dbo].[evenement] ADD  DEFAULT ((0)) FOR [validate]
GO
ALTER TABLE [dbo].[user] ADD  DEFAULT ((0)) FOR [admin]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[evenement]  WITH CHECK ADD  CONSTRAINT [fk_localisation] FOREIGN KEY([localisation_id])
REFERENCES [dbo].[localisation] ([localisation_id])
GO
ALTER TABLE [dbo].[evenement] CHECK CONSTRAINT [fk_localisation]
GO
ALTER TABLE [dbo].[event_user]  WITH CHECK ADD  CONSTRAINT [fk_event_id] FOREIGN KEY([event_id])
REFERENCES [dbo].[evenement] ([event_id])
GO
ALTER TABLE [dbo].[event_user] CHECK CONSTRAINT [fk_event_id]
GO
ALTER TABLE [dbo].[event_user]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[event_user] CHECK CONSTRAINT [fk_UserId]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_id] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_id]
GO
USE [master]
GO
ALTER DATABASE [phu_bdd] SET  READ_WRITE 
GO
