function Get-DriverNameFromINF {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    Get-Content $Path | Select-String -Pattern '[Strings]' -Context 0,2 | Select-String -Pattern '\w+Driver\w*'    
}

function Test-DriverStore {
    param(
        [string]$Name
        [string]$ProviderName
    )
    if ($ProviderName) {
        pnputil.exe /enum-drivers | Select-String -Pattern $Name -Context 1,5
    }
    else ($Name) {
        pnputil.exe /enum-drivers | Select-String -Pattern $ProviderName -Context 2,4
    }
    

}



function Install-PrinterDriver {

    param(
        [Parameter(Mandatory=$true)]
        [string]$Port
        [string]$PortName
        [Parameter(Mandatory=$true)]
        [string]$DriverName
    )
}

$printerVariables = @{

}