# PROGENY_PROJECT_NAME

C++ Project template. Run progeny.sh script to create a new project from this template. If GitCLI is installed and your account is authenticated, you can add -g flag to automatically create a github repo and push the initial commit.

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

You will need to install [Example](http://example.org) for program_options and to use many of the libraries in [Leatherman](https://github.com/puppetlabs/leatherman).

```
[EXAMPLE]
git clone example
cd example && cmake ..
make -j128

```

Finally update the project() name in CMakeLists.txt.

## Build the library

This template is a fully functional example. Project and documentation can be built with

```
mkdir build && cd build
cmake ..
make -j24
```

CMake will generate source files from template files based on the project declared in CMakeLists.txt. For cpp-project-template, git ignores the generated files. For your own project, you can check those files in, and eventually remove the template files and generation logic from CMake as you develop your project (look for the REMOVE string in CMakeLists.txt files).

Tests can be run with `make test`, and the example tool can be run with `bin/cpp_project_template`.

## Maintenance

Maintainers: Crispy O'Baconhan

Tickets: Can be opened in Github Issues.