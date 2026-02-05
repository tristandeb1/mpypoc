set(_openmpi_version "${OPENMPI_VERSION}")
string(REGEX REPLACE "([0-9]+\.[0-9]+)\.[0-9]+" "\\1" _openmpi_short_version ${_openmpi_version})
set(_openmpi_dirname "openmpi-${_openmpi_version}")
set(_openmpi_archive_filename "${_openmpi_dirname}.tar.bz2")

set(_openmpi_prefix "/opt/openmpi")
set(_openmpi_build_dir "/tmp/openmpi-build")
set(_openmpi_archive "${_openmpi_build_dir}/${_openmpi_archive_filename}")
set(_openmpi_final_build_dir "${_openmpi_build_dir}/${_openmpi_dirname}")

file(MAKE_DIRECTORY "${_openmpi_build_dir}")
file(DOWNLOAD "https://download.open-mpi.org/release/open-mpi/v${_openmpi_short_version}/${_openmpi_archive_filename}" "${_openmpi_archive}")
file(ARCHIVE_EXTRACT INPUT "${_openmpi_archive}" DESTINATION "${_openmpi_build_dir}")

execute_process(COMMAND "./configure" "--prefix=${_openmpi_prefix}" WORKING_DIRECTORY "${_openmpi_final_build_dir}")
execute_process(COMMAND "nproc" OUTPUT_VARIABLE _number_of_processors OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND "make" "-j${_number_of_processors}" WORKING_DIRECTORY "${_openmpi_final_build_dir}")
execute_process(COMMAND "make" "install" WORKING_DIRECTORY "${_openmpi_final_build_dir}")

file(APPEND "/etc/ld.so.conf.d/openmpi.conf" "${_openmpi_prefix}/lib")
file(APPEND "/etc/ld.so.conf.d/openmpi.conf" "${_openmpi_prefix}/lib/openmpi")
file(APPEND "/etc/ld.so.conf.d/openmpi.conf" "${_openmpi_prefix}/lib/openmpi/libfabric")
file(APPEND "/etc/ld.so.conf.d/openmpi.conf" "${_openmpi_prefix}/lib/openmpi/ucx")
execute_process(COMMAND "ldconfig")

set(ENV{PATH} "${_openmpi_prefix/bin}:$ENV{PATH}")
list(APPEND CMAKE_PREFIX_PATH "${_openmpi_prefix}")

set(MPI_C_COMPILER "${_openmpi_prefix}/bin/mpicc")
set(MPI_CXX_COMPILER "${_openmpi_prefix}/bin/mpicxx")
set(MPI_EXEC_EXECUTABLE "${_openmpi_prefix}/bin/mpiexec")
set(OPENMPI_PREFIX "${_openmpi_prefix}")
