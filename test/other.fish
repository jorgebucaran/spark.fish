test "$TESTNAME - use custom string to display null values"
    "▂?▄?▆?█" = (
        printf "%s\n" 1,,2,,3,,4 | shark --null="?"
        )
end

test "$TESTNAME - no data prints nothing and exits with a 1"
    1 = (
        echo | shark
        echo $status
        )
end

test "$TESTNAME - show help information"
    "Usage: shark [--line] [--field[=<format>]] [--record[=<format>]] [--max=<n>] [--min=<n>] [--delim=<regex>] [--help] -n --line Process each line as a record -f --field=<format> Set field output format -r --record=<format> Set record output format -m --min=<number> Set minimum numeric value -M --max=<number> Set maximum numeric value -d --delim=<regex> Use <regex> as number separator --null=<string> Use <string> to display null values -h --help Show this help" = (
        shark -h | xargs
        )
end
