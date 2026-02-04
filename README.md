mpypoc
======

This repository aims at experimenting with a C++ project depending on MPI, using CMake as a build tool and offering a Python package to distribute the C++ code and the binaries.
*mpypoc* stands for "MPI-Python proof-of-concept", where "MPI" is spelled "mpy" to refer to Python.


Getting Started
---------------

~~~ bash
cmake -S . -B build -DMPI_CXX_COMPILER=mpicxx
cmake --build build
cmake --install build --prefix install
mpiexec -n 4 install/bin/mpypoc
~~~

