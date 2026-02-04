cmake_minimum_required(VERSION 3.21)

project(mpypoc
    VERSION 0.1.0
    DESCRIPTION "Minimal C++ MPI program packaged for Python"
    LANGUAGES CXX)

include(GNUInstallDirs)

if(NOT DEFINED SKBUILD_PROJECT_NAME)
    set(SKBUILD_PROJECT_NAME "${PROJECT_NAME}")
endif()

if(DEFINED SKBUILD)
    set(_pkg_bin_dir "${SKBUILD_PROJECT_NAME}/bin")
    set(_pkg_lib_dir "${SKBUILD_PROJECT_NAME}/lib")
else()
    set(_pkg_bin_dir "${CMAKE_INSTALL_BINDIR}")
    set(_pkg_lib_dir "${CMAKE_INSTALL_LIBDIR}")
endif()

find_package(MPI REQUIRED COMPONENTS CXX)

add_executable(mpypoc src/mpypoc.cpp)
target_compile_features(mpypoc PRIVATE cxx_std_17)
target_link_libraries(mpypoc PRIVATE MPI::MPI_CXX)

if(MSVC)
    target_compile_options(mpypoc PRIVATE /W4 /permissive-)
else()
    target_compile_options(mpypoc PRIVATE -Wall -Wextra -Wpedantic)
endif()

install(TARGETS mpypoc
        RUNTIME DESTINATION ${_pkg_bin_dir}
        LIBRARY DESTINATION ${_pkg_lib_dir}
        ARCHIVE DESTINATION ${_pkg_lib_dir})
