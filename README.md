
<h1 style="font-size: 24;" align="center"> PROGENY_PROJECT_NAME </h1>

<p align="center"> <img src="https://upload.wikimedia.org/wikipedia/commons/8/80/DNA_icon.svg" alt="dna_icon.svg" width="100"/></p>

<h1 style="font-size: 24;" align="center"> 

![build badge](https://github.com/buster-jangle/PROGENY/actions/workflows/cmake_build_ubuntu-latest.yml/badge.svg?branch=release) 
![build badge](https://github.com/buster-jangle/PROGENY/actions/workflows/cmake_tests_ubuntu-latest.yml/badge.svg?branch=release)
![build badge](https://github.com/buster-jangle/PROGENY/actions/workflows/cmake-doxygen-deploy-gh-pages.yaml/badge.svg?branch=release)</p>
</h1>
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


## Dependencies
* CMake >=3.0.0 is required. Ninja-build and Doxygen are optional but strongly recommended.


* [PLOG](https://github.com/SergiusTheBest/plog) and [CLI11](https://github.com/CLIUtils/CLI11) are required, but will be cloned automatically as git submodules when project is built. [Doxygen](https://github.com/doxygen/doxygen) is recommended, but not required.


## Using PROGENY

* Click "Use this template" to create your new repo, and give it a name. 
* Clone the repo to a local directory
* Run `progeny.sh` to initialize the new project. This will automatically perform the following:
  * Replace all occurences of "PROGENY_PROJECT_NAME" with your new project name.
  * Add a creation date to template files with the current date
  * Reset the git repo
  * delete `progeny.sh`
* Your project your now be able tobuild and run tests.
  
## Building PROGENY

Building PROGENY also builds documentation with Doxygen (if it is installed). You can run `compile.sh` to automatically build the project, or manually build with the following commands:
```
mkdir build
cd build
cmake ..
make -j24
make test #Optional run unit tests defined in CMake
```

If you have `ninja-build` installed, you can compile with ninja instead of make, which is substantially more efficient. ninja-build uses all available cores by default, so you need not specify -j.

```
mkdir build
cd build
cmake .. -GNinja
ninja
```

## Install (local)

By default, the PROGENY template installs primary executables (using `make install`)and libraries in /usr/local/(lib/include). Install destinations are defined in a variable in the top level CMakeLists.txt so it can be easily changed.

## Release packages

PROGENY's top-level CmakeLists.txt includes a basic example of using CPack to generate release packages. Release packages inherit their version number from the PROGENY_PROJECT_NAME_VERSION variables.

* Generate a compressed sourcecode package: `make package_source` or `ninja package_source`


* Generate a .deb install package: `make package` or `ninja package` (install with `sudo apt install ./name-of-your-package.deb`

## Documentation

Documentation is automatically generated by Doxygen, compiled via github actions, and deployed to github pages. Make sure when you copy this template, you also copy the `gh-pages` branch, which is where the documentation is deployed. Replace

Functional example API reference: https://buster-jangle.github.io/PROGENY/

Template API reference as a hyperlink (replace "buster-jangle" with your username){Note: Bold hyperlinks are broken in Doxygen}: 

[PROGENY_PROJECT_NAME API Reference](https://buster-jangle.github.io/PROGENY_PROJECT_NAME/)

## License

An open-source MIT License `License.txt` file is included by default. Update with your name, or replace with a boilerplate license of your choosing. Otherwise, all your projects using this template will be opensource, and licensed to me.

## Maintenance

* Maintainers: Sean O'Callaghan
* Tickets: Can be opened in Github Issues.
* Also heres how to put a GIF in a README.md, in case you wanted to know ;)

<div style="text-align: center;">

![Alt Text](https://upload.wikimedia.org/wikipedia/commons/7/79/Perfect-loop-cube.gif)

</div>