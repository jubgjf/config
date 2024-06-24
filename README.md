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

> 考虑到新系统的python很可能未安装各种库，因此本安装脚本在使用过程中仅依赖python>=3.10的原生模块，不依赖第三方库
> python<3.10未进行过测试

### 查看配置文件状态

```shell
$ python install.py --status
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
$ python install.py --activate vscodevim
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

### 取消配置文件

```shell
$ python install.py --deactivate zellij
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

## 其他

- 编辑`config.json`添加/删除/修改配置文件的映射路径
- 可使用`--verbose`选项输出详细日志
- 持续更新中...
