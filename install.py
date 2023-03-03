import argparse
import os
import subprocess

HOME: str
CONFIG_HOME: str
XDG_CONFIG_HOME: str


def get_hostname():
    return subprocess.check_output(["hostname"]).decode("utf-8").strip()


def activate(target: str, path_map: dict):
    # ===== special handler =====
    cmd = ""
    if target == "git":
        hostname = get_hostname()
        if "MacBook" in hostname:
            cmd = f"ln -s {CONFIG_HOME}/git/config_mac {CONFIG_HOME}/git/config"
        elif hostname == "hpc-server" or hostname.startswith("gpu"):
            cmd = f"ln -s {CONFIG_HOME}/git/config_hpc {CONFIG_HOME}/git/config"
        elif hostname == "WorkStation":
            cmd = f"ln -s {CONFIG_HOME}/git/config_wsl {CONFIG_HOME}/git/config"
        print(
            f"RUN {cmd}"
            if cmd != ""
            else f"hostname {hostname} for {target} not support, skip"
        )
        if cmd != "":
            os.system(cmd)
    if target == "gpg":
        hostname = get_hostname()
        if "MacBook" in hostname:
            cmd = f"ln -s {CONFIG_HOME}/gpg/gpg-agent-mac.conf {CONFIG_HOME}/gpg/gpg-agent.conf"
        elif (
            hostname == "hpc-server"
            or hostname.startswith("gpu")
            or hostname == "WorkStation"
        ):
            cmd = f"ln -s {CONFIG_HOME}/gpg/gpg-agent-common.conf {CONFIG_HOME}/gpg/gpg-agent.conf"
        print(
            f"RUN {cmd}"
            if cmd != ""
            else f"hostname {hostname} for {target} not support, skip"
        )
        if cmd != "":
            os.system(cmd)
    if target == "ideavim":
        hostname = get_hostname()
        if "MacBook" in hostname:
            cmd = f"ln -s {CONFIG_HOME}/ideavim/ideavimrc-mac {CONFIG_HOME}/ideavim/ideavimrc"
        print(
            f"RUN {cmd}"
            if cmd != ""
            else f"hostname {hostname} for {target} not support, skip"
        )
        if cmd != "":
            os.system(cmd)
    # ===== special handler ends, start common handler=====

    src_path = list(path_map.keys())[0]
    tgt_path = list(path_map.values())[0]
    cmd = f"ln -s {src_path} {tgt_path}"
    print(f"RUN {cmd}")
    os.system(cmd)


def deactivate(target: str, path_map: dict):
    tgt_path = list(path_map.values())[0]
    cmd = f"rm -r {tgt_path}"
    if input(f"Are you sure to run: {cmd}? [y/n]") != "y":
        print(f"Skip {target}")
    else:
        os.system(cmd)


if __name__ == "__main__":
    if input("Assuming $CONFIG_HOME = $HOME/code/config, continue? [y/n]") != "y":
        print("Abort")
        exit(0)

    HOME = os.getenv("HOME")
    assert HOME is not None
    CONFIG_HOME = HOME + "/code/config"
    XDG_CONFIG_HOME = HOME + "/.config"
    os.chdir(CONFIG_HOME)

    dirs = [
        x
        for x in filter(
            lambda d: os.path.isdir(d) and d != "__pycache__" and d != ".git",
            os.listdir("."),
        )
    ]
    dirs.sort()

    maps = {
        "alacritty": {f"{CONFIG_HOME}/alacritty": f"{XDG_CONFIG_HOME}/alacritty"},
        "conda": {f"{CONFIG_HOME}/conda/condarc": f"{HOME}/.conda/condarc"},
        "fish": {f"{CONFIG_HOME}/fish": f"{XDG_CONFIG_HOME}/fish"},
        "git": {f"{CONFIG_HOME}/git": f"{XDG_CONFIG_HOME}/git"},
        "gpg": {f"{CONFIG_HOME}/gpg/gpg-agent.conf": f"{HOME}/.gnupg/gpg-agent.conf"},
        "ideavim": {f"{CONFIG_HOME}/ideavim/ideavimrc": f"{HOME}/.ideavimrc"},
        "lsd": {f"{CONFIG_HOME}/lsd": f"{XDG_CONFIG_HOME}/lsd"},
        "neovim": {f"{CONFIG_HOME}/neovim": f"{XDG_CONFIG_HOME}/nvim"},
        "pip": {f"{CONFIG_HOME}/pip": f"{XDG_CONFIG_HOME}/pip"},
        "ranger": {f"{CONFIG_HOME}/ranger": f"{XDG_CONFIG_HOME}/ranger"},
        "starship": {
            f"{CONFIG_HOME}/starship/starship.toml": f"{XDG_CONFIG_HOME}/starship.toml"
        },
        "zsh": {f"{CONFIG_HOME}/zsh/_zshrc": f"{HOME}/.zshrc"},
    }

    assert set(dirs) == set(maps.keys())

    parser = argparse.ArgumentParser()
    parser.add_argument("--activate", nargs="+", type=str, choices=dirs)
    parser.add_argument("--deactivate", nargs="+", type=str, choices=dirs)
    args = parser.parse_args()
    activate_targets: list = args.activate if args.activate is not None else []
    deactivate_targets: list = args.deactivate if args.deactivate is not None else []

    assert set(activate_targets).intersection(set(deactivate_targets)) == set()

    max_word_length = max([len(d) for d in dirs])
    border_length = 4 + max_word_length + 2
    print("╔" + "═" * border_length + "╗")
    for dir in dirs:
        if dir in activate_targets:
            mark = "✓"
        elif dir in deactivate_targets:
            mark = "⨯"
        else:
            mark = " "
        whitespaces = " " * (border_length - 3 - len(dir))
        print(f"║ {mark} {dir}" + whitespaces + "║")
    print("╚" + "═" * border_length + "╝")
    if input("Continue? [y/n]") != "y":
        print("Abort")
        exit(0)

    if args.activate is not None:
        cmd = "mkdir -p ~/.config"
        print(f"RUN {cmd}")
        os.system(cmd)

    for target in activate_targets:
        activate(target, maps[target])
    for target in deactivate_targets:
        deactivate(target, maps[target])
