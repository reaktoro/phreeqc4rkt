# Require a certain version of cmake
cmake_minimum_required(VERSION 3.0)

# Set the cmake module path of the project
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Use ccache to speed up repeated compilations
include(CCache)

# Set the name of the project
project(phreeqc4rkt VERSION 3.6.2.1 LANGUAGES CXX)

# Replace the word Phreeqc by PHREEQC
add_definitions(-DPhreeqc=PHREEQC)

# Enable std::unique_ptr with Visual Studio 2019 (CXX17).
add_compile_definitions($<$<CXX_COMPILER_ID:MSVC>:_HAS_AUTO_PTR_ETC=1>)

# Recursively collect all header files from the current directory
file(GLOB_RECURSE HEADER_FILES *.h)

# Recursively collect all source files from the current directory
file(GLOB_RECURSE SOURCE_FILES *.cpp *.cxx)

# Building shared library, so `class_main.cpp` should be ignored in the list of source files
list(FILTER SOURCE_FILES EXCLUDE REGEX "class_main.cpp")

# Include directories for proper compilation
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/common)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/PhreeqcKeywords)

# Create the shared library using the collected source files
add_library(phreeqc4rkt SHARED ${HEADER_FILES} ${SOURCE_FILES})

# Install the target shared C++ library phreeqc4rkt
install(TARGETS phreeqc4rkt
    EXPORT phreeqc4rktTargets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT libraries
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT libraries
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT libraries)

# Install the header files preserving the directory hierarchy
install(FILES ${HEADER_FILES} DESTINATION include/phreeqc4rkt)

# Install the cmake config files that permit users to use find_package(phreeqc4rkt)
include(phreeqc4rktInstallCMakeConfigFiles)
