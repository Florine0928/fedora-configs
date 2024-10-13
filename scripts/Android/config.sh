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
export SUBARCH=arm64

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
export KERNEL=$DIR/arch/$ARCH/boot/Image

# Compiled DTB - Default Starlte
export CDTB="arch/arm64/boot/dts/exynos/exynos9810-starlte_eur_open_26.dtb"

# defconfig dir
export DEFCONFIG=$DIR/arch/$ARCH/configs

# Unset some vars for Make Boot.img
unset MAKEBOOT

########################################################################
#                                                                      #
########################################################################