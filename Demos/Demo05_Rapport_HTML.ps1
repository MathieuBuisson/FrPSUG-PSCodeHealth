# Projet PowerShell utilisé comme example 
$ChromePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
& $ChromePath 'https://github.com/JanJoris/coveralls'

# Coveralls.io, c'est quoi ?
& $ChromePath 'https://coveralls.io/'

#region Examples d'utilisation basique de PSCodeHealth 
Import-Module 'C:\git\PSCodeHealth\PSCodeHealth\PSCodeHealth.psd1' -Force

$HealthReport = Invoke-PSCodeHealth -Path '..\..\coveralls\Coveralls.ps1' -TestsPath '..\..\coveralls\'
$HealthReport

# Pour voir toutes les propriétés du rapport
$HealthReport | Select-Object -Property '*' -Exclude 'FunctionHealthRecords'

# Détails par fonctions
$HealthReport.FunctionHealthRecords
#endregion

#region Générer un rapport PSCodeHealth sous forme de fichier HTML
Invoke-PSCodeHealth -Path '..\..\coveralls\Coveralls.ps1' -TestsPath '..\..\coveralls\' -HtmlReportPath '.\Report.html'
Invoke-Item '.\Report.html'

#endregion
