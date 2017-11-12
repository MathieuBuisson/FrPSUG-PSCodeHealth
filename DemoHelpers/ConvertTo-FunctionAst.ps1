Function ConvertTo-FunctionAst {
    Param(        
        [string]$FunctionText
    )
    
    $Ast = [System.Management.Automation.Language.Parser]::ParseInput($FunctionText, [ref]$Null, [ref]$Null)
    $Predicate = { $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }
    $Ast.FindAll($Predicate, $False)
}