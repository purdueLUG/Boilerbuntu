# Boilerbuntu
A Purdue themed Ubuntu distribution with a collection of scripts useful to Purdue students.

## Useful directories

You can find these after booting BoilerBuntu, or in `squashfs-root` on the build computer after building BoilerBuntu.

`/usr/share/ubiquity/gtk` - GTK XML .ui files for ubiquity installer (use glade to edit and view these files)

`/usr/lib/ubiquity/plugins` - ubiquity python scripts for defining logic on each installation page

##Building
Run the 'BuildBoilerBuntu' script to build.

* Dependencies
  * squashfs
  * mkisofs

#### Alternative Method

If you are running Ubuntu, install Ubuntu-Builder.
Set up Ubuntu-Builder with Ubuntu 13.04 iso or BoilerBuntu iso.
Exctract files into any directory you wish.
Run merge_script.pl (type perl merge_script.pl in terminal), feeding the script with the extraction directory and the temperary filesystem Ubuntu-Builder set up (default is /home/ubuntu-builder/FileSystem)
All changes will be added to your temp file system.
To test changes select build in ubuntu-builder, or run the build script in /usr/share/ubuntu-builder/extras. ISO will be in the /home/ubuntu-builder directory
