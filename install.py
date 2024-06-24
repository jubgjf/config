import argparse
import json
import logging
import os
from pathlib import Path
from typing import Dict, List, Optional

from utils import Colors, Err, Ok, Result, hostname

HOME: Path
CONFIG_HOME: Path
XDG_CONFIG_HOME: Path


def is_activated(cfg_map: Dict[str, str]) -> Result:
    cfg_src = Path(cfg_map["src"].format(HOME=HOME, CONFIG_HOME=CONFIG_HOME, XDG_CONFIG_HOME=XDG_CONFIG_HOME))
    cfg_tgt = Path(cfg_map["tgt"].format(HOME=HOME, CONFIG_HOME=CONFIG_HOME, XDG_CONFIG_HOME=XDG_CONFIG_HOME))

    if cfg_tgt.exists() and cfg_tgt.is_symlink() and cfg_tgt.resolve() == cfg_src:
        # Maybe ok, but need to further check host-specific configuration
        pass
    elif not cfg_tgt.exists():
        return Err(f"Symlink not found: {cfg_tgt}")
    elif not cfg_tgt.is_symlink():
        return Err(f"Not a symlink: {cfg_tgt}")
    elif cfg_tgt.resolve() != cfg_src:
        return Err(f"Symlink target mismatch: {cfg_tgt} -> {cfg_tgt.resolve()} != {cfg_src}")
    else:
        return Err("Unknown error")

    cfg_host_specific: Optional[Dict[str, Dict[str, str]]] = cfg_map.get("host-specific", None)

    # No host-specific configuration, pass
    if cfg_host_specific is None:
        return Ok()

    # Check host-specific configuration
    current_hostname = hostname()
    selected_hostname = None
    for key in cfg_host_specific.keys():
        if key == current_hostname:
            selected_hostname = key
            break
    if selected_hostname is None and "OTHERS" in cfg_host_specific.keys():
        selected_hostname = "OTHERS"
    cfg_src_host = cfg_src / cfg_host_specific[selected_hostname]["src"]
    cfg_tgt_host = cfg_src / cfg_host_specific[selected_hostname]["tgt"]
    if cfg_tgt_host.exists() and cfg_tgt_host.is_symlink() and cfg_tgt_host.resolve() == cfg_src_host:
        return Ok()
    else:
        return Err(f"Host-specific configuration error: {cfg_tgt_host}")


def activate(name: str, cfg_map: Dict[str, str]) -> Result:
    if isinstance(is_activated(cfg_map), Ok):
        return Ok()

    cfg_src = Path(cfg_map["src"].format(HOME=HOME, CONFIG_HOME=CONFIG_HOME, XDG_CONFIG_HOME=XDG_CONFIG_HOME))
    cfg_tgt = Path(cfg_map["tgt"].format(HOME=HOME, CONFIG_HOME=CONFIG_HOME, XDG_CONFIG_HOME=XDG_CONFIG_HOME))
    cfg_host_specific: Optional[Dict[str, Dict[str, str]]] = cfg_map.get("host-specific", None)

    cfg_tgt.parent.mkdir(parents=True, exist_ok=True)
    if not cfg_tgt.exists():
        cfg_tgt.symlink_to(cfg_src)
        logging.debug(f"Created symlink for {name}: {cfg_tgt} -> {cfg_src}")

    logging.debug(f"Host-specific configuration for {name}: {cfg_host_specific}")
    if cfg_host_specific is not None:
        current_hostname = hostname()
        selected_hostname = None
        logging.debug(f"Current hostname: {current_hostname}")

        for key in cfg_host_specific.keys():
            if key == current_hostname:
                selected_hostname = key
                break
        if selected_hostname is None and "OTHERS" in cfg_host_specific.keys():
            selected_hostname = "OTHERS"

        if selected_hostname is not None:
            logging.debug(f"Selected hostname: {selected_hostname}")

            cfg_src_host = cfg_src / cfg_host_specific[selected_hostname]["src"]
            cfg_tgt_host = cfg_src / cfg_host_specific[selected_hostname]["tgt"]
            cfg_tgt_host.symlink_to(cfg_src_host)
            logging.debug(f"Created symlink for {name} (host specific for {selected_hostname}): {cfg_tgt} -> {cfg_src}")
        else:
            logging.debug(f"No host-specific configuration found for {name}, skip")

    return is_activated(cfg_map)


def deactivate(name: str, cfg_map: Dict[str, str]) -> Result:
    if isinstance(is_activated(cfg_map), Err):
        return Ok()

    cfg_tgt = Path(cfg_map["tgt"].format(HOME=HOME, CONFIG_HOME=CONFIG_HOME, XDG_CONFIG_HOME=XDG_CONFIG_HOME))
    cfg_tgt.unlink()
    logging.debug(f"Unlink {cfg_tgt} for {name}")

    if isinstance(is_activated(cfg_map), Ok):
        return Err(f"Failed to deactivate {name}")
    return Ok()


def get_status(configuration: Dict[str, List[Dict[str, str]]]) -> Dict[str, Result]:
    return {name: is_activated(maps) for name, maps in configuration.items()}


def show_status(
    configuration: Dict[str, List[Dict[str, str]]],
    show_diff: bool = False,
    old_status: Optional[Dict[str, Result]] = None,
    new_status: Optional[Dict[str, Result]] = None,
):
    max_word_length = max([len(d) for d in configuration.keys()])
    border_length = 4 + max_word_length + 2
    status_table = ""
    status_table += "╔" + "═" * border_length + "╗" + "\n"
    for name, maps in configuration.items():
        if not show_diff:
            result = is_activated(maps)
            if isinstance(result, Ok):
                logging.debug(f"{name} activated")
                mark = "✓"
            else:
                logging.debug(f"{name} not activated, reason = {result.message}")
                mark = " "
            whitespaces = " " * (border_length - 5 - len(name))
            status_table += f"║ {mark} {name} {whitespaces} ║" + "\n"
        else:
            old_result = old_status[name]
            new_result = new_status[name]
            if isinstance(old_result, Ok) and isinstance(new_result, Ok):
                logging.debug(f"{name} activated before and after")
                mark = "✓"
                color = ""
            elif isinstance(old_result, Ok) and isinstance(new_result, Err):
                logging.debug(f"{name} activated before, but now deactivated, reason = {new_result.message}")
                mark = "-"
                color = Colors.RED
            elif isinstance(old_result, Err) and isinstance(new_result, Ok):
                logging.debug(f"{name} deactivated before, but now activated")
                mark = "+"
                color = Colors.GREEN
            else:
                logging.debug(f"{name} deactivated before and after")
                mark = " "
                color = ""
            whitespaces = " " * (border_length - 5 - len(name))
            status_table += f"║ {color}{mark} {name} {whitespaces}{Colors.ENDC} ║" + "\n"
    status_table += "╚" + "═" * border_length + "╝" + "\n"

    print(status_table)


if __name__ == "__main__":
    # Basic setup
    HOME = os.getenv("HOME")
    assert HOME is not None
    HOME = Path(HOME)
    CONFIG_HOME = Path(os.getenv("CONFIG_HOME", HOME / "code/config"))
    XDG_CONFIG_HOME = Path(os.getenv("XDG_CONFIG_HOME", HOME / ".config"))

    # Load configuration
    assert (CONFIG_HOME / "config.json").exists(), f"Configuration file not found: {CONFIG_HOME / 'config.json'}"
    with open(CONFIG_HOME / "config.json") as f:
        configuration = json.load(f)

    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("--activate", nargs="+", type=str, choices=configuration.keys())
    parser.add_argument("--deactivate", nargs="+", type=str, choices=configuration.keys())
    parser.add_argument("--status", action="store_true")
    parser.add_argument("--verbose", action="store_true")
    args = parser.parse_args()

    # Logging
    if args.verbose:
        logging.basicConfig(level=logging.DEBUG)

    logging.debug("Configuration:")
    for name, maps in configuration.items():
        logging.debug(f"{name} -> {maps}")
    logging.debug("Configuration loaded successfully")

    # Show status
    if args.status:
        assert (
            args.activate is None and args.deactivate is None
        ), "Cannot specify --status with --activate or --deactivate"
        show_status(configuration)
        exit(0)

    # Sanity check
    activate_targets: list = args.activate if args.activate is not None else []
    deactivate_targets: list = args.deactivate if args.deactivate is not None else []
    assert set(activate_targets).intersection(set(deactivate_targets)) == set()

    # Activate or deactivate, and show status diff
    old_status = get_status(configuration)
    logging.debug(f"Old status: {old_status}")
    for name in activate_targets:
        if activate(name, configuration[name]):
            print(f"Activated {name}")
        else:
            print(f"Failed to activate {name}")
    for name in deactivate_targets:
        if deactivate(name, configuration[name]):
            print(f"Deactivated {name}")
        else:
            print(f"Failed to deactivate {name}")
    new_status = get_status(configuration)
    logging.debug(f"New status: {new_status}")
    show_status(configuration, show_diff=True, old_status=old_status, new_status=new_status)
