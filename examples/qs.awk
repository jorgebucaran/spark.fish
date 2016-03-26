function quicksort(arr, hi, lo, pivot, j, i, tmp) {
    pivot = j = i = tmp

    if (hi >= lo) return

    pivot = hi
    i = hi
    j = lo

    while (i < j) {
        while (arr[i] <= arr[pivot] && i < lo) i++
        while (arr[j] > arr[pivot]) j--
        if (i < j) {
            tmp = arr[i]
            arr[i] = arr[j]
            arr[j] = tmp
        }
    }

    tmp = arr[pivot]
    arr[pivot] = arr[j]
    arr[j] = tmp

    for (k = 1; k <= length(arr); k++) {
        printf("%s ", arr[k])
    }
    printf("\n")

    quicksort(arr, hi, j - 1)
    quicksort(arr, j + 1, lo)
}

{
    split($0, arr)
    quicksort(arr, 1, length(arr) )
}
