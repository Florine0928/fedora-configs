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
# Build Environment Variables                                          #
########################################################################

# Kernel Name
export IMAGE_NAME="E9K"

# Exynos9810 is ARM64 or less-know as aarch64
export ARCH=arm64

# aarch64 GCC Cross Compiler (Should be GCC 14 or later but U can try with GCC 4.9 too) 
export CROSS_COMPILE=aarch64-linux-gnu-

# Some Samsung Shenanigans
export ANDROID_MAJOR_VERSION=q

# Defconfigs
export star="exynos9810-starlte_defconfig"   # Samsung S9
export starshort="starlte"
export star2="exynos9810-star2lte_defconfig" # Samsung S9 Plus
export star2short="star2lte"
export crown="exynos9810-crownlte_defconfig" # Samsung Note9
export crownshort="crownlte"

# DTS Directory
export DTSD=arch/$ARCH/boot/dts/exynos

# Defaults (Device and Build Mode)
export DEVICE=$star # Starlte Aka S9
export MODE="dirty" # Dirty Build

# Main Directory
export DIR=$(pwd)

# Out Directory - Used for Buildsystem and such
export OUT=$DIR/E9K-Tools/Out

# Product Directory - Used for Buildsystem and such
export PRODUCT=$DIR/E9K-Tools/Product

# Presistant A.I.K Location
export AIK=$DIR/E9K-Tools/A.I.K

# Main Ramdisk Location
export RAMDISK=$DIR/E9K-Tools/Ramdisk

# Compiled image name and location (Image/zImage)
export KERNEL=$DIR/arch/$ARCH/boot/Image.gz

# Compiled DTB - Default Starlte
export CDTB="arch/arm64/boot/dts/exynos/exynos9810-starlte_eur_open_26.dtb"

# defconfig dir
export DEFCONFIG=$DIR/arch/$ARCH/configs

########################################################################
#                                                                      #
########################################################################

# ExremeXT lurks in this script
usage() {
    echo "Usage: $0 [-d <platform>] [-m <clean/dirty>]"
    echo "Example Usage: $0 -d S9 -m dirty"
    echo "Options:"
    echo "  -b          Build Kernel for S9,S9+,N9"
    echo "  -m          Build Mode (clean/dirty"
    echo "  -h          Display this help message"
    exit 1
}

# Parse options
while getopts "m:b:h" opt; do
    case $opt in
        b)
            arg=$OPTARG  # Capture the argument for -b
            if [[ -z "$arg" ]]; then
                echo "Error: No argument provided for -b."
                usage
            fi

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
        m)
            arg2=$OPTARG  # Capture the argument for -m
            if [[ -z "$arg2" ]]; then
                echo "Error: No argument provided for -m."
                usage
            fi

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
        *)
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

# Creates boot.img which will appear in E9K-Tools/Product folder
PACK_BOOT_IMG

