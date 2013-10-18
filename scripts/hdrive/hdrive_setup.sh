#Configures and installs hdrive_mount and hdrive_unmount scripts graphically
#2013-10-16 - BoilerBuntu

#Install zenity if it isnt already
if [ -z $(which zenity) ]
then
	read -e -p "Zenity is needed to continue installation, would you like to install it?:[y/n]"
	if [ "$REPLY" = "y" ]
	then
		sudo apt-get install zenity
	fi
fi

#Admin password needed for install and chmod
password=$(zenity --password --title="Administrator password for $(whoami)")
#hdrive mounting location
localmount=$(zenity --entry --title="H drive Location" --text="Please enter where you would like to mount your H drive." --entry-text="/mnt/H_drive")
p_credentials=$(zenity --forms --add-entry="Career Account Username" --add-password="Password" --title="Purdue Account" --text="Please enter your PUID and password")
p_username=$(echo $p_credentials|cut -d'|' -f1)
p_password=$(echo $p_credentials|cut -d'|' -f2)
 
#Create the mounting directory
echo $password | sudo -S mkdir $localmount
sudo chmod 777 $localmount
  
#Generate ssh-key if it doesn't exist
if [ ! -e ~/.ssh/id_rsa.pub ]
then
	ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi

#Copy the ssh-key to the server with bit of piping magic, StrictHostKeyChecking is disabled for the initial connection
cat ~/.ssh/id_rsa.pub | sshpass -p$p_password ssh -oStrictHostKeyChecking=no $p_username@maven.itap.purdue.edu '/bin/cat >> ~/.ssh/authorized_keys'

#Install sshfs if it isn't already
if [ -z $(which sshfs) ]
then
	(sudo apt-get install sshpass sshfs|awk '{print "#" $0}'
	echo "100"
	)|zenity --progress --percentage=0 --auto-close --title="Installing sshfs"
fi

#Add user to the fuse group (possibly unnecessary)
sudo usermod -aG fuse $(whoami)

#Echo the mounting and unmounting commands to external files
echo "sshfs $p_username@maven.itap.purdue.edu: $localmount" | sudo tee /usr/bin/hdrive_mount
echo "sudo umount $localmount" | sudo tee /usr/bin/hdrive_unmount
sudo chmod 777 /usr/bin/hdrive_unmount
sudo chmod 777 /usr/bin/hdrive_mount
zenity --info --text="The H Drive mounting scripts are now installed.  You can mount and unmount your H Drive by running <b>hdrive_mount</b> or <b>hdrive_unmount</b> in a terminal."
