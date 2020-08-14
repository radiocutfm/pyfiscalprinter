[Setup]
AppName=epsonFiscalDriver
OutputBaseFilename=InstallEpsonFiscalDriver
AppVersion=1.1.12
WizardStyle=modern
DefaultDirName={autopf}\epsonFiscalDriver
DefaultGroupName=epsonFiscalDriver
UninstallDisplayIcon={app}\epsonFiscalDriver.exe
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "nssm.exe"; DestDir: "{app}"
Source: "installservice.bat"; DestDir: "{app}"
Source: "dist\windows\epsonFiscalDriver.exe"; DestDir: "{app}"

[Icons]
Name: "{group}\Configurar servicio epsonFiscalDriver"; Filename: "{app}\nssm.exe"; WorkingDir: "{app}"; Parameters: "edit epsonFiscalDriver"
Name: "{group}\Reiniciar servicio epsonFiscalDriver"; Filename: "{app}\restartservice.bat"; WorkingDir: "{app}"

[Run]
Filename: "{app}\installservice.bat"; \
    Flags: nowait hidewizard runhidden runascurrentuser;

[UninstallRun]
Filename: "{app}\nssm.exe"; \
    Parameters: "stop epsonFiscalDriver"
Filename: "{app}\nssm.exe"; \
    Parameters: "remove epsonFiscalDriver confirm"

[UninstallDelete]
Type: files; Name: "{app}\log.txt"
