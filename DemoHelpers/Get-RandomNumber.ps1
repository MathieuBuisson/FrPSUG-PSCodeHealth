Function Get-RandomNumber {
    [CmdletBinding()]
    Param ()

    $Range = -10..10
    $Range | Get-Random -Count 1    
}