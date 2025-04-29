<#
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

.Licence :
    GNU General Pulic Licence V3.0
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
