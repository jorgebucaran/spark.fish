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
