########################################
############ fifth Script ##############
########### GUxGMDP Sécure #############
########################################

function PasswordGenerator([int]$length) {
    $caracters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%*_!?-"
    $passWord = ""
    $random = New-Object System.Random

    for ($i = 0; $i -lt $length; $i++) {
        $passWord += $caracters[$random.Next(0, $caracters.Length)]
    }
    return $passWord
}

function AddUser {
    $addUserName = Read-Host "`nEntrez le nom d'utilisateur"
    $lengthPassword = Read-Host "Entrez la taille de votre mot de passe"
    $passWord = PasswordGenerator $lengthPassword
    $passWordSecure = ConvertTo-SecureString -String $passWord -AsPlainText -Force

    $params = @{
        Name                = $addUserName
        Password            = $passWordSecure
        AccountNeverExpires = $true
        PasswordNeverExpires = $true
        UserMayNotChangePassword = $true
    }

    $createFile = "C:\Users\tlebouc\Documents\Powershell\Gestionnaire Utilisateurs\$addUserName.txt"
    Add-Content -Path $createFile -Value "Nom d'utilisateur : $addUserName"
    Add-Content -Path $createFile -Value "Mot de passe : $passWord"
    Add-Content -Path $createFile -Value "Status : Activé"

    New-LocalUser @params
    Write-Host "`nUtilisateur ajouté avec succès.`n"
}

function DesactivateUser {
    $desactivateUser = Read-Host "`nEntrez le nom d'utilisateur à désactiver"
    try {
        Disable-LocalUser -Name $desactivateUser -ErrorAction Stop
        Write-Host "`nUtilisateur désactivé avec succès`n"
        $editFile = "C:\Users\tlebouc\Documents\Powershell\Gestionnaire Utilisateurs\$desactivateUser.txt"
        (Get-Content -Path $editFile) |
            ForEach-Object {$_ -Replace 'Activé', 'Désactivé'} |
                Set-Content -Path $editFile
    } catch {
        Write-Host "Erreur : $_"
    }
}

function ResactivateUser {
    $resactivateUser = Read-Host "`nEntrez le nom d'utilisateur à réactiver"
    try {
        Enable-LocalUser -Name $resactivateUser -ErrorAction Stop
        Write-Host "`nUtilisateur Réactivé avec succès`n"
        $reditFile = "C:\Users\tlebouc\Documents\Powershell\Gestionnaire Utilisateurs\$resactivateUser.txt"
        (Get-Content -Path $reditFile) |
            ForEach-Object {$_ -Replace 'Désactivé', 'Activé'} |
                Set-Content -Path $reditFile
    } catch {
        Write-Host "Erreur : $_"
    }
}

function DeleteUser {
    $deleteUserName = Read-Host "`nEntrez le nom d'utilisateur à supprimer"
    try {
        Remove-LocalUser -Name $deleteUserName -ErrorAction Stop
        Remove-Item "C:\Users\tlebouc\Documents\Powershell\Gestionnaire Utilisateurs\$deleteUserName.txt"
        Write-Host "`nUtilisateur supprimé avec succès`n"
    } catch {
        Write-Host "Erreur : $_"
    }
}

function UsersList {
    $users = Get-LocalUser
    Write-Host "`nListe des utilisateurs locaux :`n"
    foreach ($user in $users) {
        Write-Host "Nom d'utilisateur : $($user.Name)"
        $status = if ($user.Enabled) {
            "Activé"
        } else {
            "Désactivé"
        }
        Write-Host "Statut : $status`n"
    }
}

do {
    # Efface l'ecran dans la boucle
    Clear-Host

    # Menu interactif
    Write-Host "Menu de gestion des utilisateurs locaux`n"
    Write-Host "1. Ajouter un utilisateur"
    Write-Host "2. Désactiver un utilisateur"
    Write-Host "3. Réactiver un utilisateur"
    Write-Host "4. Supprimer un utilisateur"
    Write-Host "5. Afficher la liste des utilisateurs"

    # Variable
    $Choice = Read-Host "`nVeuillez choisir une option (1 / 2 / 3 / 4 / 5)"

    # Exécution de l'option choisie
    switch ($Choice) {
        "1" { AddUser }
        "2" { DesactivateUser }
        "3" { ResactivateUser }
        "4" { DeleteUser }
        "5" { UsersList }
        Default {
            Write-Host "`nOption invalide.
Veuillez choisir une option valide (1 / 2 / 3 / 4 / 5)."
        }
    }

    $Continue = Read-Host "Voulez-vous continuer ([O] Oui / [N] Non) ?"
} while ($Continue -eq "O" -or $Continue -eq "o")