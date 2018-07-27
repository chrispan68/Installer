; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "TestingCommandFile"
#define MyAppVersion "1.5"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.example.com/"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2304E6BC-8281-4016-960C-AD630C4937FA}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\TestingBatchFile
DefaultGroupName={#MyAppName}
LicenseFile=C:\Users\Chris Pan\Windows Downloader\liscence.txt
OutputDir=C:\Users\Chris Pan\Windows Downloader\
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: installjava; Description: "Install Java JDK"
Name: installgit; Description: "Install Git"
Name: installintellij; Description: "Install Intellij Community Edition" 

[Files]
Source: "C:\Users\Chris Pan\Windows Downloader\ideaIC-2018.1.6.exe"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installintellij
Source: "C:\Users\Chris Pan\Windows Downloader\Xming-6-9-0-31-setup.exe"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "C:\Users\Chris Pan\Windows Downloader\Git-2.18.0-64-bit.exe"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "C:\Users\Chris Pan\Windows Downloader\IdeaIC2018.1\*"; DestDir: "{%HOMEPATH}"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: installintellij
Source: "C:\Users\Chris Pan\Windows Downloader\jdk\*"; DestDir: "{pf64}\Java"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: installjava
Source: "C:\Users\Chris Pan\Windows Downloader\testingoutput\jdk.table.xml"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installintellij
Source: "C:\Users\Chris Pan\Windows Downloader\testingoutput\terminal.xml"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installintellij
Source: "C:\Users\Chris Pan\Windows Downloader\postscript.bat"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installintellij
; NOTE: Don't use "Flags: ignoreversion" on any shared system files 


[Run]
Filename: "{tmp}\ideaIC-2018.1.6.exe"; Parameters: "/S /D={pf64}\JetBrains"; StatusMsg: "Installing Intellij... (This may take a while)"; Tasks: installintellij
Filename: "{tmp}\Xming-6-9-0-31-setup.exe"; Parameters: "/SILENT /LOG"; StatusMsg: "Installing XMing"; Tasks: installgit
Filename: "{tmp}\Git-2.18.0-64-bit.exe"; Parameters: "/SILENT"; StatusMsg: "Installing Git"; Tasks: installgit        
Filename: "{tmp}\postscript.bat"; Parameters: "10.0.1 ""{pf64}\Git\bin\sh.exe"" ""{tmp}"" ""{%HOMEPATH}"""; Flags: runasoriginaluser; Tasks: installintellij             

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{pf64}\Java\jdk-10.0.1\bin;{olddata}"; \
    Check: NeedsAddPath(ExpandConstant('{pf64}\Java\jdk-10.0.1\bin')); Tasks: installjava

Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "%SystemRoot%\system32\WindowsPowerShell\v1.0"; \
    Check: NeedsAddPath('%SystemRoot%\system32\WindowsPowerShell\v1.0')

[Code]

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(
    HKLM,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Log(Param);
  Log(OrigPath);
  Result :=
    (Pos(';' + UpperCase(Param) + ';', ';' + UpperCase(OrigPath) + ';') = 0) and
    (Pos(';' + UpperCase(Param) + '\;', ';' + UpperCase(OrigPath) + ';') = 0); 
  Log(IntToStr(Integer(Result)));
end;