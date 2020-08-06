nssm install epsonFiscalDriver "epsonFiscalDriver.exe" "-p COM1 -t Hasar -p 12345"
nssm set epsonFiscalDriver AppDirectory %CD%
nssm set epsonFiscalDriver AppStdout %CD%\log.txt
nssm set epsonFiscalDriver AppStderr %CD%\log.txt
nssm set epsonFiscalDriver AppStdoutCreationDisposition 4
nssm set epsonFiscalDriver AppStderrCreationDisposition 4
nssm set epsonFiscalDriver AppRotateFiles 1
nssm set epsonFiscalDriver AppRotateOnline 0
nssm set epsonFiscalDriver AppRotateSeconds 86400
nssm set epsonFiscalDriver AppRotateBytes 1048576
nssm start epsonFiscalDriver
