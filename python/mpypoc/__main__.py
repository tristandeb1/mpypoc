from __future__ import annotations

import argparse

from . import run

def cli(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Runs the C++ MPI program packaged in this distribution."
    )
    parser.add_argument(
        "-n",
        "--num-procs",
        type=int,
        default=2,
        help="Number of MPI process (default: 2)"
    )
    parser.add_argument(
        "--mpiexec",
        default=None,
        help="mpiexec/mpirun command to use (default: auto)"
    )
    parser.add_argument(
        "--mpi-args",
        nargs="*",
        help="Additional arguments passed to mpiexec"
    )
    parser.add_argument(
        "--app-args",
        nargs="*",
        help="Additional arguments passed to the C++ program"
    )

    args = parser.parse_args(argv)

    run(
        num_procs=args.num_procs,
        mpiexec=args.mpiexec,
        extra_mpi_args=args.mpi_args,
        extra_program_args=args.app_args,
    )
    return 0

if __name__ == "__main__":
    raise SystemExit(cli())
