#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

# echo "Dry: ${_DRY}"
# echo "Is Dry: ${_IS_DRY}"

execute sudo pacman -Sy --needed \
    minikube \
    libvirt \
    qemu-desktop \
    dnsmasq \
    iptables-nft \
    kubectl \
    kubectx

execute sudo usermod -aG libvirt ${USER}
execute sudo systemctl enable libvirtd
execute sudo systemctl start libvirtd

execute minikube config set driver kvm2
