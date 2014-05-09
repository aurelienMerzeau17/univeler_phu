/*
Script de déploiement pour phu_bdd_script

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "phu_bdd"
:setvar DefaultFilePrefix "phu_bdd_script"
:setvar DefaultDataPath "c:\Program Files (x86)\Microsoft SQL Server\MSSQL11.INGESUP\MSSQL\DATA\"
:setvar DefaultLogPath "c:\Program Files (x86)\Microsoft SQL Server\MSSQL11.INGESUP\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Création de [dbo].[evenement]...';


GO
CREATE TABLE [dbo].[evenement] (
    [event_id]        INT  NOT NULL IDENTITY(1,1), 
    [name]            TEXT NOT NULL,
    [localisation_id] INT  NOT NULL,
    [max_people]      INT  NOT NULL,
    [actual_people]   INT  NOT NULL,
    [description]     TEXT NOT NULL,
    [validate]        INT  NOT NULL,
    PRIMARY KEY CLUSTERED ([event_id] ASC)
);


GO
PRINT N'Création de [dbo].[event_user]...';


GO
CREATE TABLE [dbo].[event_user] (
    [Id]       INT NOT NULL IDENTITY(1,1),
    [event_id] INT NOT NULL,
    [user_id]  INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de [dbo].[localisation]...';


GO
CREATE TABLE [dbo].[localisation] (
    [localisation_id] INT  NOT NULL IDENTITY(1,1),
    [address]         TEXT NOT NULL,
    [cp]              INT  NOT NULL,
    [city]            TEXT NOT NULL,
    PRIMARY KEY CLUSTERED ([localisation_id] ASC)
);


GO
PRINT N'Création de [dbo].[user]...';


GO
CREATE TABLE [dbo].[user] (
    [user_id]       INT  NOT NULL IDENTITY(1,1),
    [user_login]    TEXT NOT NULL,
    [user_mail]     TEXT NULL,
    [user_password] TEXT NOT NULL,
    [admin]         INT  NOT NULL,
    PRIMARY KEY CLUSTERED ([user_id] ASC)
);


GO
PRINT N'Création de DF__Table__actual_pe__108B795B...';


GO
ALTER TABLE [dbo].[evenement]
    ADD DEFAULT ((0)) FOR [actual_people];


GO
PRINT N'Création de DF__event__validate__1BFD2C07...';


GO
ALTER TABLE [dbo].[evenement]
    ADD DEFAULT ((0)) FOR [validate];


GO
PRINT N'Création de DF__user__admin__1A14E395...';


GO
ALTER TABLE [dbo].[user]
    ADD DEFAULT ((0)) FOR [admin];


GO
PRINT N'Création de fk_localisation...';


GO
ALTER TABLE [dbo].[evenement] WITH NOCHECK
    ADD CONSTRAINT [fk_localisation] FOREIGN KEY ([localisation_id]) REFERENCES [dbo].[localisation] ([localisation_id]);


GO
PRINT N'Création de fk_event_id...';


GO
ALTER TABLE [dbo].[event_user] WITH NOCHECK
    ADD CONSTRAINT [fk_event_id] FOREIGN KEY ([event_id]) REFERENCES [dbo].[evenement] ([event_id]);


GO
PRINT N'Création de fk_user_id...';


GO
ALTER TABLE [dbo].[event_user] WITH NOCHECK
    ADD CONSTRAINT [fk_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[evenement] WITH CHECK CHECK CONSTRAINT [fk_localisation];

ALTER TABLE [dbo].[event_user] WITH CHECK CHECK CONSTRAINT [fk_event_id];

ALTER TABLE [dbo].[event_user] WITH CHECK CHECK CONSTRAINT [fk_user_id];


GO
PRINT N'Mise à jour terminée.';


GO
