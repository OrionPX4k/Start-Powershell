########################################
############ fourth Script #############
######## Générateur de Nombre ##########
########################################

function Generation([int]$longueur) {
    $chiffreBase10 = "0123456789"
    $nombreGenere = ""
    $random = New-Object System.Random

    for ($i = 0; $i -lt $longueur; $i++) {
        $nombreGenere += $chiffreBase10[$random.Next(0, $chiffreBase10.Length)]
    }
    return $nombreGenere
}

$longueur = Read-Host "Entrez le nombre de digit du nombre"

if ($longueur -gt 1) {
    $nombreGenere = Generation $longueur
    Write-Host "Nombre genere : $nombreGenere"
    Sleep 3
} else {
    Write-Host "Veuillez entrer une longueur superieurs a 1."
    Sleep 3
}