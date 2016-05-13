set -l dataset          \
    "0 0 0 0 0 0"       \
    "1 5 22 13 5"       \
    "5.5 20"            \
    "0 30 55 80 33 150" \
    "1 50 100"          \
    "2 4 8"             \
    "1 2 3 4 5 6 7 8"   \
    "5,,10,,20"         \
    "25 45"             \
    "1 1 1 1"           \
    "1 2 3 4 1,2,3,4"   \
    "1 2 3 4 100 5 10 20 50 200" \
    "0.5 1.5 1.8 1.9 2.3 0.5 0.9 0.3 0.8"

set -l sparks ▁▁▁▁▁▁ ▁▁█▄▁ ▂█ ▁▁▂▄▁█ ▁▄█ ▂▄█ ▁▂▃▄▅▆▇█ "▂ ▄ █" ▄█ ▅▅▅▅ ▂▄▆█▂▄▆█ ▁▁▁▁▄▁▁▁▂█ ▁▅▆▆█▁▃▁▂
set -l delimiters , " "

for data in $dataset
    for delim in $delimiters
        test "$TESTNAME - delimiter: ( $delim ) dataset: [$data] result: $sparks[1]"
            (printf "%s\n" $data | paste -sd$delim - | shark) = $sparks[1]
        end
    end

    test "$TESTNAME - multiline source dataset: [$data] result: $sparks[1]"
        (printf "%s\n" $data | tr " " "\n" | shark) = $sparks[1]
    end

    set -e sparks[1]
end

test "$TESTNAME - treat all lines as a single dataset by default ▁▁▁▁▁▁▂▅█"
    ▁▁▁▁▁▁▂▅█ = (printf "%s\n" 1,2,3 10,20,30 100,200,300 | shark)
end

test "$TESTNAME - --line: treat each line as a separate dataset ▂▅█ ▂▅█ ▂▅█"
    ▂▅█ ▂▅█ ▂▅█ = (printf "%s\n" 1,2,3 10,20,30 100,200,300 | shark --line)
end

test "$TESTNAME - --field: use a custom field format ▁_█_▅_▆_ _▂_▁_"
    "▁_█_▅_▆_ _▂_▁_" = (printf "%s\n" 0,12,8,10,,3,2 | shark --field="%s_")
end

test "$TESTNAME - --record: use a custom record format █▁|▅▅|█▁|▁▄█|"
    "█▁|▅▅|█▁|▁▄█|" = (printf "%s\n" 5,1 3,3 9,0 2,6,12 | shark --line --record="|")
end

test "$TESTNAME - use custom delimiter as number separator"
    (printf "%s\n" 1:2:3:4 | shark --delim="[:]") = ▂▄▆█
end

test "$TESTNAME - --field=%s `%d` shows numeric value"
    (printf "%s\n" 5,2,10 | shark --field="%s %d, ") = "▄ 5, ▁ 2, █ 10, "
end

test "$TESTNAME - --field=%s `%d` shows numeric value"
    (printf "%s\n" 5,2,10 | shark --record="max:%d, min:%d, ticks:%d") = "▄▁█max:10, min:2, ticks:3"
end
