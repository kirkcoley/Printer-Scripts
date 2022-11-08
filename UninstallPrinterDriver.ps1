Write-Host "Removing printer, driver, and port..."
Remove-Printer -Name "HP Envy 4500 series"

Remove-PrinterDriver -Name "HP Envy 4500 series"

Remove-PrinterPort -Name "hp_print_port"

Write-Host "Deleting drivers from store..."
pnputil.exe /delete-driver oem32.inf
pnputil.exe /delete-driver oem34.inf
pnputil.exe /delete-driver oem38.inf

Write-Host "Deleting temporary filesystem items..."
Remove-Item -Recurse -Path C:\HPNV\HPNV
Remove-Item -Path "C:\Users\kirkc\OneDrive\Desktop\driverjunk\HPNV.zip"

Set-Location -Path "C:\Users\kirkc\OneDrive\Desktop\driverjunk"

Write-Host "Done."