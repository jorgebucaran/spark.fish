complete -c spark --exclusive --long version -d "Print version"
complete -c spark --exclusive --long help -d "Print this help message"

complete -c spark --exclusive --condition "__fish_use_subcommand" --long min -d "Minimum range value"
complete -c spark --exclusive --condition "__fish_use_subcommand" --long max -d "Maximum range value"
