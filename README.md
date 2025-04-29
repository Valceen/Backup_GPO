.SYNOPSIS  

    Effectue une sauvegarde de tous les GPOs et gère leur rétention.
    Date    : 2025-04-29
    Version : 2.0

.DESCRIPTION  

    Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.
    Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.

.NOTES  

    Prérequis :
    - Module PowerShell pour les GPOs.
    - Droits adéquats pour effectuer des sauvegardes.

.FONCTIONNEMENT  

    Changer le nom du serveur :
    $BackupServer = "\\SERVER"  
    
    Fait un sauvegarde dans le répertoire :  
    
    \\SERVEUR\\GPO\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)  
    
    Exemple :
    \\NAS01\Backup\GPO\DC01\2025-04-29  
    
    Supprime toutes les sauvegardes de plus 15 jours :
    $DeleteFolderFiles = (Get-Date).AddDays(-15)

.LICENCE  

    GNU General Pulic Licence V3.0
    https://github.com/Valceen/
