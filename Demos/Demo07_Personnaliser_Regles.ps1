#region Les règles de métriques par défaut
Get-PSCodeHealthComplianceRule

# Plus d'info sur chaque métrique, et comment les seuils des règles ont été définis
& $ChromePath 'http://pscodehealth.readthedocs.io/en/latest/Metrics/'

Get-PSCodeHealthComplianceRule -MetricName 'LinesOfCode','Complexity','TestCoverage'

# Pour avoir uniquement les métriques qui sont évaluées pour chaque fonction
Get-PSCodeHealthComplianceRule -SettingsGroup PerFunctionMetrics

#endregion

#region Vérifier la conformité du projet Coveralls avec les règles par défault
Test-PSCodeHealthCompliance -HealthReport $HealthReport

# Vérifier la conformité uniquement par rapport aux métrique globales
Test-PSCodeHealthCompliance -HealthReport $HealthReport -SettingsGroup OverallMetrics

# Obtenir un seul résultat global, sans les détails
Test-PSCodeHealthCompliance -HealthReport $HealthReport -Summary
#endregion

#region Personnaliser les règles de metriques

# Dans le fichier `MonProjet.json`, on définit une règle de métrique pour le taux de couverture
# On considère que 25% de taux de couverture du code est suffisant pour notre projet
$Params = @{
    CustomSettingsPath = '.\MonProjet.json'
    SettingsGroup = 'OverallMetrics'
}

# Vérifier que notre règle personnalisée prend effet
Get-PSCodeHealthComplianceRule @Params

# Vérifier la conformité du projet Coveralls avec notre règles personnalisée
$ComplianceParams = @{
    CustomSettingsPath  = '.\MonProjet.json'
    SettingsGroup       = 'OverallMetrics'
    HealthReport        = $HealthReport
}
Test-PSCodeHealthCompliance @ComplianceParams

# Faire en sorte que le rapport HTML prenne en compte nos règles personnalisées
$Personnalisé = @{
    Path               = '..\..\coveralls\Coveralls.ps1'
    TestsPath          = '..\..\coveralls\'
    HtmlReportPath     = '.\Personnalisé.html'
    CustomSettingsPath = '.\MonProjet.json'
}
Invoke-PSCodeHealth @Personnalisé
Invoke-Item '.\Personnalisé.html'

#endregion