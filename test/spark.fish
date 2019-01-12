@mesg $current_filename

@test "pyramid" (spark 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1) = ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁
@test "same distance" (spark 1 5 10 15 20) = (spark 10 50 100 150 200)
@test "upstairs" (spark 990 993 996) = ▁▄█
@test "fedora" (spark -5 3 2 -1 -5) = ▁█▇▄▁
@test "downstairs" (spark -500 -501 -502) = █▄▁
@test "sinewave" (spark 2 -1 -4 -6 -4 -1 2 5 6 5 2 -1 -4 -6 -4 -1 2) = ▅▃▂▁▂▃▅▇█▇▅▃▂▁▂▃▅
@test "stdin" (seq 8 | spark) = ▁▂▃▄▅▆▇█
