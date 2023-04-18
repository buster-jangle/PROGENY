#!/bin/bash
#cd "$(dirname "$0")"

cd build || exit
cmake .. || exit
make -j24 || exit
cd ..

echo "Running program"

gnome-terminal -- bash -c "echo STARTING EXECUTION; ./application/bin/PROGENY; echo ENDED EXECUTION; exec bash"

echo "Stopped program"

