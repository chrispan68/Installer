echo off
set javaversion=%1
set terminaldir=%2
set tmpdir=%3
set userdir=%4


%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Command "(gc '%tmpdir%\jdk.table.xml') -replace 'JavaVersion','%javaversion%' | Set-Content '%userdir%\.IdeaIC2018.1\config\options\jdk.table.xml'
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Command "(gc '%tmpdir%\terminal.xml') -replace 'TerminalLocation','%terminaldir%' | Set-Content '%userdir%\.IdeaIC2018.1\config\options\terminal.xml'