
#region Tests unitaires pour la fonction Add-CoverageInfo
Describe 'Add-CoverageInfo' {

    $CoverageSet = 'CoverageResult1', 'CoverageResult2'

    Context '$Value est un objet de type [string]' {
        $TestValue = 'Any'
        $Results = Add-CoverageInfo -CoverageResultSet $CoverageSet -Value $TestValue

        It 'Chaque objet dans le résultat a une propriété nommée "CoverageResult"' {
            Foreach ( $Result in $Results ) {
                $Result | Get-Member -MemberType NoteProperty -Name 'CoverageResult' |
                Should Not BeNullOrEmpty
            }
        }
        It 'Chaque objet dans le résultat a une propriété "CoverageResult" avec une valeur égale à $Value' {
            Foreach ( $Result in $Results ) {
                $Result.CoverageResult | Should Be 'Any'
            }
        }
    }
    Context '$Value est un objet de type [bool]' {
        $TestValue = $False
        $Results = Add-CoverageInfo -CoverageResultSet $CoverageSet -Value $TestValue
        
        It 'Chaque objet dans le résultat a une propriété nommée "CoverageResult"' {
            Foreach ( $Result in $Results ) {
                $Result | Get-Member -MemberType NoteProperty -Name 'CoverageResult' |
                Should Not BeNullOrEmpty
            }
        }
        It 'Chaque objet dans le résultat a une propriété "CoverageResult" avec une valeur égale à $Value' {
            Foreach ( $Result in $Results ) {
                $Result.CoverageResult | Should Be $False
            }
        }
    }
    Context '$Value est Null' {
        $TestValue = $Null
        $Results = Add-CoverageInfo -CoverageResultSet $CoverageSet -Value $TestValue
        
        It 'Chaque objet dans le résultat a une propriété nommée "CoverageResult"' {
            Foreach ( $Result in $Results ) {
                $Result | Get-Member -MemberType NoteProperty -Name 'CoverageResult' |
                Should Not BeNullOrEmpty
            }
        }
        It 'Chaque objet dans le résultat a une propriété "CoverageResult" avec une valeur égale à $Value' {
            Foreach ( $Result in $Results ) {
                $Result.CoverageResult | Should BeNullOrEmpty
            }
        }
    }
}
#endregion

# Copier dans le script de tests pour coveralls

# Générer un nouveau rapport PSCodeHealth pour voir les progrès
$ReportParams = @{
    Path           = '..\..\coveralls\Coveralls.ps1'
    TestsPath      = '..\..\coveralls\'
    HtmlReportPath = '.\AjoutDeTests.html'
    PassThru       = $True
}
$HealthReport = Invoke-PSCodeHealth @ReportParams
Invoke-Item '.\AjoutDeTests.html'
