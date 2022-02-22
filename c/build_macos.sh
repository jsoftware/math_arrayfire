#!/bin/sh
# ./build_macos.sh xaf cpu   - builds libxafcpu.dylib
make target=$1 backend=$2 -B -f makefile_macos
