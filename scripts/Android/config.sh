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

# Platform
export PLATFORM_BUILD="Exynos9810"
export PLATFORM_ARCH="exynos"

###########################################################################################################################
# Toolchains
export TC_A="evagccc"
export TC_AB="aarch64-elf-" # Toolchain GCC Binary
export TC_AD="$TC_DIR/GCC/EVAGCC/"
###########################################################################################################################
export TC_B="gcc" # comes with every distro in existance..
export TC_BB="aarch64-linux-gnu-" # Toolchain GCC Binary
# feel free to add more Toolchains at will, considering your kernel supports it. However, Clang needs more work to get done.
###########################################################################################################################

# Toolchain Placeholder
export TC="aarch64-linux-gnu-"

# Toolchain Directory
export TC_DIR="Toolchain"

# Exynos9810 (ORRRR whatever the fuck is the SoC the end-user is building for..) is ARM64 or less-know as aarch64
export ARCH=arm64
export SUBARCH=arm64

# aarch64 GCC Cross Compiler (Should be GCC 14 or later but U can try with GCC 4.9 too) 
# Some compilers such as EvaGCC mentioned in Toolchain list have different GCC Binary name, for example EvaGCC is "aarch64-elf-"
export CROSS_COMPILE=$TC

# Some Samsung Shenanigans
export ANDROID_MAJOR_VERSION=q

# Defconfigs / Codenames / DTBs
export DEV_A="exynos9810-starlte_defconfig"   # Samsung S9
export DEV_AD="arch/$ARCH/boot/dts/$PLATFORM_ARCH/exynos9810-starlte_eur_open_26.dtb"
export DEV_AC="starlte"

export DEV_B="exynos9810-star2lte_defconfig" # Samsung S9 Plus
export DEV_BD="arch/$ARCH/boot/dts/$PLATFORM_ARCH/exynos9810-star2lte_eur_open_26.dtb"
export DEV_BC="star2lte"

export DEV_C="exynos9810-crownlte_defconfig" # Samsung Note9
export DEV_CD="arch/$ARCH/boot/dts/$PLATFORM_ARCH/exynos9810-crownlte_eur_open_26.dtb"
export DEV_CC="crownlte"
# format is in DEV_A, DEV_B... 
# DEV_A plus a C means codename of the device
# DEV_A plus a D means compiled dtb, so replace the dtb name with your device dts but end the file with .dtb instead of .dts or .dtsi

# DTS Directory
export DEV_DTS=arch/$ARCH/boot/dts/$PLATFORM_ARCH # exynos,qcom,mtk whatever you want..

# Defaults (Device and Build Mode)
export DEVICE=$DEV_A # Starlte Aka S9
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

# Compiled DTB - Default to DEVICE A
export DEV_DTB="arch/$ARCH/boot/dts/$PLATFORM_ARCH/$DEV_AD"

# defconfig dir
export DEFCONFIG=$DIR/arch/$ARCH/configs

# Unset some vars for Make Boot.img
unset TARGET_MAKE_BOOTIMG

########################################################################
#                                                                      #
########################################################################