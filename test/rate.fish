set -l rates 0 5 10 15 20 25 30
set -l sparks \
    ▁█▃▆▄▂▁ ▃█▆██▄▁ ▁█▃▆▄▂▁ ▁▅▂▄▃▁▁ ▁▄▁▃▂▁▁ ▁▃▁▂▁▁▁ ▁▂▁▂▁▁▁         \
    ▅▅▅▅▅ ▅▅▅▅▅ ▄▄▄▄▄ ▂▂▂▂▂ ▂▂▂▂▂ ▁▁▁▁▁ ▁▁▁▁▁                       \
    ▁▂▃▄▅▆▇█ ▁▃▄▆████ ▁▁▂▃▄▄▅▆ ▁▁▁▂▂▃▃▄ ▁▁▁▁▂▂▂▃ ▁▁▁▁▁▁▂▂ ▁▁▁▁▁▁▁▂  \
    ▃▄▅▆█▆▅▄▃ ▄▆█████▆▄ ▂▃▄▄▅▄▄▃▂ ▁▂▂▃▃▃▂▂▁ ▁▁▂▂▂▂▂▁▁ ▁▁▁▁▂▁▁▁▁ ▁▁▁▁▁▁▁▁▁

set -l dataset      \
    2,10,4,8,6,3,1  \
    5,5,5,5,5       \
    1,2,3,4,5,6,7,8 \
    3,4,5,6,7,6,5,4,3

for data in $dataset
    for r in $rates
        test "$TESTNAME - rates: max > actual max narrows height $sparks[1]"
            (printf "%s\n" $data | shark --max=$r) = $sparks[1]
        end
        set -e sparks[1]
    end
end
