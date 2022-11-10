function Get-DriverStringsFromINF {
    param(
        [Parameter(Mandatory=$true)]
        [string]$INFFile
    )
    (Get-Content $Path -Delimiter '[' | Where-Object {$_ -Match '(?m)(Strings\])(.*)'}).Substring(8,$($sec.length - 9))
}

function Search-DriverStore {
    param(
        [string]$Name,
        [string]$ProviderName
    )
    if ($ProviderName) {
        pnputil.exe /enum-drivers | Select-String -Pattern $ProviderName -Context 2,4
    }
    else {
        pnputil.exe /enum-drivers | Select-String -Pattern $Name -Context 1,5
    }
    

}

function Test-PrinterPort {
    param(
        [string]$Name
    )
    if (Get-PrinterPort -Name $Name) {
        return $true
    }
    else {
        return $false
    }
}

function Install-PrinterDriver {
    param(
        [Parameter(Mandatory=$true)]
        [string]$DriverName,
        [string]$INFFile
    )
    if ($INFFile) {
        pnputil.exe /add-driver $INFFile
        Add-PrinterDriver -Name $DriverName
    }
    else {
        Add-PrinterDriver -Name $DriverName
    }
}

function Install-NetworkPrinter {

    param(
        [string]$INFFile,
        [Parameter(Mandatory=$true)]
        [string]$Port,
        [string]$PortName,
        [Parameter(Mandatory=$true)]
        [string]$DriverName,
        [string]$PrinterName
    )

    $PortTest = ''
    
    if ($INFFile) {
        pnputil.exe /add-driver $INFFile
        Add-PrinterDriver $DriverName
    }
    if ($PortName) {$PortTest = $PortName}
    else {$PortTest = $Port}

    if (-not (Test-PrinterPort -Name $PortTest)) {
        Add-PrinterPort -Name $PortTest -PrinterHostAddress $Port
    }

    if ($PrinterName) {
        Add-Printer -Name $PrinterName -DriverName $DriverName -PortName $Port
    }
    else {
        Add-Printer -Name $DriverName -DriverName $DriverName -PortName $Port
    }
}