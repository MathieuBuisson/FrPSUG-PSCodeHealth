$FonctionSansAide = @'
Function Import-HelperFunctions {
    $FilesToLoad = Get-ChildItem -Path '..\DemoHelpers\*.ps1' -Hidden
    
    Foreach ( $File in $FilesToLoad ) {
        . $File.FullName
    }
}
'@

$FonctionSansAideAst = ConvertTo-FunctionAst -FunctionText $FonctionSansAide
Test-FunctionHelpCoverage $FonctionSansAideAst

$FonctionAvecAide = @'
<#
.SYNOPSIS
    Loads helper functions into the current scope
.DESCRIPTION
    Loads all PowerShell helper functions located in the "DemoHelpers" directory into the current scope.
#>
Function Import-HelperFunctions {
    $FilesToLoad = Get-ChildItem -Path '..\DemoHelpers\*.ps1' -Hidden
    
    Foreach ( $File in $FilesToLoad ) {
        . $File.FullName
    }
}
'@

$FonctionAvecAideAst = ConvertTo-FunctionAst -FunctionText $FonctionAvecAide
Test-FunctionHelpCoverage $FonctionAvecAideAst

# Fonctionne avec l'aide juste avant la fonction ou dans la fonction