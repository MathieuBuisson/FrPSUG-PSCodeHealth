#region Pratiques de style uniformes
$x = Get-RandomNumber

# Accolades sur une nouvelle ligne
If ( $x -ge 0 )
{
    Write-Output '$x est positif !'
}
Else
{
    Write-Output '$x est négatif !'
}

# Accolades sur la même ligne (OTBS)
If ( $x -ge 0 ) {
    Write-Output '$x est positif !'
} Else {
    Write-Output '$x est négatif !'
}

# Accolades sur la même ligne (Stroustrup)
If ( $x -ge 0 ) {
    Write-Output '$x est positif !'
}
Else {
    Write-Output '$x est négatif !'
}

# C'est une question de préférence personnelle (ou d'équipe).
# L'important est de choisir un style et de s'y tenir.
#endregion

#region Sémantique claire et descriptive
Function F {
    ls ..\DemoHelpers\*.ps1 -h | % { . $_.FullName }
}

# Même fonction avec nom descriptif
Function Import-HelperFunctions {
    ls ..\DemoHelpers\*.ps1 -h | % { . $_.FullName }
}

# Même fonction sans alias
Function Import-HelperFunctions {
    Get-ChildItem ..\DemoHelpers\*.ps1 -h | ForEach-Object { . $_.FullName }
}

# Même fonction avec paramètres explicités
Function Import-HelperFunctions {
    Get-ChildItem -Path '..\DemoHelpers\*.ps1' -Hidden | ForEach-Object -Process { . $_.FullName }
}

# Même fonction divisée en plusieurs lignes pour faciliter la lecture et le débogage
Function Import-HelperFunctions {
    $FilesToLoad = Get-ChildItem -Path '..\DemoHelpers\*.ps1' -Hidden
    
    Foreach ( $File in $FilesToLoad ) {
        . $File.FullName
    }
}

#endregion
