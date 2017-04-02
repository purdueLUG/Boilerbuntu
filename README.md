# Boilerbuntu
A Purdue themed Ubuntu distribution with a collection of scripts useful to Purdue students.

## Dependencies
    - unsquashfs (provided by squashfs-tools)
    - mksquashfs (provided by squashfs-tools)
    - glib-compile-schemas (provided by glib2)
    - mkisofs (provided by genisoimage)

## Building

Check that you have the proper dependencies installed.

    make verify_dependencies
    
Build the Boilerbuntu iso

    make
    
Alternatively, you can extract the source iso, make some changes, then build the Boilerbuntu iso

    # unpack everything to `squashfs-root`
    make unpack_iso
    
    # copy Boilerbuntu themes and files to `squashfs-root`
    make install_boilerbuntu
    
    # make your own changes in `squashfs-root` here
    
    # build the Boilerbuntu iso
    make build_iso

## Useful directories

You can find these after booting BoilerBuntu, or in `squashfs-root` on the build computer after building BoilerBuntu.

`/usr/share/ubiquity/gtk` - GTK XML .ui files for ubiquity installer (use glade to edit and view these files)

`/usr/lib/ubiquity/plugins` - ubiquity python scripts for defining logic on each installation page

