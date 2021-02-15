#!/bin/bash

# Settings
USER=Batu33TR
HOST=MicrosoftAzure
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

ENVSET() {
    export ARCH=arm && export SUBARCH=arm
    export CROSS_COMPILE=$(pwd)/gcc/bin/arm-linux-androideabi-
    export PATH=$(pwd)/gcc/bin:$PATH
    export KBUILD_BUILD_USER=$USER
    export KBUILD_BUILD_HOST=$HOST
}

J4PLUSMAKE() {
    make O=out CROSS_COMPILE=arm-linux-androideabi- $DEF4
}

J6PLUSMAKE() {
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
            echo "$cyan Samsung Galaxy J4+ Selected $reset"
            echo ""
	    ENVSET
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
            echo "$cyan Samsung Galaxy J6+ Selected $reset"
            echo ""
	    ENVSET
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
