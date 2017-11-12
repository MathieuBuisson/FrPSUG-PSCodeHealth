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
$ComplexitéCyclomaticElevéAst = ConvertTo-FunctionAst -FunctionText $ComplexitéCyclomaticElevé
Measure-FunctionComplexity $ComplexitéCyclomaticElevéAst

#endregion

#region Niveau d’imbrication maximal
Measure-FunctionMaxNestingDepth $ComplexitéCyclomaticElevéAst
Get-PSCodeHealthComplianceRule -SettingsGroup PerFunctionMetrics -MetricName MaximumNestingDepth

$ImbricationComplexe = @'
Function Test-Conditional {
    Param(
        [int]$IfElseif
    )
    If ( $IfElseif -gt 20 ) {
        If ( $IfElseif -gt 40 ) {
            Write-Host 'IfElseif is between 20 and 40'
        }
        Else {
            Write-Host 'IfElseif is greater than 40'
        }
    }
    Else {
        If ( $IfElseif -ge 10 ) {
            Write-Host 'IfElseif is a 2 digit number'
        }
        Else {
            For ($i = 1; $i -lt 99; $i++) {
                Write-Host "$($IfElseif + $i)"       
                For ($j = 0; $j -lt 10; $j++) {
                    Write-Host "$($IfElseif - $j)"
                }
            }
        }
    }
}
'@
$ImbricationComplexeAst = ConvertTo-FunctionAst -FunctionText $ImbricationComplexe
Measure-FunctionMaxNestingDepth $ImbricationComplexeAst

#endregion