#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# This script swaps the default fedora kernel for the suface kernel, using instructions from the
# linux-surface installation instructions

cd /tmp
mkdir surface-linux
cd surface-linux

# Download dummy kernel
wget https://github.com/linux-surface/linux-surface/releases/download/silverblue-20201215-1/kernel-20201215-1.x86_64.rpm

# Run kernel replacement
rpm-ostree override replace ./*.rpm \
           --remove kernel-core \
           --remove kernel-devel-matched \
           --remove kernel-modules \
           --remove kernel-modules-extra \
           --install kernel-surface \
           --install iptsd

#sudo rpm-ostree install kernel-surface iptsd
#sudo rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-extra kernel-devel kernel-devel-matched

# Install secure boot key
rpm-ostree install surface-secureboot
