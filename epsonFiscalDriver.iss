[Setup]
AppName=epsonFiscalDriver
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
Source: "dist/windows/epsonFiscalDriver.exe"; DestDir: "{app}"
Source: "README.md"; DestDir: "{app}"; Flags: isreadme
