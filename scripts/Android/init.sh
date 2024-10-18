#!/bin/bash
# 
# Copyright 2024 Florine0928
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

########################################################################
# Function for Toolchain                                               # 
########################################################################

if [ ! -d "Toolchain" ]; then
    echo "Toolchain directory is missing, we will create it"
    mkdir Toolchain
    mkdir Toolchain/GCC
    mkdir Toolchain/TEMP
    mkdir Toolchain/CLANG
fi

#############################################
# Source the variables from the config file #
source ./config.sh                          #
#############################################

# ExremeXT lurks in this script
usage() {
    echo "Usage: $0 [-d <platform>] [-m <clean/dirty>]"
    echo "Example Usage: $0 -d $DEV_AC -t gcc -m dirty -e"
    echo "Options:"
    echo "  -b          Build Kernel for $DEV_AC,$DEV_BC,$DEV_CC"
    echo "  -m          Build Mode clean|dirty"
    echo "  -t          Toolchain"
    echo "  -e          Make boot.img"
    echo "  -h          Display this help message"
    echo "Available Toolchains:"
    echo "   1: $TC_A"
    echo "   2: $TC_B"
    exit 1
}

# Parse options
while getopts "em:b:t:h" opt; do
    case $opt in
        b)
            arg=$OPTARG  # Capture the argument for -b

            if [[ "$arg" == "$DEV_AC" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$DEV_A
                export DEV_DTB=$DEV_AD
            elif [[ "$arg" == "$DEV_BC" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$DEV_B
                export DEV_DTB=$DEV_BD
            elif [[ "$arg" == "$DEV_CC" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$DEV_C
                export DEV_DTB=$DEV_CD
            else            
                echo "Invalid argument for -b: promptly exiting.."
                exit
            fi
            ;;
        e)
                export TARGET_MAKE_BOOTIMG="true"
            ;;
        m)
            arg2=$OPTARG  # Capture the argument for -m

            if [[ "$arg2" == "clean" ]]; then
                unset MODE
                # This is used for when we build kernel
            elif [[ "$arg2" == "dirty" ]]; then
                export MODE="dirty"

            else            
                echo "invalid argument for -m: defaulting to dirty"
                export MODE="dirty"
            fi
            ;;
        h)
            # Print Help Option (ex: ./init.sh -h)
            usage
            ;;
        t)
            arg3=$OPTARG  # Capture the argument for -t
            if [[ "$arg3" == "$TC_A" ]]; then
            export TC="$TC_AD/bin/$TC_AB"
            elif [[ "$arg3" == "$TC_B" ]]; then
            export TC=$TC_BB
            else            
            echo "WARNING: No toolchain selected, falling back to GNU GCC"
            export TC=$TC_BB
            fi

        ;;
    esac
done

########################################################################
#                                                                      #
########################################################################

# Shift arguments so that $@ contains remaining arguments
shift $((OPTIND -1))

# Check if any arguments are left
if [ $# -ne 0 ]; then
    echo "Invalid option: $@"
    usage
fi

if [ "$OPTIND" -eq 1 ]; then
    usage
fi

########################################################################
# Functions for Building the Kernel                                    # 
########################################################################

# Build Defconfig for Device
defconfig() {
make $DEVICE
}

# Build Kernel
build() {
    #If in dirty mode then make kernel while not cleaning workdir 
    make -j$(nproc)
    # If not in dirty mode a extra function with be invoked, refer to func/build_clean at line #116
}

build_clean() {
    make clean && make mrproper
}

########################################################################
# Function for creating boot.img --- Credits to Apollo for Function    #
########################################################################

# Ramdisk Function
PACK_BOOT_IMG()
{
	echo "----------------------------------------------"
	echo " "
	echo "Building Boot.img for $DEVICE"
	# Copy Ramdisk
	cp -rf $RAMDISK/* $AIK
	# Move Compiled kernel and dtb to A.I.K Folder
	mv $KERNEL $AIK/split_img/boot.img-zImage
	mv $DEV_DTB $AIK/split_img/boot.img-dtb
	# Create boot.img
	$AIK/repackimg.sh
	if [ ! -e $AIK/image-new.img ]; then
        exit 0;
        echo "Boot Image Failed to pack"
        echo " Abort "
	fi
	# Remove red warning at boot
	echo -n "SEANDROIDENFORCE" >> $AIK/image-new.img
	# Copy boot.img to Production folder
	if [ ! -e $PRODUCT ]; then
        mkdir $PRODUCT
	fi
	cp $AIK/image-new.img $PRODUCT/$IMAGE_NAME-$PLATFORM_BUILD.img
	# Move boot.img to out dir
	if [ ! -e $OUT ]; then
        mkdir $OUT
	fi
	mv $AIK/image-new.img $OUT/$IMAGE_NAME.img
	du -k "$OUT/$IMAGE_NAME.img" | cut -f1 >sizkT
	sizkT=$(head -n 1 sizkT)
	rm -rf sizkT
	echo " "
	$AIK/cleanup.sh
}

########################################################################
# Initialize Kernel Building                                           #
########################################################################

# IF mode is dirty, proceed, else, invoke clean build process.
if [[ "$MODE" == "dirty" ]]; then
    echo "WARNING: Kernel Build initialized in Dirty mode"
else
    build_clean
fi


# Make Defconfig
defconfig

# Make Kernel
build

if [[ "$TARGET_MAKE_BOOTIMG" == "true" ]]; then
# Creates boot.img which will appear in E9K-Tools/Product folder
PACK_BOOT_IMG
else
echo "WARNING: A BOOT.IMG WON'T BE CREATED"
fi

