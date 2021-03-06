#region Nombre de lignes de code par fonction
$FonctionPasTrèsLisible = @'
Function Get-VSCodeMemory {
    Param(
        [System.Int32]$Id
    )
    If ( $Id ) {
        $P = ps -Id $Id
    }
    Else {
        $P = ps 'code'
    }
    $MemoryTotal = ($P | Measure 'WorkingSet' -Sum).Sum
    return [int]($MemoryTotal /1MB)
}
'@

$FonctionPasTrèsLisibleAst = ConvertTo-FunctionAst -FunctionText $FonctionPasTrèsLisible
Get-FunctionLinesOfCode $FonctionPasTrèsLisibleAst

# Est-ce que c'est peu ? Beaucoup ? Beaucoup trop ?
Get-PSCodeHealthComplianceRule -SettingsGroup PerFunctionMetrics -MetricName LinesOfCode

#endregion

#region Résultat de PSScriptAnalyzer
Invoke-ScriptAnalyzer -ScriptDefinition $FonctionPasTrèsLisible

# Est-ce que c'est bien ou pas ?
Get-PSCodeHealthComplianceRule -SettingsGroup PerFunctionMetrics -MetricName ScriptAnalyzerFindings

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

#endregion