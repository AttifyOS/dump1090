#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${APM_TMP_DIR}" ]]; then
    echo "APM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_INSTALL_DIR}" ]]; then
    echo "APM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_BIN_DIR}" ]]; then
    echo "APM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/AttifyOS/dump1090/releases/download/vde61bd5/dump1090 -O $APM_TMP_DIR/dump1090
  mv $APM_TMP_DIR/dump1090 $APM_PKG_INSTALL_DIR
  chmod +x $APM_PKG_INSTALL_DIR/dump1090
  ln -s $APM_PKG_INSTALL_DIR/dump1090 $APM_PKG_BIN_DIR/dump1090
}

uninstall() {
  rm $APM_PKG_BIN_DIR/dump1090
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1