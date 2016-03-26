{
    for (j = 1; j <= NF; j++) {
        for (i = 1; i <= NF - j; i++) {
            if ($i > $(i + 1)) {
                tmp = $i
                $i = $(i + 1)
                $(i + 1) = tmp
            }
            for (k = 1; k <= NF; k++) {
                printf("%s ", $k)
            }
            printf("\n")
        }
    }
}
