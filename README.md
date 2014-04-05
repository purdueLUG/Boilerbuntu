#Boilerbuntu
A Purdue themed Ubuntu distribution with a collection of scripts useful to Purdue students.

##Building
Run the 'BuildBoilerBuntu' script to build.

* Dependencies
  * squashfs
  * mkisofs
  * git

####Alternative Method

If you are running Ubuntu, install Ubuntu-Builder.
Set up Ubuntu-Builder with Ubuntu 13.04 iso or BoilerBuntu iso.
Exctract files into any directory you wish.
Run merge_script.pl (type perl merge_script.pl in terminal), feeding the script with the extraction directory and the temperary filesystem Ubuntu-Builder set up (default is /home/ubuntu-builder/FileSystem)
All changes will be added to your temp file system.
To test changes select build in ubuntu-builder, or run the build script in /usr/share/ubuntu-builder/extras. ISO will be in the /home/ubuntu-builder directory
