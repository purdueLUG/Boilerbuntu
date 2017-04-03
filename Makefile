#!/bin/bash
#   This is the script to build BoilerBuntu
#
#   Copyright 2017 PurdueLUG
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# tell make to run targets in a single shell invocation
.ONESHELL:
# dont print out the bash source
.SILENT:
SHELL := /bin/bash

# Ubuntu input iso
source_iso := ubuntu-17.04-beta2-desktop-amd64.iso
# Generated iso
target_iso := boilerbuntu-17.04-amd64.iso

all: clean unpack install build

# delete build files and unmount iso
clean:
	# make empty dir `mnt` and unmount first if necessary
	if [ -d mnt ]
	then
			if mountpoint mnt > /dev/null
			then
					sudo umount mnt
			fi
	else
			mkdir mnt
	fi

	# delete dir `extract-cd` if it exists
	if [ -d extract-cd ]
	then
			rm -rf extract-cd
	fi

	# delete `squashfs-root` if it exists
	if [ -d squashfs-root ]
	then
			sudo rm -rf squashfs-root
	fi

verify_dependencies:
	set -e
	if which glib-compile-schemas > /dev/null; then
		echo "Checking for glib stuff.  Installed"
	else
		echo "You need the program glib-compile-schemas."
		exit 1
	fi
	if which unsquashfs > /dev/null; then
		echo "Checking for Squshfs.  Installed."
	else
		echo "You need the squashfs-tools.  For debian/ubuntu type sudo apt-get install squashfs-tools.  For other distros it could be different."
		exit 1
	fi
	if which mkisofs > /dev/null; then
		echo "Checking for mkisofs.  Installed."
	else
		echo "You need mkisofs."
		exit 1
	fi

# unpack source_iso to squashfs-root
unpack: clean
	# mount the iso
	sudo mount -o loop $(source_iso) mnt

	# unpack everything on the iso except the Linux filesystem (e.g. EFI stuff, isolinux, etc.)
	rsync --exclude=/casper/filesystem.squashfs -a mnt/ extract-cd
	sudo chmod a+rwx -R extract-cd

	# unpack linux filesystem to squashfs-root
	sudo unsquashfs mnt/casper/filesystem.squashfs
	sudo chmod a+rwx -R squashfs-root

# copy edited files into squashfs-root
install:
	cp boilerbuntu_source/Themes/logos/bunutu_2.png squashfs-root/usr/share/backgrounds
	cp boilerbuntu_source/scripts/hdrive/* squashfs-root/usr/bin/
	cp boilerbuntu_source/scripts/purdue_menu.py squashfs-root/usr/bin/
	cp boilerbuntu_source/Themes/background_changes/com.canonical.unity-greeter.gschema.xml squashfs-root/usr/share/glib-2.0/schemas
	cp boilerbuntu_source/Themes/background_changes/10_ubuntu-settings.gschema.override squashfs-root/usr/share/glib-2.0/schemas/
	rm -rf squashfs-root/lib/plymouth
	cp -r boilerbuntu_source/Themes/theme_options/op1/plymouth/ squashfs-root/lib
	glib-compile-schemas squashfs-root/usr/share/glib-2.0/schemas
	chmod a+w extract-cd/casper/filesystem.manifest
	sudo chroot squashfs-root dpkg-query -W --showformat='${Package} ${Version}\n' > extract-cd/casper/filesystem.manifest
	cp extract-cd/casper/filesystem.manifest extract-cd/casper/filesystem.manifest-desktop
	sed -i '/ubiquity/d' extract-cd/casper/filesystem.manifest-desktop
	sed -i '/casper/d' extract-cd/casper/filesystem.manifest-desktop

# create the boilerbuntu iso
build:
	if [ -e extract-cd/casper/filesystem.squashfs ]
	then
			sudo rm extract-cd/casper/filesystem.squashfs
	fi

	sudo mksquashfs squashfs-root extract-cd/casper/filesystem.squashfs
	sudo mkisofs -D -r -V "BoilerBuntu" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $(target_iso) extract-cd
	sudo umount mnt
	sudo chmod 666 $(target_iso)
