
; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
; This script will take ~2-3 minutes to compile
#define MyAppName "LIFT-CS Java Programming Environment"
#define MyAppVersion "1.0.1"
#define MyAppPublisher "Princeton LIFT-CS"
#define MyAppURL "https://lift.cs.princeton.edu/java/windows"

;These are the only things that need to be changed as external sources update their software
#define WorkingDirectory "C:\Users\Chris Pan\LIFT-CS\Installer"
#define IntelliJInstaller "ideaIC-2018.2.exe"
#define GitBashInstaller "Git-2.18.0-64-bit.exe"
#define XMingInstaller "Xming-6-9-0-31-setup.exe"
#define JDKVersion "10.0.2"
;The IntelliJVersion should not be updated beyond one decimal point (i.e. not 2018.2.2)
#define IntelliJVersion "2018.2"





[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
; The initial left curly brace below is used to escape the one right after it. 
AppId={{2304E6BC-8281-4016-960C-AD630C4937FA}  
AppName={#MyAppName}
AppVersion={#MyAppVersion}                                                 
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf64}/LIFT-CS
DefaultGroupName={#MyAppName}
LicenseFile={#WorkingDirectory}\license.rtf
OutputDir={#WorkingDirectory}\output
OutputBaseFilename=lift-java-installer
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
UsePreviousAppDir=no
SetupLogging=yes
ExtraDiskSpaceRequired=2000000000
ArchitecturesAllowed=x64
MinVersion=6.1
ChangesEnvironment=yes


[Tasks]
Name: installjava; Description: "Install OpenJDK {#JDKVersion}"
Name: installgit; Description: "Install Git Bash"
Name: installintellij; Description: "Install IntelliJ Community Edition {#IntellijVersion}"


[Dirs]
Name: "{%TEMP}\LIFT-CS"

[Files]
;Following 
Source: "{#WorkingDirectory}\{#IntelliJInstaller}"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installintellij; BeforeInstall: SetProgressMax(2) 
Source: "{#WorkingDirectory}\{#XMingInstaller}"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "{#WorkingDirectory}\{#GitBashInstaller}"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "{#WorkingDirectory}\ide-prefs\*"; DestDir: "{tmp}"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: installintellij
Source: "{#WorkingDirectory}\jdk\*"; DestDir: "{pf64}\Java"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: installjava
Source: "{#WorkingDirectory}\lift-cli\*"; DestDir: "{pf64}\Git\usr\local"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: installgit
Source: "{#WorkingDirectory}\.bashrc"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "{#WorkingDirectory}\.bash_profile"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
Source: "{#WorkingDirectory}\.inputrc"; DestDir: "{tmp}"; Flags: ignoreversion; Tasks: installgit
; NOTE: Don't use "Flags: ignoreversion" on any shared system files 

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"


[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{pf64}\Java\jdk-{#JDKVersion}\bin;{olddata}"; \
    Check: NeedsAddPath(ExpandConstant('{pf64}\Java\jdk-{#JDKVersion}\bin')); Tasks: installjava

Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{pf64}\Git\bin;"; \
    Check: NeedsAddPath(ExpandConstant('{pf64}\Git\bin')); Tasks: installgit


[Run]
;Line below creates the git log file by running the copy command on cmd on a nul first argument, which creates an empty git-log file.
Filename: "{sys}\cmd.exe"; Parameters: "/c copy nul ""{%TEMP}\LIFT-CS\git-log.txt"""; StatusMsg: "Copying Git Log File"; Tasks: installgit; Flags: runasoriginaluser runhidden;
;Line below creates the xming log file by running the copy command on cmd on a nul first argument, which creates an empty xming-log file. 
Filename: "{sys}\cmd.exe"; Parameters: "/c copy nul ""{%TEMP}\LIFT-CS\xming-log.txt"""; StatusMsg: "Copying Xming Log File"; Tasks: installgit; Flags: runasoriginaluser runhidden;
Filename: "{tmp}\{#IntelliJInstaller}"; Parameters: "/S";StatusMsg: "Installing IntelliJ 2018.2... (This may take a while)"; Tasks: installintellij;
;Below there is a BeforeInstall procedure which updates the progress bar to 90 percent. 
Filename: "{tmp}\{#XMingInstaller}"; Parameters: "/VERYSILENT /LOG=""{%TEMP}\LIFT-CS\xming-log.txt"""; StatusMsg: "Installing Xming"; Tasks: installgit; BeforeInstall: UpdateProgress(90);
Filename: "{tmp}\{#GitBashInstaller}"; Parameters: "/VERYSILENT /LOG=""{%TEMP}\LIFT-CS\git-log.txt"""; StatusMsg: "Installing Git Bash"; Tasks: installgit; AfterInstall: AddToPath(ExpandConstant('{pf64}\Git\bin'));      
;The four commands below copy the files as non-admins, which lowers the permissions required to access and modify those files. 
;Right below is a BeforeInstall procedure which updates the progress bar to 95 percent.
Filename: "{sys}\Robocopy.exe"; Parameters: """{tmp}"" ""{%USERPROFILE}"" .bashrc ""/LOG:{%TEMP}\LIFT-CS\robocopy-gitbash-log.txt"""; StatusMsg: "Copying .bashrc File"; Tasks: installgit; Flags: runasoriginaluser runhidden; BeforeInstall: UpdateProgress(95)
Filename: "{sys}\Robocopy.exe"; Parameters: """{tmp}"" ""{%USERPROFILE}"" .bash_profile ""/LOG+:{%TEMP}\LIFT-CS\robocopy-gitbash-log.txt"""; StatusMsg: "Copying .bash_profile File"; Tasks: installgit; Flags: runasoriginaluser runhidden;
;Below is an AfterInstall procedure which adds the path to Git\usr\local\bin to path to facilitate access to the LIFT command line tools. Elaborated at bottom of script
Filename: "{sys}\Robocopy.exe"; Parameters: """{tmp}"" ""{%USERPROFILE}"" .inputrc ""/LOG+:{%TEMP}\LIFT-CS\robocopy-gitbash-log.txt"""; StatusMsg: "Copying .inputrc File"; Tasks: installgit; Flags: runasoriginaluser runhidden; AfterInstall: AddToPath(ExpandConstant('{pf64}\Git\usr\local\bin'));
Filename: "{sys}\Robocopy.exe"; Parameters: """{tmp}\.IdeaIC{#IntelliJVersion}"" ""{%USERPROFILE}\.IdeaIC{#IntelliJVersion}"" /e /mir ""/LOG:{%TEMP}\LIFT-CS\robocopy-intellij-log.txt"""; StatusMsg: "Copying IntelliJ Preferences"; Tasks: installintellij; Flags: runasoriginaluser runhidden;

[UninstallDelete]
Type: filesandordirs; Name: "{%HOMEPATH}\.IdeaIC{#IntelliJVersion}" 
Type: filesandordirs; Name: "{pf}\Xming"
Type: filesandordirs; Name: "{pf64}\JetBrains"
Type: dirifempty; Name: "{pf64}\Java"
Type: dirifempty; Name: "{pf64}\Git\usr"
Type: dirifempty; Name: "{pf64}\Git"
 
[UninstallRun]  
;Runs the component uninstallers for intellij, git and xming
Filename: "{pf64}\JetBrains\IntelliJ IDEA Community Edition {#IntelliJVersion}\bin\Uninstall.exe"; Tasks: installintellij
Filename: "{pf64}\Git\unins000.exe"; Tasks: installgit
Filename: "{pf}\Xming\unins000.exe"; Tasks: installgit

[Code]
{function NeedsAddPath taken from user Helen Dyakonova on this stackoverflow post https://stackoverflow.com/questions/3304463/how-do-i-modify-the-path-environment-variable-when-running-an-inno-setup-install/3431379#3431379}
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

{Procedures SetProgressMax and UpdateProgress taken from user Martin Prikryl on this stackoverflow post https://stackoverflow.com/questions/36314079/inno-setup-prevent-extraction-of-files-from-setting-progress-bar-to-100}
procedure SetProgressMax(Ratio: Integer);
begin
  WizardForm.ProgressGauge.Max := WizardForm.ProgressGauge.Max * Ratio;
end;

procedure UpdateProgress(Position: Integer);
begin
  WizardForm.ProgressGauge.Position := Position * WizardForm.ProgressGauge.Max div 100;
end;


{Procedures RemovePath and Code in CurUninstallStepChanged taken from user Martin Prikryl on this stackoverflow post https://stackoverflow.com/questions/35410421/inno-setup-remove-path-from-path-environment-variable-while-uninstalling-a-pro}
const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

procedure RemovePath(Path: string);
var
  Paths: string;
  P: Integer;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', Paths) then
  begin
    Log('PATH not found');
  end
    else
  begin
    Log(Format('PATH is [%s]', [Paths]));

    P := Pos(';' + Uppercase(Path) + ';', ';' + Uppercase(Paths) + ';');
    if P = 0 then
    begin
      Log(Format('Path [%s] not found in PATH', [Path]));
    end
      else
    begin
      if P > 1 then P := P - 1;
      Delete(Paths, P, Length(Path) + 1);
      Log(Format('Path [%s] removed from PATH => [%s]', [Path, Paths]));

      if RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', Paths) then
      begin
        Log('PATH written');
      end
        else
      begin
        Log('Error writing PATH');
      end;
    end;
  end;
end;
{This procedure was created to append a string to path, this is used due to a complication which is elaborated on at the bottom of the script}
procedure AddToPath(Path: string);
var
  CurPath: string;
begin

if NeedsAddPath(Path) then
begin
    if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', CurPath) then
    begin
      Log('PATH not found');
    end
      else
    begin
      CurPath := CurPath + ';' + Path + ';';
      if RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', CurPath) then
      begin
        Log('PATH written');
      end
        else
      begin
        Log('Error writing PATH');
      end;
    end;
end;

end;   
{This procedure is run every time the uninstallation step changes. When it gets to a certain step, namely usUninstall, it removes many registry entries from the path which we added}
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then
  begin
    RemovePath(ExpandConstant('{pf64}\Java\jdk-{#JDKVersion}\bin'));
    RemovePath(ExpandConstant('{pf64}\Git\bin'));
    RemovePath(ExpandConstant('{pf64}\Git\usr\local\bin'));
  end;
end;

{There was a minor complication arising in which the Git installer removes any previous references to the git path from the registry.}
{This caused an issue since due to the section ordering of InnoSetup, the git installer runs after any registry changes we make.}
{Thus I had to actually add Git\usr\local\bin to the registry from a post-install procedure in the run section rather than the recommended registry section.}

