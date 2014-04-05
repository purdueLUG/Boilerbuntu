There is a script to build the iso and it should work but I have only tested on my own computers.  Just run it by running the BuildBoilerBuntu file.
This script requires squashfs, mkisofs, and git.  If it doesn't work for you please tell me so I can can check it out.

This is the other way of building it:

If you are running Ubuntu, install Ubuntu-Builder.
Set up Ubuntu-Builder with Ubuntu 13.04 iso or BoilerBuntu iso.
Exctract files into any directory you wish.
Run merge_script.pl (type perl merge_script.pl in terminal), feeding the script with the extraction directory and the temperary filesystem Ubuntu-Builder set up (default is /home/ubuntu-builder/FileSystem)
All changes will be added to your temp file system.
To test changes select build in ubuntu-builder, or run the build script in /usr/share/ubuntu-builder/extras. ISO will be in the /home/ubuntu-builder directory
