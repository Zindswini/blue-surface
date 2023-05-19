#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# This script swaps the default fedora kernel for the suface kernel, using instructions from the
# linux-surface installation instructions

# Download dummy kernel
wget https://github.com/linux-surface/linux-surface/releases/download/silverblue-20201215-1/kernel-20201215-1.x86_64.rpm

# Run kernel replacement
rpm-ostree override replace ./*.rpm \
	--remove kernel-core \
	--remove kernel-modules \
	--remove kernel-modules-extra \
        --remove libwacom \
        --remove libwacom-data \
	--install kernel-surface \
	--install iptsd \
        --install libwacom-surface \
        --install libwacom-surface-data

# Install secure boot key
rpm-ostree install surface-secureboot
