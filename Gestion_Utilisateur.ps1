########################################
############ second Script #############
######### Gestion Utilisateurs #########
########################################

function AjouterUtilisateur {
    $nomUtilisateurAAjouter = Read-Host "Entrez le nom d'utilisateur"
    $motDePasse = Read-Host "Entrez le mot de passe" -AsSecureString
    $params = @{
        Name                = $nomUtilisateurAAjouter
        Password            = $motDePasse
        AccountNeverExpires = $true
        PasswordNeverExpires = $true
        UserMayNotChangePassword = $true
    }

    New-LocalUser @params
    Write-Host "Utilisateur ajouté avec succès."
    pause
}

function SupprimerUtilisateur {
    $nomUtilisateurASupprimer = Read-Host "Entrez le nom d'utilisateur à supprimer"
    try {
        Remove-LocalUser -Name $nomUtilisateurASupprimer -ErrorAction Stop
        Write-Host "Utilisateur supprimé avec succès"
    } catch {
        Write-Host "Erreur : $_"
    }
    pause
}

function DesactiverUtilisateur {
    $nomUtilisateurADesactiver = Read-Host "Entrez le nom d'utilisateur à désactiver"
    try {
        Disable-LocalUser -Name $nomUtilisateurADesactiver -ErrorAction Stop
        Set-LocalUser -Name $nomUtilisateurADesactiver -PasswordNeverExpires $true -UserMayNotChangePassword $true
        Write-Host "Utilisateur désactivé avec succès"
    } catch {
        Write-Host "Erreur : $_"
    }
    pause
}

# Menu interactif
Write-Host "Menu de gestion des utilisateurs locaux"
Write-Host "1. Ajouter un utilisateur"
Write-Host "2. Supprimer un utilisateur"
Write-Host "3. Désactiver un utilisateur"

# Variable
$Choix = Read-Host "Veuillez choisir une option (1 / 2 / 3)"

# Exécution de l'option choisie
switch ($Choix) {
    "1" { AjouterUtilisateur }
    "2" { SupprimerUtilisateur }
    "3" { DesactiverUtilisateur }
    Default {
        Write-Host "
Option invalide.
Veuillez choisir une option valide (1 / 2 / 3)."
        pause
    }
}
