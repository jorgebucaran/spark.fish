@mesg $current_filename

@test "not enough data" (spark 25 45) = ▁█
@test "enough data" (spark 0 25 45) = ▁▄█
@test "25,45 min=0" (spark --min=0 -- 25 45) = ▄█
@test "5,6,7 min=0" (spark --min=0 -- 5 6 7) = ▆▇█
@test "change scale" (spark --max=10 -- 1 5 1) = ▁▄▁
@test "large one" (spark 1 --max=1) = █
@test "equivalent" (spark --max=10 -- 1 2 3 4 5) = (spark --max=100 -- 10 20 30 40 50)
