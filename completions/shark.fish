set -l IFS \t

shark -h | __fisher_complete shark

complete -xc shark -d "Sparkline generator" -a "\t"
