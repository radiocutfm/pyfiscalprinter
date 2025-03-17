$pwd = (Get-Location).Path
$restartPath = "$pwd\Fierro-fiscalRestart\dist\fiscalRestart"
.\nssm.exe install FiscalRestart "$restartPath\fiscalRestart.exe"
.\nssm.exe set FiscalRestart AppDirectory $restartPath
.\nssm.exe set FiscalRestart AppStdout "$pwd\Fierro-fiscalRestart\log.txt"
.\nssm.exe set FiscalRestart AppStderr "$pwd\Fierro-fiscalRestart\log.txt"
.\nssm.exe set FiscalRestart AppStdoutCreationDisposition 4
.\nssm.exe set FiscalRestart AppStderrCreationDisposition 4
.\nssm.exe set FiscalRestart AppRotateFiles 1
.\nssm.exe set FiscalRestart AppRotateOnline 0
.\nssm.exe set FiscalRestart AppRotateSeconds 86400
.\nssm.exe set FiscalRestart AppRotateBytes 1048576
.\nssm.exe start FiscalRestart