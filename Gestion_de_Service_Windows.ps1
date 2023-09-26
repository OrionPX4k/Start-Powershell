#######################################
############ First Script #############
##### Gestion de service windows ######
#######################################

# Menu interactif
Write-Host "Menu de gestion de l'ordinateur"
Write-Host "1. Arreter"
Write-Host "2. Mettre en Veille"
Write-Host "3. Redemarrer"

# Variable
$Choix = Read-Host "Veuillez Choisir une Option (1 / 2 / 3)"

# Vérifiez le choix de l'utilisateur
switch ($Choix) {
    "1" {
        Stop-Computer -Force
    }
    "2" {
        powercfg.exe -hibernate on
        Rundll32.exe Powrprof.dll,SetSuspendState Hibernate
    }
    "3" {
        Restart-Computer -Force
    }
    Default {
        Write-Host "
Option invalide.
Veuillez choisir une option valide (1 / 2 / 3)."
        Start-Sleep -Seconds 5
    }
}
