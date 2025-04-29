.SYNOPSIS
    Effectue une sauvegarde de tous les GPOs et gère leur rétention.
    Date    : 
    Version : 2.0

.DESCRIPTION
    Sauvegarde tous les GPOs dans un dossier nommé par la date du jour et les classe par GUID.
    Supprime ensuite les sauvegardes datant de plus de 15 jours, selon configuration.

.NOTES
    Prérequis :
    - Module PowerShell pour les GPOs.
    - Droits adéquats pour effectuer des sauvegardes.

.FONCTIONNEMENT
  Fait un sauvegarde dans le répertoire :
    \\SERVEUR
      \GPO
        \NOM_DE_MACHINE
          \DATE (au format yyyy-mm-jj)

.Licence :
    GNU General Pulic Licence V3.0
    https://github.com/Valceen/
