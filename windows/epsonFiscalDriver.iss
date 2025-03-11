[Setup]
AppName=epsonFiscalDriver
OutputBaseFilename=InstallEpsonFiscalDriver
AppVersion=1.2.0
WizardStyle=modern
DefaultDirName={autopf}\epsonFiscalDriver
DefaultGroupName=epsonFiscalDriver
UninstallDisplayIcon={app}\epsonFiscalDriver.exe
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "nssm.exe"; DestDir: "{app}"
Source: "restartservice.ps1"; DestDir: "{app}"
Source: "installservice.ps1"; DestDir: "{app}"
Source: "testservice.ps1"; DestDir: "{app}"
Source: "dist\windows\epsonFiscalDriver.exe"; DestDir: "{app}"
Source: "Fierro-fiscalRestart\*"; DestDir: "{app}\Fierro-fiscalRestart"; Flags: recursesubdirs

[Icons]
Name: "{group}\Configurar servicio epsonFiscalDriver"; Filename: "{app}\nssm.exe"; WorkingDir: "{app}"; Parameters: "edit epsonFiscalDriver"
Name: "{group}\Reiniciar servicio epsonFiscalDriver"; Filename: "powershell.exe"; \
    Parameters: "-ExecutionPolicy Bypass -File ""{app}\restartservice.ps1"""; \
    WorkingDir: "{app}"

[Run]
Filename: "powershell.exe"; \
    Parameters: "-ExecutionPolicy Bypass -File ""{app}\installservice.ps1"""; \
    WorkingDir: "{app}"; \
    Flags: nowait runhidden hidewizard runascurrentuser;

[UninstallRun]
Filename: "{app}\nssm.exe"; \
    Parameters: "stop epsonFiscalDriver"
Filename: "{app}\nssm.exe"; \
    Parameters: "remove epsonFiscalDriver confirm"
Filename: "{app}\nssm.exe"; \
    Parameters: "stop FiscalRestart"
Filename: "{app}\nssm.exe"; \
    Parameters: "remove FiscalRestart confirm"

[UninstallDelete]
Type: files; Name: "{app}\log.txt"