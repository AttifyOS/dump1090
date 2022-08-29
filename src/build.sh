#!/bin/sh

set -e
apk update
apk add alpine-sdk librtlsdr-dev libusb-dev
git clone https://github.com/antirez/dump1090
cd dump1090
make LDFLAGS=-static
