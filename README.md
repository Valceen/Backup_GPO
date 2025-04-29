## SYNOPSIS
Effectue une sauvegarde de tous les GPOs et gère leur rétention.<br>
Date    : 2025-04-29<br>
Version : 2.0<br>

## DESCRIPTION
Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.<br>
Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.<br>

## PREREQUIS
Module PowerShell pour les GPOs.<br>
Droits adéquats pour effectuer des sauvegardes.<br>

## FONCTIONNEMENT
- Changer le nom du serveur :<br>
$BackupServer = "\\\\SERVER"<br>
- Fait un sauvegarde dans le répertoire :<br> 
\\\\SERVEUR\\GPO\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)<br>
Exemple :<br>
\\\\NAS01\\Backup\\GPO\\DC01\\2025-04-29<br>
- Supprime toutes les sauvegardes de plus 15 jours :<br>
$DeleteFolderFiles = (Get-Date).AddDays(-15)## SYNOPSIS
Effectue une sauvegarde de tous les GPOs et gère leur rétention.<br>
Date    : 2025-04-29<br>
Version : 2.0<br>

## DESCRIPTION
Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.<br>
Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.<br>

## PREREQUIS
Module PowerShell pour les GPOs.<br>
Droits adéquats pour effectuer des sauvegardes.<br>

## FONCTIONNEMENT
- Changer le nom du serveur :<br>
$BackupServer = "\\\\SERVER"<br>
- Fait un sauvegarde dans le répertoire :<br> 
\\\\SERVEUR\\GPO\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)<br>
Exemple :<br>
\\\\NAS01\\Backup\\GPO\\DC01\\2025-04-29<br>
- Supprime toutes les sauvegardes de plus 15 jours :<br>
$DeleteFolderFiles = (Get-Date).AddDays(-15)## SYNOPSIS
Effectue une sauvegarde de tous les GPOs et gère leur rétention.<br>
Date    : 2025-04-29<br>
Version : 2.0<br>

## DESCRIPTION
Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.<br>
Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.<br>

## PREREQUIS
Module PowerShell pour les GPOs.<br>
Droits adéquats pour effectuer des sauvegardes.<br>

## FONCTIONNEMENT
- Changer le nom du serveur :<br>
$BackupServer = "\\\\SERVER"<br>
- Fait un sauvegarde dans le répertoire :<br> 
\\\\SERVEUR\\GPO\\NOM_DE_MACHINE\\DATE (au format yyyy-mm-jj)<br>
Exemple :<br>
\\\\NAS01\\Backup\\GPO\\DC01\\2025-04-29<br>
- Supprime toutes les sauvegardes de plus 15 jours :<br>
$DeleteFolderFiles = (Get-Date).AddDays(-15)<br>

## Licence
GNU General Public Licence V3.0
https://github.com/Valceen/
