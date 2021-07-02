# Recursively collect all header files from the current directory
file(GLOB_RECURSE HEADER_FILES *.h)

# Recursively collect all source files from the current directory
file(GLOB_RECURSE SOURCE_FILES *.cpp *.cxx)

# Building shared library, so `class_main.cpp` should be ignored in the list of source files
list(FILTER SOURCE_FILES EXCLUDE REGEX "class_main.cpp")

# Create the shared library using the collected source files
add_library(phreeqc4rkt SHARED ${HEADER_FILES} ${SOURCE_FILES})

# Include directories for proper compilation
target_include_directories(phreeqc4rkt
    PRIVATE ${PROJECT_SOURCE_DIR}/src
    PRIVATE ${PROJECT_SOURCE_DIR}/src/common
    PRIVATE ${PROJECT_SOURCE_DIR}/src/PhreeqcKeywords
    PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/phreeqc4rkt/common>
    PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/phreeqc4rkt/PhreeqcKeywords>)

# Add an alias phreeqc4rkt::phreeqc4rkt to the target library phreeqc4rkt
add_library(phreeqc4rkt::phreeqc4rkt ALIAS phreeqc4rkt)

# Replace the word Phreeqc by PHREEQC (to avoid conflict with the use of Phreeqc in Reaktoro - this is needed because phreeqc does not implement namespace!)
target_compile_definitions(phreeqc4rkt PRIVATE -DPhreeqc=PHREEQC)  # PRIVATE = only for this target and not propagated to dependent targets!

# Enable std::unique_ptr with Visual Studio 2019 (CXX17).
# add_compile_definitions($<$<CXX_COMPILER_ID:MSVC>:_HAS_AUTO_PTR_ETC=1>)
target_compile_definitions(phreeqc4rkt PRIVATE $<$<CXX_COMPILER_ID:MSVC>:_HAS_AUTO_PTR_ETC=1>)

# Install the target shared C++ library phreeqc4rkt
install(TARGETS phreeqc4rkt
    EXPORT phreeqc4rktTargets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT libraries
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT libraries
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT libraries)

# Install the header files preserving the directory hierarchy
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/phreeqc4rkt COMPONENT headers
    FILES_MATCHING PATTERN "*.h")
