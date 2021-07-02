# Require a certain version of cmake
cmake_minimum_required(VERSION 3.0)

# Set the cmake module path of the project
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Use ccache to speed up repeated compilations
include(CCache)

# Include the cmake variables with values for installation directories
include(GNUInstallDirs)

# Set the name of the project
project(phreeqc4rkt VERSION 3.6.2.1 LANGUAGES CXX)

# Consider the following subdirectories for the build task
add_subdirectory(src)
add_subdirectory(tests)

# Install the cmake config files that permit users to use find_package(phreeqc4rkt)
include(phreeqc4rktInstallCMakeConfigFiles)
