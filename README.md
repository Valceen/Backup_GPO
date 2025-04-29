.SYNOPSIS<br>
    Effectue une sauvegarde de tous les GPOs et gère leur rétention.
    Date    : 2025-04-29
    Version : 2.0

.DESCRIPTION<br>
    Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.
    Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.

.NOTES<br>
    Prérequis :
    - Module PowerShell pour les GPOs.
    - Droits adéquats pour effectuer des sauvegardes.

.FONCTIONNEMENT<br>
    Changer le nom du serveur :<br>
    $BackupServer = "\\SERVER"<br>
    Fait un sauvegarde dans le répertoire :<br> 
    \\SERVEUR\\GPO\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)<br>
    Exemple :<br>
    \\NAS01\Backup\GPO\DC01\2025-04-29<br>
    Supprime toutes les sauvegardes de plus 15 jours :<br>
    $DeleteFolderFiles = (Get-Date).AddDays(-15)

.LICENCE  

    GNU General Pulic Licence V3.0
    https://github.com/Valceen/
