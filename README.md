# fish-spark

[![Build Status](https://img.shields.io/travis/jorgebucaran/fish-spark.svg)](https://travis-ci.org/jorgebucaran/fish-spark)
[![Releases](https://img.shields.io/github/release/jorgebucaran/fish-spark.svg?label=latest)](https://github.com/jorgebucaran/fish-spark/releases)

Spark is a sparkline generator for the <a href=https://fishshell.com title="friendly interactive shell">fish shell</a>. It's an unofficial port of the original [spark.sh](https://github.com/holman/spark) with options for adjusting the minimum and maximum values of the input and [faster execution time](#performance).

###### ▁▁▁▁▁▁▁▁▁▂▆▁▃▆▆▆▃▁▁▁▁▁▂▃▄▂▆▆▃▃▄▅▂▃▁▁▁▄▁▁▁▇▁▇▁▁▃▃▅▂▄▅▃▃▁▁▁▁▂▁▁▇▆▃▃█▂▁▁▁▁▁▁

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

You have a set of numbers which can be comma-delimited, separated by spaces, newlines, or tabs. What's a simple way to visualize these data on the terminal? Sparklines!

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

And this is just the tip of the iceberg.

Check out [Wicked Cool Usage](https://github.com/holman/spark/wiki/Wicked-Cool-Usage) for more things you can do with Spark.

## Performance

Spark is considerably faster than the original [`spark.sh`](https://github.com/holman/spark), reading and writing relatively large datasets under milliseconds.

- Reading 10,000 numbers.

  ```console
  $ time fish -c "seq 10000 | sort -R | spark" >/dev/null
         0.19 real         0.19 user         0.01 sys

  $ time fish -c "seq 10000 | sort -R | spark.sh" >/dev/null
         86.15 real        84.44 user         0.53 sys
  ```

- Reading a 100×100 table of numbers.

  ```console
  $ time fish -c "for i in (seq 100); seq 100 | sort -R | xargs; end | spark" >/dev/null
         0.70 real         0.41 user         0.56 sys
  $ time fish -c "for i in (seq 100); seq 100 | sort -R | xargs; end | spark.sh" >/dev/null
         79.92 real        79.21 user         0.74 sys
  ```
  
## License

[MIT](LICENSE.md)
