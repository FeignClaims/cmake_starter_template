from conan import ConanFile
from conan.tools.cmake import cmake_layout, CMakeToolchain, CMakeDeps


class starterRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"

    def requirements(self):
        self.requires("fmt/[>=9.1.0]")
        self.requires("ms-gsl/[>=4.0.0]")
        self.requires("range-v3/[>=0.12.0]")

    def build_requirements(self):
        self.tool_requires("cmake/[>=3.25]")
        self.test_requires("gtest/[>=1.13.0]")

    def layout(self):
        # By default, distinguish configuraiotns by compiler name
        # This can be changed by setting `tools.cmake.cmake_layout:build_folder_vars` in command-line or profiles
        self.folders.build_folder_vars = ["settings.compiler"]
        cmake_layout(self)

    def generate(self):
        CMakeDeps(self).generate()
        toolchain = CMakeToolchain(self)
        toolchain.presets_prefix = ""
        toolchain.generate()
