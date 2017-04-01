# Boilerbuntu
_A Purdue themed Ubuntu distribution with a collection of scripts useful to Purdue students._

## Building
The following dependencies must be installed beforehand:
```
squashfs
mkisofs
git
```

Run the 'BuildBoilerBuntu' script to build:
```
$ ./BuildBoilerBuntu
```

## Alternative Method

If you are running Ubuntu, install Ubuntu-Builder. Set up Ubuntu-Builder with Ubuntu 17.04 iso or BoilerBuntu iso. Extract files into any directory you wish. Run `merge_script.pl` (type `perl merge_script.pl` in terminal), feeding the script with the extraction directory and the temporary filesystem Ubuntu-Builder set up (default is `/home/ubuntu-builder/FileSystem`) All changes will be added to your temp file system. To test changes select build in ubuntu-builder, or run the build script in `/usr/share/ubuntu-builder/extras`. ISO will be in the `/home/ubuntu-builder` directory.
