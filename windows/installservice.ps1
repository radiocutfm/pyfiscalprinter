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
