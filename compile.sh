#!/bin/bash
#cd "$(dirname "$0")"
mkdir build
cd build || exit
cmake .. || exit
make -j24 || exit
cd ..

