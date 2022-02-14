#!/bin/bash
# -B forces build
# build: lib$1$2.so
if [ ""$#"" -ne 2 ]; then
    echo "\$1.cpp built with backend \$2 - ... xaf cpu"
    exit 2
fi
make target=$1 backend=$2 -B -f dllmakefile
