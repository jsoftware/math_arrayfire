#!/bin/bash
# -B forces build
# build: lib$1$2.so
make target=$1 backend=$2 -B -f dllmakefile
