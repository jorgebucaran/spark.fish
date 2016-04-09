function shark --description 'Sparkline generator'
    set -l field "%s"
    set -l record "\n"
    set -l delim "[, ]"
    set -l line 0
    set -l min -1
    set -l max 0
    set -l null " "

    set -g shark_path (dirname (status -f))

    getopts $argv | while read -l 1 2
        switch $1
            case n line
                set line 1

                switch "$2"
                    case 0 false
                        set line 0
                end

            case null
                set null "$2"

            case m min
                set min "$2"

            case M max
                set max "$2"

            case f field
                set field "$2"

            case r record
                set record "$2"

            case d delim
                set delim "$2"

            case h help
                printf "Usage: shark [--line] [--field[=<format>]] [--record[=<format>]]\n"
                printf "             [--max=<n>] [--min=<n>] [--delim=<regex>] [--help]\n\n"

                printf "     -n --line              Process each line as a record         \n"
                printf "     -f --field=<format>    Set field output format               \n"
                printf "     -r --record=<format>   Set record output format              \n"
                printf "     -m --min=<number>      Set minimum numeric value             \n"
                printf "     -M --max=<number>      Set maximum numeric value             \n"
                printf "     -d --delim=<regex>     Use <regex> as number separator       \n"
                printf "        --null=<string>     Use <string> to display null values   \n"
                printf "     -h --help              Show this help\n"
                return

            case \*
                printf "shark: '%s' is not a valid option\n" $1 >& 2
                shark --help >& 2
                return 1
        end
    end

    awk -v FS="$delim" -v line=$line -v ORS="$record" -v OFS="$field" -v null="$null" -v min="$min" -v max="$max" '
            BEGIN {
                tickLength = split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", ticks, " ")

                hasMax = max > 0
                hasMin = min >= 0

                max = min > max ? min : max
            }

            !/^ *$/ {
                if (line) {
                    fieldIndex = 0
                    min = hasMin ? min : -1
                    max = hasMax ? max : 0
                }

                for (n = 1; n <= NF; n++) {
                    $n = buffer[++fieldIndex] = ($n ~ /^[0-9]*\.?[0-9]+$/) ? $n : ""

                    if (!hasMax) max = ($n > max) ? $n : max
                    if (!hasMin) min = (min < 0 || $n < min) ? ($n == "" ? min : $n) : min
                    if (hasMax && hasMin) plot($n)
                }

                if (line) {
                    if (!(hasMax && hasMin)) {
                        plotBuffer(fieldIndex)
                    }

                    printf(ORS, max, min, fieldIndex)
                }
            }

            END {
                if (line || !fieldIndex) exit !fieldIndex
                if (!(hasMax && hasMin)) plotBuffer(fieldIndex)

                printf(ORS, max, min, fieldIndex)
            }

            function plot(value, tickIndex) {
                tickToken = null

                if (value >= 0) {

                    tickIndex = int((value / (!max ? 1 : max) * tickLength) - 1) + 1

                    tickIndex = (tickIndex <= 0) ? 1 : tickIndex
                    tickIndex = (tickIndex > 8 || max == value) ? 8 : tickIndex
                    tickIndex = (min == max) ? 5 : tickIndex
                    tickIndex = (max == 0) ? 1 : tickIndex

                    tickToken = ticks[tickIndex]
                }

                printf(OFS, tickToken, value)
            }

            function plotBuffer(fieldIndex) {
                for (i = 1; i <= fieldIndex; i++) {
                    plot(buffer[i])
                }
            }

        '
end
