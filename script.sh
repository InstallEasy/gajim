#!/usr/bin/env bash

install_debian() {
  $SUDO apt update
  $SUDO apt dist-upgrade -y --auto-remove
  $SUDO apt install -y gajim gajim-omemo

}

install_ubuntu() {
  $SUDO apt update
  $SUDO apt dist-upgrade -y --auto-remove
  $SUDO apt install -y gajim gajim-omemo
}

install_fedora() {
  $SUDO dnf update -y
  $SUDO dnf -y install gajim
}

install_freebsd() {
  sudo pkg update -f
  sudo pkg install -y gajim
}

usage() {
  echo
  echo "Linux distribution not detected"
  echo "Use: ID=[ubuntu|debian|freebsd|fedora]"
  echo "Other distribution not yet supported"
  echo

}

if [ -f /etc/os-release ]; then
  . /etc/os-release
elif [ -f /etc/debian_version ]; then
  $ID=debian
elif uname -a | awk '{ print $1}' | grep FreeBSD; then
  install_freebsd
fi

if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

case $ID in
        'ubuntu')
                install_ubuntu
        ;;
        'debian')
                install_debian
        ;;
        'fedora')
                install_fedora
        ;;
        *)
          usage
        ;;
esac
