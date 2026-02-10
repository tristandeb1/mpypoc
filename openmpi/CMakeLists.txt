cmake_minimum_required(VERSION 3.21)

project(mpypoc
    VERSION 0.1.0
    DESCRIPTION "Minimal C++ MPI program packaged for Python"
    LANGUAGES CXX)

if(NOT DEFINED SKBUILD)
    message(FATAL_ERROR "This proof-of-concept is intended to be configured only via the Python project!")
endif()

find_package(MPI REQUIRED COMPONENTS CXX)

add_executable(mpypoc src/mpypoc.cpp)
set_target_properties(mpypoc PROPERTIES POSITION_INDEPENDENT_CODE TRUE)
target_compile_features(mpypoc PRIVATE cxx_std_17)
target_link_libraries(mpypoc PRIVATE MPI::MPI_CXX)

if(MSVC)
    target_compile_options(mpypoc PRIVATE /W4 /permissive-)
else()
    target_compile_options(mpypoc PRIVATE -Wall -Wextra -Wpedantic)
endif()

set(_pkg_bin_dir "${SKBUILD_PROJECT_NAME}/bin")
set(_pkg_lib_dir "${SKBUILD_PROJECT_NAME}/lib")

install(TARGETS mpypoc RUNTIME DESTINATION ${_pkg_bin_dir})
