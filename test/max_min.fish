set -l max_sparks ▁▂▃▄▅▆▇█ ▅▅▅▅▅▅▅▅ ▄███████ ▂▅██████ ▂▄▆█████ ▁▃▄▆████ ▁▂▄▅▆███ ▁▂▃▄▅▆██ ▁▂▃▄▅▆▇█
set -l min_sparks ▂▅█ ▂▅█ ▂▅█ ▅▅▅

for i in (seq 0 8)
    test "$TESTNAME - max only: dataset [1,2,3,4,5,6,7,8] min=? max=$i $max_sparks[1]"
        (seq 8 | shark --max=$i) = $max_sparks[1]
    end
    set -e max_sparks[1]
end

for i in (seq 0 3)
    test "$TESTNAME - min only: dataset [1,2,3,4,5,6,7,8] min=$i max=? $min_sparks[1]"
        (seq 3 | shark --min=$i) = $min_sparks[1]
    end
    set -e min_sparks[1]
end

test "$TESTNAME - min max: plot one value" (
    printf "%s\n" 1 | shark
    printf "%s\n" 1 | shark --min=0 --max=1) = █ ▅
end
