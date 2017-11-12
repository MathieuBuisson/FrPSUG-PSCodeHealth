Function Get-RandomNumber {
    [CmdletBinding()]
    Param ()

    $Range = -10..10
    $Range | Get-Random -Count 1    
}

Function ConvertTo-FunctionAst {
    Param(        
        [string]$FunctionText
    )
    
    $Ast = [System.Management.Automation.Language.Parser]::ParseInput($FunctionText, [ref]$Null, [ref]$Null)
    $Predicate = { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }
    $Ast.FindAll($Predicate, $False)
}

Set-Location -Path 'C:\git\FrPSUG-PSCodeHealth\Demos'

# Loading PSCodeHealth private functions
$PSCodeHealthPrivatePath = '..\..\PSCodeHealth\PSCodeHealth\Private'
$PrivateFunctionsToLoad = (Get-ChildItem $PSCodeHealthPrivatePath -File -Filter '*.ps1' -Recurse).FullName
Foreach ( $PrivateFunction in $PrivateFunctionsToLoad ) {
    . $PrivateFunction
}

# Loading PSCodeHealth public functions
$PSCodeHealthPublicPath = '..\..\PSCodeHealth\PSCodeHealth\Public'
$PublicFunctionsToLoad = (Get-ChildItem $PSCodeHealthPublicPath -File -Filter '*.ps1' -Recurse).FullName
Foreach ( $PublicFunction in $PublicFunctionsToLoad ) {
    . $PublicFunction
}

Export-ModuleMember -Function '*'