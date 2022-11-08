Write-Host "Expanding archive..."
# unzip driver package and chdir
New-Item -ItemType Directory -Path "C:\HPNV"
Expand-Archive ".\HPNV.zip" -DestinationPath "C:\HPNV"
Set-Location "C:\HPNV\HPNV"

Write-Host "Staging driver to Windows Driver Store..."
# stage and install driver
pnputil.exe /add-driver "C:\HPNV\HPNV\hpvyt11.inf"

Write-Host "Adding print driver, port, and printer..."
Add-PrinterDriver -Name "HP Envy 4500 series"

Add-PrinterPort -Name "hp_print_port" -PrinterHostAddress "192.168.1.102"

Add-Printer -Name "HP Envy 4500 series" -DriverName "HP Envy 4500 series" -PortName "hp_print_port"

Write-Host "Cleaning up..."
Set-Location -Path "C:\" 
Remove-Item -Recurse -Path "C:\HPNV"

Write-Host "Done."