shark(1) -- Sparkline generator
===============================

## SYNOPSIS

`shark` [*options*] [`--version`] [`--help`]<br>
`shark` [`--line`] [`--field`=*format*] [`--record`=*format*]<br>
`shark` [`--null`=*string*] [`--delim`=*regex*]<br>
`shark` [`--min`=*number*] [`--max`=*number*]

## DESCRIPTION

**Shark** is a [sparkline] generator.

Input is read up to NULL and processed as a single record by default. To process each line as a separate record, use the --line flag.

To process the input in real time, use --max=*number* and --min=*number* to set the dataset range in advance.

Shark was inspired by Zach Holman's [Spark]. Thanks to him.

## USAGE

* Plot a sequence of numbers.

```fish
seq 8 | shark
```

* Plot two set of numbers and treat each as an individual dataset.

```fish
printf "%s\n" "1 2 3 4 5" "100 200 300 400 500" | shark -n
```

* Draw a random sequence of numbers.

```fish
for i in (seq 42)
    random
end | shark
```

## OPTIONS

* -n, --line[=*true*|*false*:
    Process each line as a separate record. By default, Shark reads all the input up to NULL and uses the collected numbers as one dataset. --line changes this behavior, and forces Shark to process *each* line as a separate record and the collected numbers from each record as different datasets.

    A single line of input may contain one or more numbers. If a line contains multiple numbers, processing each line separately may be preferred based on your application requirements. To customize the record output format use --record=*format*.

* -f, --field=*format*:
    Set the field output *format*. A field or *tick* is any of the UTF-8 block characters used to represent the numeric values collected from the dataset. *format* is a printf(1) valid format string. The default value is `"%s"`. You can display the numeric value of the current field using an additional `%d`. For example, `"%s\t%d\n"` will display each tick in a new line followed by a *tab* and the corresponding number collected from the dataset.

* -r, --record=*format*:
    Set the record output *format*. Typically, a record consists of a single line of input and a dataset of one or more lines. The default value is a new line `\n`. You can force all output to be displayed in a single line regardless of --line by setting this option to an empty string --record=*""*.

    The following additional format markers are available:

    * The first `%d` after `%s` displays the *largest* number in the data set.<br>
    * The second `%d` displays the *smallst* number in the data set.<br>
    * The third `%d` displays the total number of fields in the record.<br>

    For example, `"\tMAX %5d | MIN %5d\n"` will display each record in a single line, followed by a tab and the *largest* and *smallest* value; right-column aligned by 5 spaces.

* -M, --max=*number*:
    Set the maximum value in the dataset. If this option is set, Shark does not calculate the max value and uses *number* instead.

    Typically, Shark must read the entire dataset, or line record if --line was used, in order to calculate both min and max and draw a sparkline.

    Use this option together with --min=*number* to process and draw the input in real time.

* -m, --min=*number*:
    Set the minimum value in the dataset. If this option is set, Shark does not calculate the min value and uses *number* instead.

    Use this option together with --max=*number* to draw the input in real time.

* -d, --delim=*regex*:
    Use *regex* as the number delimiter. This value is used to extract numbers from each line of the input. The default value is `[, ]`.

* --null=*string*:
    Use *string* to display null values in the dataset. Items that could not be parsed from the dataset as numbers, will be displayed using *string*. A white space `" "` is displayed by default. To print nothing, use an empty string `""`.

* -h, --help:
    Show usage help.

## EXAMPLES

To run the bundled examples:

```fish
source examples/shark.fish
```

* Visualize bubble sort.

```fish
for i in (seq 100)
    printf "%s " (random)
end | awk -f bs.awk | shark -nr\r
```

* Visualize quicksort.

```fish
for i in (seq 100)
    printf "%s " (random)
end | awk -f qs.awk ' | shark -nr\r
```

* Display realtime data.

```fish
curl -s $data | shark --min=0 --max=32766 -r\r
```

* Display a moving wave through the terminal.

```fish
while true
    printf "0$i + 1\n" | bc | read -l i
    ruby -e "
        (0..`tput cols`.to_i - 1).collect{|x|
            printf '%s ', (6 * Math::cos((x + $i) * Math::PI/5)).ceil
        }
    " | shark -d"[-| ]" --record="\r" --null=""
end
```

## CAVEATS

From [fish-shell/issues/206](https://github.com/fish-shell/fish-shell/issues/206), redirections and pipes involving blocks are run serially, not in parallel. This causes Shark to block the pipeline and buffer the output when you pipe it to another command.

```fish
STDIN | shark | formatter
```

### WORKAROUNDS

You can run Shark as an executable file, by adding the source to a file with a shebang and copying it to a directory in your `$PATH`, e.g., /usr/local/bin.

```fish
awk 'BEGIN { print "#!/usr/bin/env fish" } // END { print "shark $argv" }' shark.fish > shark
chmod +x shark
cp shark /usr/local/bin
```

Now you should be able to pipe Shark's output to *formatter* and process the data without blocking.

```fish
function formatter
    set -l LO \u2581
    set -l HI \u2588

    set -l R (set_color red)
    set -l G (set_color green)
    set -l N (set_color normal)

    sed "s/$LO/$R$LO$N/g;s/$HI/$G$HI$N/g"
end

set -l data https://gist.githubusercontent.com/bucaran/af98670d9c301c89b3ed/raw
curl -s $data | shark -n | formatter
```

*formatter* is used above to color lower ticks red and the highest block ticks green.

Another more practical, but less flexible workaround is running Shark inside a child process.

```fish
curl -s $data | fish -c "shark -n" | sed "s/$LO/$R$LO$N/;s/$HI/$G$HI$N/"
```

*Note*: Shark must be installed as a function in your `$fisher_function_path`. Otherwise, it will not be available to the child process.

[Spark]: https://github.com/holman/spark
[sparkline]: https://en.wikipedia.org/wiki/Sparkline
[Fisherman]: https://github.com/fisherman/fisherman
[fish]: https://github.com/fish-shell/fish-shell
