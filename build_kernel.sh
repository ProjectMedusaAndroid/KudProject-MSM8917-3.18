#!/bin/bash

# Settings
export ARCH=arm && export SUBARCH=arm
export CROSS_COMPILE=$(pwd)/gcc/bin/arm-linux-androideabi-
export PATH=$(pwd)/gcc/bin:$PATH
USER=Batu33TR
CORES=$(echo $(nproc --all) Cores Detected)

# Color definition
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

# Get date and time
DATE=$(date +"%m-%d-%y")
BUILD_START=$(date +"%s")

# Set Defconfigs
DEF4=j4primelte_defconfig
DEF6=j6primelte_defconfig

# Set Builder's Username
USER()
{
	# Setup KBUILD_BUILD_USER
	echo "$yellow Current Build Username is $USER $reset"
	echo " "
	read -p "Please Type build_user (E.g: Batu33TR) : " user;
	if [ "${user}" == "" ]; then
		echo " "

		echo "$yellow     Using '$USER' as Username $reset"
	else
		export KBUILD_BUILD_USER=$user
		echo " "
		echo "$yellow     Using '$user' as Username $reset"
	fi
	sleep 2
}

J4PLUSMAKE() {
    export KBUILD_BUILD_USER=$USER
    export KBUILD_BUILD_HOST=MicrosoftAzure
    make O=out CROSS_COMPILE=arm-linux-androideabi- $DEF4
}

J6PLUSMAKE() {
    export KBUILD_BUILD_USER=$USER
    export KBUILD_BUILD_HOST=MicrosoftAzure
    make O=out CROSS_COMPILE=arm-linux-androideabi- $DEF6
}

COMPILE() {
    make O=out CROSS_COMPILE=arm-linux-androideabi- -j$(nproc --all)
}

TIME() {
    # Find how much build has been long
    BUILD_END=$(date +"%s")
    DIFF=$(($BUILD_END - $BUILD_START))
    echo -e "$green Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds $reset"
}

BUILDINFO() {
    echo -e "******************************************************"
    echo "*             ProjectMedusa Build Script"
    echo "*                  Developer:Batu33TR"
    echo "*"
    echo "*          Compiling kernel using Google-GCC"
    echo "*"
    echo "* Some information about parameters set:"
    echo -e "*  > Architecture: $ARCH"
    echo    "*  > Jobs: $CORES"
    echo    "*  > Build user: $KBUILD_BUILD_USER"
    echo    "*  > Build machine: $KBUILD_BUILD_HOST"
    echo    "*  > Build started on: $BUILD_START"
    echo    "*  > ARM32 Toolchain exported"
    echo -e "******************************************************"
    echo " "
}

PS3='Please Select a Device: '
options=("Galaxy J4 Plus" "Galaxy J6 Plus" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Galaxy J4 Plus")
            echo ""
            echo "$cyan Galaxy J4+ Selected $reset"
            echo ""
            USER
            echo ""
            J4PLUSMAKE
            echo ""
            BUILDINFO
            echo ""
            COMPILE
            echo ""
            TIME
            echo ""
            break
            ;;
        "Galaxy J6 Plus")
            echo ""
            echo "$cyan Galaxy J6+ Selected $reset"
            echo ""
            USER
            echo ""
            J6PLUSMAKE
            echo ""
            BUILDINFO
            echo ""
            COMPILE
            echo ""
            TIME
            echo ""
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
