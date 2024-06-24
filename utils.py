import subprocess
from dataclasses import dataclass


@dataclass
class Colors:
    GREEN = "\033[92m"
    RED = "\033[91m"
    ENDC = "\033[0m"


@dataclass
class Ok:
    pass


@dataclass
class Err:
    message: str


Result = Ok | Err


def hostname() -> str:
    return subprocess.check_output(["uname", "-n"]).decode("utf-8").strip()
