# config

各种配置文件

## 安装

clone 本项目

```shell
$ git clone https://github.com/jubgjf/config.git /path/to/config
```

使用前，需要设置环境变量`CONFIG_HOME`为 clone 保存的路径`/path/to/config`（默认为`$HOME/code/config`）

```shell
$ export CONFIG_HOME=/path/to/config
```

> 仅依赖 bash >= 3.2（macOS 自带），无需 Python 或其他依赖

### 查看配置文件状态

```shell
$ ./install.sh --status
```

输出样例

```
╔═══════════════╗
║   alacritty   ║
║ ✓ conda       ║
║   fcitx5      ║
║    ...        ║
║   vscodevim   ║
║ ✓ zellij      ║
║ ✓ zsh         ║
╚═══════════════╝
```

### 激活配置文件

```shell
$ ./install.sh --activate vscodevim
```

输出样例

```
╔═══════════════╗
║   alacritty   ║
║ ✓ conda       ║
║   fcitx5      ║
║    ...        ║
║ + vscodevim   ║
║ ✓ zellij      ║
║ ✓ zsh         ║
╚═══════════════╝
```

激活时，如果目标路径已存在非符号链接的文件/目录，会提示备份并覆盖。备份文件保存为`原路径.bak`，若`.bak`已存在则使用时间戳后缀。

同时会检测已知的冲突配置文件（如 `~/.gitconfig` 与 `~/.config/git/config`），并提示备份。

使用 `--force` 可跳过所有确认提示（自动备份）：

```shell
$ ./install.sh --activate vscodevim --force
```

### 取消配置文件

```shell
$ ./install.sh --deactivate zellij
```

输出样例

```
╔═══════════════╗
║   alacritty   ║
║ ✓ conda       ║
║   fcitx5      ║
║    ...        ║
║   vscodevim   ║
║ - zellij      ║
║ ✓ zsh         ║
╚═══════════════╝
```

## 测试

测试框架使用沙箱隔离，不会影响开发者的实际配置文件：

- macOS: 使用 seatbelt (`sandbox-exec`) 框架
- Linux/WSL: 使用 bubblewrap (`bwrap`)
- 无沙箱工具时: 通过重定向 `$HOME` 提供基本隔离

```shell
$ bash tests/run_tests.sh
```

## 其他

- 编辑`config.sh`添加/删除/修改配置文件的映射路径
- 编辑`conflicts.sh`添加/删除/修改冲突检测路径
- 可使用`--verbose`选项输出详细日志
- 持续更新中...
