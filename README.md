# PROGENY_PROJECT_NAME
![build badge](https://github.com/buster-jangle/PROGENY/actions/workflows/cmake_build_ubuntu-latest.yml/badge.svg?branch=master)
![build badge](https://github.com/buster-jangle/PROGENY/actions/workflows/cmake_tests_ubuntu-latest.yml/badge.svg?branch=master)

PROGENY is a template for C++ projects, plus a script to automatically generate new projects with a given name and set up a GitHub repo. PROGENY is intended to demonstrate & encourage modern C++ development practices using CMake, Git, GitHub, and Doxygen. PROGENY is also a fully functional C++ project on its own (Primary executables just return "Hello world", test executables always pass, and the template library has one class with example functions to demonstrate Doxygen usage.)

Template includes the following:
* Default library
* Default executable
* Default test
* Default .gitignore tailored for C++ development in CLion
* Default git submodules (PLOG & CLI11) to promote standardized logging and CLI interface
* Default install locations defined in top-level CMakeLists.txt
* Documentation generation via doxygen
* CMake script automatically pulls git submodules, and when compiled as release, builds Doxygen documentation.


## Required packages

[PLOG](https://github.com/SergiusTheBest/plog) and [CLI11](https://github.com/CLIUtils/CLI11) are required, but will be cloned automatically as git submodules when CMake is run. [Doxygen](https://github.com/doxygen/doxygen) is recommended, but not required.


## Using PROGENY

Navigate to the directory where you want to create the project, then run `{PROGENY_ROOT}/progeny.sh {PROJECT_NAME} -g` where {PROGENY_ROOT} is the location where progeny is cloned to, and {PROJECT_NAME} is the name given to the new project. `-g` is an otional flag which, assuming Github CLI is installed and authenticated via SSH, will also create a GitHub repo for the project with your account, and create an initial commit.


## Building PROGENY

Building PROGENY also builds documentation with Doxygen (if it is installed). You can run `compile.sh` to automatically build the project, or manually build with the following commands:
```
mkdir build
cd build
cmake ..
make -j24
```
After build, Tests can be run with `make test`.


## Install

By default, the PROGENY templat installs primary executables and libraries in /usr/local/(lib/include). Install destinations are defined in a variable in the top level CMakeLists.txt so it can be easily changed.


## Maintenance

Maintainers: Sean O'Callaghan

Tickets: Can be opened in Github Issues.

Also heres how to put a GIF in a README.md, in case you wanted to know ;)
![Alt Text](https://upload.wikimedia.org/wikipedia/commons/7/79/Perfect-loop-cube.gif)
