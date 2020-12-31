# spark.fish

> Sparklines for [Fish](https://fishshell.com).

Unofficial port of [spark.sh](https://github.com/holman/spark) with `--min`, `--max` flags and improved [performance](#performance).

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install jorgebucaran/spark.fish
```

## Quickstart

You want to visualize a range of numbers right in your terminal.

```console
$ spark 1 2 4 8
▁▂▄█
```

And here is a sequence of random numbers.

```console
$ seq 64 | sort --random-sort | spark
▅▄▂▇▂▅▆▄▃█▂▅▄▁▆▆▃█▄▁▇▅▂▃▇▃▃▄▇▄▅▆▇▂▅▁▇▁▄▂▆▅▃█▇▆▆▅▆▃▄▄▇▃▂▇█▅▃█▁▂▂▆
```

You can set the `--min=<number>` or `--max=<number>` values for your sparkline too.

```console
$ seq 10 20 | spark
▁▂▂▃▄▄▅▆▇▇█
$ seq 10 20 | spark --min=0
▄▅▅▆▆▆▇▇▇██
$ seq 10 20 | spark --min=0 --max=30
▃▄▄▄▄▄▅▅▅▅▆
```

## Wicked Cool Usage

> Most of the examples in this section are derived from the original [Wicked Cool Usage](https://github.com/holman/spark/wiki/Wicked-Cool-Usage) wiki, ported to Fish.

Line lengths.

```console
$ awk \$0=length (functions --details spark) | spark
▃▆▃▃▃▄▃▂▄▄▄▅▂▄▅▂▆▁▅▂▅▅▃▂▂▆▃█▂▁▁▁
```

Number of commits in a repo, by author.

```console
$ git shortlog --summary | string match --regex "\d+" | spark
█▁▁▁▃▁▁▄▁▁▁
```

Total run time of processes.

```console
$ ps -A | string replace --filter --regex -- ".*(\d+):(\d+).*" "\$1 * 3600 + \$2 * 60" | bc | spark
▇▁▂▁▆▁▂▂▁▃▁▃▁▁▁▆▁▁▁▂▁▃▂▁▁▃▁▁▁▁▁▂▁▁▂▁▁▁▁▁▆▂▃▂▁▂▃▁▆▁▁▁▂▁▁▁▁▃▂▂▁▇▁▁▁▁▆
```

LOC added per commit over the last week.

```console
$ git diff @~7 --numstat | string replace --regex -- "(^\d+).*" "\$1" | spark
▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▂▂▃█▄▁▁
```

A moving wave through the terminal.

```fish
for i in (seq 100)
   for j in (seq (math $COLUMNS - 1))
      math "ceil(6 * cos(($i + $j) * pi / 5))"
   end | spark | read sparks
   echo -n $sparks\r && sleep .1
end
```

```console
▆▄▂▁▂▄▆▇█▇▆▄▂▁▂▄▆▇█▇▆▄▂▁▂▄▆▇█▇▆▄▂▁▂▄▆▇█▇▆▄▂▁▂▄▆▇█▇▆▄▂▁▂▄▆▇█
```

## Performance

Spark is faster than [`spark.sh`](https://github.com/holman/spark), reading and writing relatively large datasets under milliseconds.

```console
$ time seq 2000 | sort --random-sort | spark
________________________________________________________
Executed in   27.21 millis    fish           external
   usr time   26.40 millis    0.57 millis   25.83 millis
   sys time    4.87 millis    1.58 millis    3.29 millis

$ time seq 2000 | sort --random-sort | spark.sh
________________________________________________________
Executed in    2.73 secs    fish           external
   usr time    2.72 secs    0.33 millis    2.72 secs
   sys time    0.02 secs    1.47 millis    0.02 secs
```

## License

[MIT](LICENSE.md)
