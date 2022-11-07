# unzip driver package and chdir
Expand-Archive ".\HPNV.zip"
Set-Location ".\HPNV"

# get absolute path for pnputil
$absPath = Get-Location
$infPath = Join-Path -Path $absPath -ChildPath "\hpvyt11.inf"

# stage and install driver
pnputil.exe /add-driver $infPath

Add-PrinterDriver -Name "HP Envy 4500 series"

Add-PrinterPort -PrinterHostAddress "192.168.1.102"

Add-Printer -Name "HP Envy 4500 series" -DriverName "HP Envy 4500 series" -PortName "192.168.1.102"
