#region Complexité cyclomatique

$FonctionPasComplexe = @'
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
$FonctionPasComplexeAst = ConvertTo-FunctionAst -FunctionText $FonctionPasComplexe
Measure-FunctionComplexity $FonctionPasComplexeAst

# Qu'est-ce que PSCodeHealth en pense ?
Get-PSCodeHealthComplianceRule -SettingsGroup PerFunctionMetrics -MetricName Complexity

$ComplexitéCyclomaticElevé = @'
Function Get-CurrentMonth {
    Switch ( (Get-Date).Month ) {
        1 { $Month = 'January'; break }
        2 { $Month = 'February'; break }
        3 { $Month = 'March'; break }
        4 { $Month = 'April'; break }
        5 { $Month = 'May'; break }
        6 { $Month = 'June'; break }
        7 { $Month = 'July'; break }
        8 { $Month = 'August'; break }
        9 { $Month = 'September'; break }
        10 { $Month = 'October'; break }
        11 { $Month = 'November'; break }
        12 { $Month = 'December'; break }
    }
    Write-Output "Nous sommes au mois de $Month !"
}
'@

#endregion

