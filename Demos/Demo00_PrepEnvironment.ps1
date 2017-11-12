Set-Location -Path 'C:\git\FrPSUG-PSCodeHealth\Demos'
# Loading helpers
$ScriptsToLoad = (Get-ChildItem '..\DemoHelpers' -File -Filter '*.ps1' -Recurse).FullName
Foreach ( $Script in $ScriptsToLoad ) {
    . $Script
}

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
