function __fish_mr_complete_functions
    # Call the script to get the list of functions
    mr help
end

complete -c mr -f -a "(__fish_mr_complete_functions)"
