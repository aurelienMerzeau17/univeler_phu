/*
Script de déploiement pour phu_bdd

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "phu_bdd"
:setvar DefaultFilePrefix "phu_bdd"
:setvar DefaultDataPath "C:\Users\D3F\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\Projects\"
:setvar DefaultLogPath "C:\Users\D3F\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\Projects\"

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

IF (SELECT OBJECT_ID('tempdb..#tmpErrors')) IS NOT NULL DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
BEGIN TRANSACTION
GO
PRINT N'Renommer [dbo].[event] en evenement';


GO
EXECUTE sp_rename @objname = N'[dbo].[event]', @newname = N'evenement', @objtype = N'OBJECT';


GO
IF @@ERROR <> 0
   AND @@TRANCOUNT > 0
    BEGIN
        ROLLBACK;
    END

IF @@TRANCOUNT = 0
    BEGIN
        INSERT  INTO #tmpErrors (Error)
        VALUES                 (1);
        BEGIN TRANSACTION;
    END


GO

IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT N'Succès de la mise à jour de la portion de base de données traitée.'
COMMIT TRANSACTION
END
ELSE PRINT N'Échec de la mise à jour de la portion de base de données traitée.'
GO
DROP TABLE #tmpErrors
GO
PRINT N'Mise à jour terminée.';


GO
