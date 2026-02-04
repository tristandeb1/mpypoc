"""Python interface for the C++ MPI binary."""

from ._runner import binary_path, run

__all__ = ["binary_path", "run"]
__version__ = "0.1.0"
