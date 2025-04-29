<#
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

## RECOMMANDATION
Fonctionne trés bien avec un compte Gmsa (Group Managed Service Accounts)<br>

Nécéssite :<br>
- droits sur le répertoire de sauvegarde<br>
- membre du groupe Backup Operators<br>

et les droits de la GPO :<br>
- Accéder a cet ordinateur a partir du réseau<br>
- Ouvrir une session en tant que service<br>
- Ouvrir une session en tant que tache<br>
- sauvegarder les fichiers et les répertoires<br>

## Licence
GNU General Public Licence V3.0
https://github.com/Valceen/
#>

Write-Host "=========================== Import Module GPO Backup ============================" -ForegroundColor Green

# Vérification du module GPO PowerShell
$GpoModulePath = "$env:windir\System32\WindowsPowerShell\v1.0\Modules\GroupPolicy\GroupPolicy.psd1"
If (-Not (Test-Path $GpoModulePath)) {
    Write-Host "Module GPO introuvable. Installation requise..." -ForegroundColor Yellow
    Install-WindowsFeature -Name GPMC
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Déclaration des variables ============================" -ForegroundColor Green

# Chemin principal et sous-dossiers
$BackupServer = "\\SERVER"
$BackupFolderRoot = "Backup"
$BackupFolderType = "$BackupServer\$BackupFolderRoot\GPO\$env:ComputerName"
$BackupFolderDate = "$BackupFolderType\$((Get-Date).ToString('yyyy-MM-dd'))"

# Réglage de la durée de rétention (par défaut : 15 jours)
$DeleteFolderFiles = (Get-Date).AddDays(-15)

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Création des dossiers ================================" -ForegroundColor Green

# Création des dossiers nécessaires
@( $BackupFolderRoot, $BackupFolderType, $BackupFolderDate ) | ForEach-Object {
    If (-Not (Test-Path $_)) {
        New-Item $_ -Type Directory | Out-Null
    }
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Sauvegarde des GPOs ==================================" -ForegroundColor Green

# Sauvegarde de tous les GPOs dans le dossier avec la date
Try {
    Backup-GPO -All -Path "$BackupFolderDate"
    Write-Host "Sauvegarde des GPOs réussie !" -ForegroundColor Green
} Catch {
    Write-Host "Erreur lors de la sauvegarde des GPOs : $_" -ForegroundColor Red
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""


Write-Host "=========================== Suppression des anciennes sauvegardes ==================" -ForegroundColor Green

# Suppression des sauvegardes dépassant la limite de rétention
Try {
    Get-ChildItem $BackupFolderType | Where-Object {$_.LastWriteTime -lt $DeleteFolderFiles} | Remove-Item -Recurse -Force
    Write-Host "Anciennes sauvegardes supprimées avec succès !" -ForegroundColor Green
} Catch {
    Write-Host "Erreur lors de la suppression des anciennes sauvegardes : $_" -ForegroundColor Red
}

Write-Host "=============================================================================" -ForegroundColor Green
Write-Host ""
