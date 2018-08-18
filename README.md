# Installer
Create a working directory for the installer. Download everything in this repo to that directory, after that you'll need a few more things. Create a few additional empty directories in that working directory. Name them "jdk" , "ide-prefs", "lift-cli" and "output".

Go to this link: https://git-scm.com/download/win. Download the .exe file into that same working directory. (Should look something like: Git-*******-64-bit.exe)

Go to this link: https://www.jetbrains.com/idea/download/#section=windows. Download the Community Edition .exe file into the working directory. (Should look something like ideaIC-******.***.exe)

Go to this link: http://lift.cs.princeton.edu/java/windows/IdeaIC2018.2.zip. Download the IdeaIC2018.2.zip file. Un-zip the IdeaIC2018.2.zip file into the "ide-prefs" directory of the working directory.

Go to this link: http://lift.cs.princeton.edu/java/windows/lift-cli.zip. Download the lift-cli.zip file. Un-zip the lift-cli.zip file into the lift-cli folder of the working directory. 

Go to this link:http://jdk.java.net/10. You should see the following screen:
![alt_text](https://github.com/chrispan68/Installer/blob/master/openjdksnapshot.png)
Click on the circled install to install the .tar.gz file. Open up either command prompt or terminal and navigate to the directory that the downloaded .tar.gz file is. Type the following command into your command prompt or terminal window: tar -C <path to working directory>/jdk -zxvf openjdk-10.0.2_windows-x64_bin.tar.gz, (except replace <path to working directory> with the actual path to your working directory). The resulting command should look something like this, where "C:\Users\Chris Pan\LIFT-CS\Installer" is my working directory:
![alt_text](https://github.com/chrispan68/Installer/blob/master/cmd-targz-unzipping.png)

Go to this link: http://www.jrsoftware.org/isdl.php. Download the Innosetup software by clicking on the circled link:
![alt_text](http://www.jrsoftware.org/isdl.php)
Follow the installer instructions. 

Navigate to the working directory and open the LIFT-Installer.iss file. (This should open the with Inno Setup Compiler by default). You should see a screen like this: 
![alt_text](https://github.com/chrispan68/Installer/blob/master/inno-setup-compilation.png)
The circled section contains a bunch of defined constants. For example, #define XMingInstaller "Xming-6-9-0-31-setup.exe", causes XMingInstaller to be defined as Xming-6-9-0-31-setup.exe. The only part of the script that needs to be updated is this section.

Make any updates that need to happen:
1) Define WorkingDirectory as the path to your working directory that you created before. 
2) Define IntelliJInstaller as the filename of the intellij installer you downloaded earlier, should be an .exe file.
3) Define GitBashInstaller as the filename of the git installer you downloaded earlier, should be an .exe file.
4) Define XMingInstaller as the filename of the XMing installer you downloaded earlier, should be an .exe file.
5) Define IntelliJVersion as the version of IntelliJ you installed. (You can tell what version it is, since the file name of the IntelliJ installer you referenced in step 2 should be "ideaIC-<version>.exe, use this <version>.) It should be in a format of a year a period then a number, such as "2018.3", or "2019.1".
6) Define JDKVersion as the version of the java jdk. Should be a number then a period then a number then a period then a number, such as 10.0.2 , or 10.1.3. (You can tell what the JDKVersion is by going into the jdk folder of the working directory and looking at the folder name inside that folder. The name of the folder is in the form of jdk-<version> and this <version> is what you want to set as the jdk verion. For example, my folder is named "jdk-10.0.2".)
  
Ctrl+S to save the Inno script file. The working directory should look like this:
