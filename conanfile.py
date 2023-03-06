from conan import ConanFile
from conan.tools.cmake import cmake_layout, CMakeToolchain, CMakeDeps, CMake


class starterRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"

    def layout(self):
        self.folders.build_folder_vars = ["settings.compiler"]
        cmake_layout(self)

    def generate(self):
        CMakeDeps(self).generate()
        toolchain = CMakeToolchain(self)
        toolchain.presets_prefix = ""
        toolchain.generate()

    def requirements(self):
        self.requires("fmt/[>=9.1.0]")
        self.requires("gtest/[>=1.13.0]")
        self.requires("ms-gsl/[>=4.0.0]")
        self.requires("range-v3/[>=0.12.0]")
