# The path where cmake config files are installed
set(PHREEQC4RKT_INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/phreeqc4rkt)

install(EXPORT phreeqc4rktTargets
    FILE phreeqc4rktTargets.cmake
    NAMESPACE phreeqc4rkt::
    DESTINATION ${PHREEQC4RKT_INSTALL_CONFIGDIR}
    COMPONENT cmake)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/phreeqc4rktConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/phreeqc4rktConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/phreeqc4rktConfig.cmake
    INSTALL_DESTINATION ${PHREEQC4RKT_INSTALL_CONFIGDIR}
    PATH_VARS PHREEQC4RKT_INSTALL_CONFIGDIR)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/phreeqc4rktConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/phreeqc4rktConfigVersion.cmake
    DESTINATION ${PHREEQC4RKT_INSTALL_CONFIGDIR})
