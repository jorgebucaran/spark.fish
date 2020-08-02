# spark.fish

> ▁▂▃▅▂▇ in your fish shell.

Spark is a sparkline generator for <a href=https://fishshell.com title="friendly interactive shell">fish</a>. It's an unofficial port of [spark.sh](https://github.com/holman/spark) with options for adjusting the minimum and maximum values of the input and all-around [better performance](#performance).

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher) (recommended):

```console
fisher add jorgebucaran/spark.fish
```

<details>
<summary>Not using a package manager?</summary>

---

Copy [`spark.fish`](spark.fish) to any directory on your function path.

```fish
curl https://git.io/spark.fish --create-dirs -sLo ~/.config/fish/functions/spark.fish
```

</details>

## Getting Started

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

Want to see what else Spark can do? Check out [Wicked Cool Usage](https://github.com/holman/spark/wiki/Wicked-Cool-Usage) and prepare to be amazed!

## Performance

Spark is up to 400x faster (that's not a typo!) than the original [`spark.sh`](https://github.com/holman/spark), reading and writing relatively large datasets under milliseconds.

```console
$ time fish -c "seq 10000 | sort -R | spark" >/dev/null
       0.19 real         0.19 user         0.01 sys

$ time fish -c "seq 10000 | sort -R | spark.sh" >/dev/null
       86.15 real        84.44 user         0.53 sys
```

## License

[MIT](LICENSE.md)
