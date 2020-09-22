Write-Host "Reiniciando servicio..."

Start-Process -Wait -FilePath "nssm.exe" -Verb RunAs -ArgumentList "restart epsonFiscalDriver"

$service = Get-Service epsonFiscalDriver

Write-Host "Servicio reniciado. Estado del servicio: " $service.Status

Read-Host -Prompt "Presione Enter para finalizar"
