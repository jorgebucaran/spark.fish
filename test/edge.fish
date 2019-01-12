@mesg $current_filename

@test "one" (spark 1) = ▅
@test "constant" (spark 9 9 9 9) = ▅▅▅▅
@test "zeroes" (spark 0 0 0 0) = ▁▁▁▁
@test "holes" (spark 9 @ 9 @ 9) = ▅ ▅ ▅
@test "adidas" (spark --min=0 1 x 2 x 3) = ▃ ▅ █
@test "commas" (spark 1,5,10) = (spark 1 5 10)
