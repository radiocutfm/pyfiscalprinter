$pwd = (Get-Location).Path
.\nssm.exe install epsonFiscalDriver "epsonFiscalDriver.exe" "-d COM60 -t Hasar -p 12345"
.\nssm.exe set epsonFiscalDriver AppDirectory $pwd
.\nssm.exe set epsonFiscalDriver AppStdout $pwd\log.txt
.\nssm.exe set epsonFiscalDriver AppStderr $pwd\log.txt
.\nssm.exe set epsonFiscalDriver AppStdoutCreationDisposition 4
.\nssm.exe set epsonFiscalDriver AppStderrCreationDisposition 4
.\nssm.exe set epsonFiscalDriver AppRotateFiles 1
.\nssm.exe set epsonFiscalDriver AppRotateOnline 0
.\nssm.exe set epsonFiscalDriver AppRotateSeconds 86400
.\nssm.exe set epsonFiscalDriver AppRotateBytes 1048576
.\nssm.exe start epsonFiscalDriver

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