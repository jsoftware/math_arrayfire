#!/bin/sh
# ./build.sh xaf cpu   - builds libxafcpu.so
make target=$1 backend=$2 -B -f makefile_linux
