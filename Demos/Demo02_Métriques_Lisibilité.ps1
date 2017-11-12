#region Nombre de lignes de code par fonction
$FonctionPasTrèsLisible = @'
Function Get-VSCodeMemory {
    Param(
        [System.Int32]$Id
    )
    If ( $Id ) {
        $VSCodeProcess = ps -Id $Id
    }
    Else {
        $VSCodeProcess = ps 'code'
    }
    $MemoryTotal = ($VSCodeProcess | Measure 'WorkingSet' -Sum).Sum
    return [int]($MemoryTotal /1MB)
}
'@

$FonctionPasTrèsLisibleAst = ConvertTo-FunctionAst -FunctionText $FonctionPasTrèsLisible
Get-FunctionLinesOfCode $FonctionPasTrèsLisibleAst

#endregion

#region Résultat de PSScriptAnalyzer
Invoke-ScriptAnalyzer -ScriptDefinition $FonctionPasTrèsLisible

$VersionPlusLisible = @'
Function Get-VSCodeMemory {
    Param(
        [System.Int32]$Id
    )
    If ( $Id ) {
        $VSCodeProcess = Get-Process -Id $Id
    }
    Else {
        $VSCodeProcess =  Get-Process -Name 'code'
    }
    $MemoryTotal = ($VSCodeProcess | Measure-Object -Property 'WorkingSet' -Sum).Sum
    return [int]($MemoryTotal /1MB)
}
'@

Invoke-ScriptAnalyzer -ScriptDefinition $VersionPlusLisible