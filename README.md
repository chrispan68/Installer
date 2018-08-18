# Installer
Create a working directory for the installer. Download everything in this repo to that directory, after that you'll need a few more things. Create a few additional empty directories in that working directory. Name them "jdk" , "ide-prefs", "lift-cli" and "output".

Go to this link: https://git-scm.com/download/win. Download the .exe file into that same working directory. (Should look something like: Git-*******-64-bit.exe)

Go to this link: https://www.jetbrains.com/idea/download/#section=windows. Download the Community Edition .exe file into the working directory. (Should look something like ideaIC-******.***.exe)

Go to this link: http://lift.cs.princeton.edu/java/windows/IdeaIC2018.2.zip. Download the IdeaIC2018.2.zip file. Un-zip the IdeaIC2018.2.zip file into the "ide-prefs" directory of the working directory.

Go to this link: http://lift.cs.princeton.edu/java/windows/lift-cli.zip. Download the lift-cli.zip file. Un-zip the lift-cli.zip file into the lift-cli folder of the working directory. 

Go to this link:http://jdk.java.net/10. You should see the following screen:
![alt_text](https://github.com/chrispan68/Installer/blob/master/openjdksnapshot.png)
Click on the circled install to install the .tar.gz file. Open up either command prompt or terminal and navigate to the directory that the downloaded .tar.gz file is. Type the following command into your command prompt or terminal window: tar -C <path to working directory>/jdk -zxvf openjdk-10.0.2_windows-x64_bin.tar.gz, (except replace <path to working directory> with the actual path to your working directory). The resulting command should look something like this, where "C:\Users\Chris Pan\LIFT-CS\Installer" is my working directory:

  
  
