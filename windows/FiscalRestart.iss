[Setup]
AppName=FiscalRestart
OutputBaseFilename=InstallFiscalRestart
AppVersion=1.0.0
WizardStyle=modern
DefaultDirName={autopf}\FiscalRestart
DefaultGroupName=FiscalRestart
UninstallDisplayIcon={app}\FiscalRestart.exe
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "nssm.exe"; DestDir: "{app}"
Source: "installservice-fiscalrestart.ps1"; DestDir: "{app}"
Source: "Fierro-fiscalRestart\*"; DestDir: "{app}\Fierro-fiscalRestart"; Flags: recursesubdirs

[Run]
Filename: "powershell.exe"; \
    Parameters: "-ExecutionPolicy Bypass -File ""{app}\installservice-fiscalrestart.ps1"""; \
    WorkingDir: "{app}"; \
    Flags: nowait runhidden hidewizard runascurrentuser;

[UninstallRun]
Filename: "{app}\nssm.exe"; \
    Parameters: "stop FiscalRestart"
Filename: "{app}\nssm.exe"; \
    Parameters: "remove FiscalRestart confirm"

[UninstallDelete]
Type: files; Name: "{app}\log.txt"