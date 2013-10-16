#!/bin/bash
check=0
while [  $check == 0  ]
do
	PUID=$( zenity --text "Enter your purdue email" --entry ) 
	zenity --info --text "your email is $PUID"
	if zenity --question --text="Is this your email"; then
		check=1
	fi
done 
variable=$(zenity --text "Hello World" --entry )
echo "$variable"
zenity --info --text "$variable"

