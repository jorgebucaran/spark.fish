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
