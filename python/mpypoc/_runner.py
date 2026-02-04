from __future__ import annotations

import os
import subprocess
from pathlib import Path
from typing import Optional, Sequence

try:
    from importlib.resources import files
except ImportError:  # Python < 3.9
    from importlib_resources import files


def binary_path() -> Path:
    package_root = files(__package__)
    bin_dir = package_root / "bin"
    executable = "mpypoc.exe" if os.name == "nt" else "mpypoc"
    binary = bin_dir / executable
    if not binary.exists():
        raise FileNotFoundError(
            f"Could not find installed MPI binary: {binary}"
        )
    return Path(binary)


def run(
    num_procs: int = 2,
    *,
    mpiexec: Optional[str] = None,
    extra_mpi_args: Optional[Sequence[str]] = None,
    extra_program_args: Optional[Sequence[str]] = None,
    check: bool = True,
) -> subprocess.CompletedProcess[str]:
    if num_procs < 1:
        raise ValueError("num_procs must be >= 1")
    
    launcher = mpiexec or os.environ.get("MPIEXEC", "mpiexec")
    cmd = [launcher, "-n", str(num_procs)]

    if extra_mpi_args:
        cmd.extend(extra_mpi_args)

    cmd.append(str(binary_path()))

    if extra_program_args:
        cmd.extend(extra_program_args)

    return subprocess.run(cmd, check=check)
