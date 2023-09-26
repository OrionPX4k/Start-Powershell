#######################################
############ third Script #############
##### Générateur de mot de passe ######
#######################################

function GenererMotDePasse([int]$longueur) {

    $caracteresPermis = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%*_!?-"
    $motDePasse = ""
    $random = New-Object System.Random

    for ($i = 0; $i -lt $longueur; $i++) {
        $motDePasse += $caracteresPermis[$random.Next(0, $caracteresPermis.Length)]
    }
    return $motDePasse
}

$longueur = Read-Host "Entrez la longueur du mot de passe"

if ($longueur -gt 0) {
    $motDePasse = GenererMotDePasse $longueur
    Write-Host "Mot de passe généré : $motDePasse"
} else {
    Write-Host "Veuillez entrer une longueur de mot de passe valide (un nombre positif)."
    Sleep 2
    exit
}

$copierDansPressePapiers = Read-Host "Voulez-vous copier le mot de passe ? ([O]oui/[N]non)"

if ($copierDansPressePapiers -eq "O") {
    $motDePasse | Set-Clipboard
    Write-Host "Le mot de passe a été copié dans le presse-papiers."
    pause
} else {
    Write-Host "Le mot de passe n'a pas été copié dans le presse-papiers."
    pause
}
