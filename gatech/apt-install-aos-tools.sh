#!/bin/bash
set -ue

apt update
apt install -y \
    qemu-kvm \
    libvirt-bin \
    libvirt-dev \
    uvtool \
    virt-top \
    virt-manager
