# Installer
Navigate to where you want the working directory to be using cmd or terminal. Type in the following command "git clone https://github.com/chrispan68/Installer.git" to clone the repository in that location in a folder called Installer. The path to your working directory is now going look like <some path>\Installer. 

Go to this link: https://www.jetbrains.com/idea/download/#section=windows. Download the Community Edition .exe file into the working directory. (Should look something like ideaIC-2018.2.exe)

Go to this link:https://lift.cs.princeton.edu/java/windows/openjdk-10.0.2_windows-x64_bin.tar.gz. This should download a tar.gz file. Open up either command prompt or terminal and navigate to the directory that the downloaded .tar.gz file is. Type the following command into your command prompt or terminal window: tar -C <path to working directory>/jdk -zxvf openjdk-10.0.2_windows-x64_bin.tar.gz, (except replace <path to working directory> with the actual path to your working directory). The resulting command should look something like this, where "C:\Users\Chris Pan\LIFT-CS\Installer" is my working directory:
![alt_text](https://github.com/chrispan68/Installer/blob/master/Screenshots/cmd-targz-unzipping.png)

Go to this link: http://www.jrsoftware.org/isdl.php. Download the Innosetup software by clicking on the circled link:
![alt_text](http://www.jrsoftware.org/isdl.php)
Follow the installer instructions. 

Navigate to the working directory and open the LIFT-Installer.iss file. (This should open the with Inno Setup Compiler by default). You should see a screen like this: 
![alt_text](https://github.com/chrispan68/Installer/blob/master/Screenshots/inno-setup-compilation.png)
The circled section contains a bunch of defined constants. For example, #define XMingInstaller "Xming-6-9-0-31-setup.exe", causes XMingInstaller to be defined as Xming-6-9-0-31-setup.exe. The only part of the script that needs to be updated is this section.

Make any updates that need to happen, (most of these things don't need to change at all):
1) Define WorkingDirectory as the path to your working directory that you created before. 
2) Define IntelliJInstaller as the filename of the intellij installer you downloaded earlier, should be an .exe file.
3) Define GitBashInstaller as the filename of the git installer you downloaded earlier, should be an .exe file.
4) Define XMingInstaller as the filename of the XMing installer you downloaded earlier, should be an .exe file.
5) Define IntelliJVersion as the version of IntelliJ you installed. (You can tell what version it is, since the file name of the IntelliJ installer you referenced in step 2 should be "ideaIC-<version>.exe, use this <version>.) It should be in a format of a year a period then a number, such as "2018.3", or "2019.1".
6) Define JDKVersion as the version of the java jdk. Should be a number then a period then a number then a period then a number, such as 10.0.2 , or 10.1.3. (You can tell what the JDKVersion is by going into the jdk folder of the working directory and looking at the folder name inside that folder. The name of the folder is in the form of jdk-<version> and this <version> is what you want to set as the jdk verion. For example, my folder is named "jdk-10.0.2".)
  
Ctrl+S to save the Inno script file. The working directory should look like this:
![alt_text](https://github.com/chrispan68/Installer/blob/master/Screenshots/directory-snip.png)
Next go back to the LIFT-Installer.iss file, (opened with the Inno Setup Compiler.) Click the green run arrow circled:
![alt_text](https://github.com/chrispan68/Installer/blob/master/Screenshots/run-compiler.png)
After the compilation is completed, navigate to your working directory and open the output folder. There should be a file called lift-java-installer.exe. This is the file that you can distribute to students, (after signing it). 

Some information about the files that we pre-populated the directory with. 

The source of the Git Bash installer is: https://git-scm.com/downloads, this will update and needs to be changed, (this means changing the GitBashInstaller constant in the installer as well as downloading the latest version of git from this link.)

The source of the Xming installer is: https://sourceforge.net/projects/xming/. This hasn't changed since 2007 so it is unlikely that future updates will occur. In the event that one does happen, simply go to this link and download the updated installer into the working directory and change the XMingInstaller constant to be the new name of the installer files.

# Updates
Some notes on how to update parts of the installer:

Updating the preferences file: Download the preferences into your working directory from this link: "https://lift.cs.princeton.edu/java/windows/IdeaIC2018.2.zip". Open up your local bash shell, navigate to your working directory and type the following commands:

rm -rf ide-prefs/.IdeaIC2018.2  
unzip IdeaIC2018.2.zip -d ide-prefs

Be careful as the first command completely removes what's in the directory ide-prefs/.IdeaIC2018.2. 

Updating the the LIFT libraries: Download the lift-cli libraries into your working directory from this link: "http://lift.cs.princeton.edu/java/windows/lift-cli.zip". Open up your bash shell, navigate to your working directory and type the following commands:


rm -rf lift-cli/bin   
rm -rf lift-cli/lift   
unzip lift-cli.zip -d lift-cli

Be careful as the first two commands complete remove what's in the directory lift-cli/bin and lift-cli/lift
