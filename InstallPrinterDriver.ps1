Write-Output "Creating workspace..."
New-Item -ItemType Directory -Path "C:\HPNV"
Set-Location "C:\HPNV"

Write-Output "Downloading driver package..."
Invoke-WebRequest -Method Get -Uri "https://github.com/kirkcoley/printer-drivers/releases/download/driver/HPNV.zip" -OutFile ".\HPNV.zip"

Write-Output "Expanding archive..."
# unzip driver package and chdir
Expand-Archive ".\HPNV.zip" -DestinationPath "C:\HPNV"


Write-Output "Staging driver to Windows Driver Store..."
# stage and install driver
pnputil.exe /add-driver "C:\HPNV\HPNV\hpvyt11.inf"

Write-Output "Adding print driver, port, and printer..."
Add-PrinterDriver -Name "HP Envy 4500 series"

Add-PrinterPort -Name "hp_print_port" -PrinterOutputAddress "192.168.1.102"

Add-Printer -Name "HP Envy 4500 series" -DriverName "HP Envy 4500 series" -PortName "hp_print_port"

Write-Output "Cleaning up..."
Set-Location -Path "C:\" 
Remove-Item -Recurse -Path "C:\HPNV"

Write-Output "Done."