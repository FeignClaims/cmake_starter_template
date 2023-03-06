# cmake_starter_template

Not Documented Well Yet!

## About cmake_starter_template

This is a template for getting up and running with C++ quickly.

It requires

- ccache
- clang 15+
- cmake 3.25+
- conan 2.0+
- cppcheck
- doxygen
- include-what-you-use (IWYU)

For Chinese, you can learn how to install all these with VSCode on Windows/MacOS [here](https://windowsmacos-vscode-c-llvm-clang-clangd-lldb.readthedocs.io/).

## Getting Started

### Use the Github template

First, click the green `Use this template` button near the top of this page.
This will take you to Github's ['Generate Repository'](https://github.com/FeignClaims/cmake_starter_template/generate) page.
Fill in a repository name and short description, and click 'Create repository from template'.
This will allow you to create a new repository in your Github account,
prepopulated with the contents of this project.

After creating the project please wait until the cleanup workflow has finished
setting up your project and commited the changes.

Now you can clone the project locally and get to work!

```bash
git clone https://github.com/<user>/<your_new_repo>.git
```

### Configure the project

#### Install conan dependencies

To install conan dependencies:

```bash
conan install . -b missing
```

Additionally, you can add `-s build_type=[Release|Debug|MinSizeRel|RelWithDebInfo]` to set the build type:

```bash
conan install . -b missing -s build_type=Release
```

After this, conan will generate `CMakeUserPresets.json` for cmake.

#### Configure

List all available configure presets:

```bash
cmake --list-presets
```

Choose one to configure (preset `clang` for instance):

```bash
cmake --preset clang
```

#### Build

List all available build presets:

```bash
cmake --build --list-presets
```

Choose one to build (preset `clang-debug` for instance):

```bash
cmake --build --preset clang-debug
```

### Switch to developer mode

By default, cmake configures the project on user mode. For developers, you can switch to developer mode by:

#### Use `-DENABLE_DEVELOPER_MODE:BOOL=ON`

```bash
cmake --preset clang -DENABLE_DEVELOPER_MODE:BOOL=ON
```

#### Use `ccmake` after first configuration

```bash
cmake --preset clang
ccmake --preset clang
```

#### Use `cmake-gui`

## More Details

The repository is templated from [cpp-best-practices/gui_starter_template](https://github.com/cpp-best-practices/gui_starter_template). You can learn more there.

For conan 2.0, [here](https://docs.conan.io/2.0/index.html) is the official documentation.
