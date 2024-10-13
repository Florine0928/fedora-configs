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

#############################################
# Source the variables from the config file #
source ./config.sh                          #
#############################################

# ExremeXT lurks in this script
usage() {
    echo "Usage: $0 [-d <platform>] [-m <clean/dirty>]"
    echo "Example Usage: $0 -d S9 -m dirty -e"
    echo "Options:"
    echo "  -b          Build Kernel for S9,S9+,N9"
    echo "  -m          Build Mode (clean/dirty"
    echo "  -e          Make boot.img"
    echo "  -h          Display this help message"
    exit 1
}

# Parse options
while getopts "em:b:h" opt; do
    case $opt in
        b)
            arg=$OPTARG  # Capture the argument for -b

            if [[ "$arg" == "S9" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$star
                export CDTB="arch/arm64/boot/dts/exynos/exynos9810-starlte_eur_open_26.dtb"
            elif [[ "$arg" == "S9+" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$star2
                export CDTB="arch/arm64/boot/dts/exynos/exynos9810-star2lte_eur_open_26.dtb"
            elif [[ "$arg" == "N9" ]]; then
                echo "Building kernel for: $arg"
                export DEVICE=$crown
                export CDTB="arch/arm64/boot/dts/exynos/exynos9810-crownlte_eur_open_26.dtb"
            else            
                echo "Invalid argument for -b: Defaulting to S9"
            fi
            ;;
        e)
                export MAKEBOOT="true"
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
            fi
            ;;
        h)
            # Print Help Option (ex: ./init.sh -h)
            usage
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
    if [[ "$MODE" == "dirty" ]]; then
    #If in dirty mode then make kernel while not cleaning workdir 
    make -j$(nproc)
    else
    # If not in dirty mode then clear workdir and make kernel
    make clean && make mrproper
    make -j$(nproc)
    fi
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
	mv $CDTB $AIK/split_img/boot.img-dtb
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
	cp $AIK/image-new.img $PRODUCT/$IMAGE_NAME.img
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

# Make Defconfig
defconfig

# Make Kernel
build

if [[ "$MAKEBOOT" == "true" ]]; then
# Creates boot.img which will appear in E9K-Tools/Product folder
PACK_BOOT_IMG
else
echo "boot.img won't be made"
fi

