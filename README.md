# fish-spark

[![Build Status](https://img.shields.io/travis/jorgebucaran/fish-spark.svg)](https://travis-ci.org/jorgebucaran/fish-spark)
[![Releases](https://img.shields.io/github/release/jorgebucaran/fish-spark.svg?label=latest)](https://github.com/jorgebucaran/fish-spark/releases)

Spark is a sparkline generator for the fish shell. This is an unofficial port of the original [spark.sh](https://github.com/holman/spark).

![](https://gitcdn.link/repo/jorgebucaran/789d7e2c08a968c7370ddbbff2c7c125/raw/3ea3780910872ca0a60d234723704a962c399187/fish-spark.svg)

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher) (recommended):

```
fisher add jorgebucaran/fish-spark
```

<details>
<summary>Not using a package manager?</summary>

---

Copy [`spark.fish`](spark.fish) to any directory on your function path.

```fish
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
curl https://git.io/spark.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/spark.fish
```

To uninstall, remove the file.

</details>

### System Requirements

- [fish](https://github.com/fish-shell/fish-shell) 2.0

## Usage

You have a set of numbers which can be comma-delimited, separated by spaces, newlines, or tabs. What's a simple way to visualize these data on the terminal? Sparlines!

```console
$ spark 0 1 2 3
▁▃▅█
```

Spark can read from standard input as well. Here is a random sequence of numbers.

```console
$ seq 80 | sort -R | spark
▁▅▄▄▂▁▂▅▂▇▄▅▄▃▃▄▁▂▃▁▁▅▄▇▃▆▆▂▄▄▂▆▆▆▇▃▆▇▁▄▃▄▆▅▄█▅▁▃▆▁▁▁▂▆▁▅▅▇▇▅▇▅▇▃▆▄▂▇▃▃▅▂▁▇▆▂▇▂▃
```

Spark calculates the smallest and largest numbers from your dataset to calibrate the height of the sparklines. To force these values to anything else use `--min=<number>` and `--max=<number>`.

```console
$ spark 10 20 30 40 50
▁▂▄▆█
$ spark --max=100 -- 10 20 30 40 50
▁▂▃▃▄
```

This is just the tip of the iceberg. Check out [Wicked Cool Usage](https://github.com/holman/spark/wiki/Wicked-Cool-Usage) for more things you can do with Spark.

## License

[MIT](LICENSE.md)
