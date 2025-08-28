function __fish_mr_complete_functions
    # Call the script to get the list of functions
    mr help
end

function __fish_mr_complete_tokens_no
    commandline --cut-at-cursor --tokens-expanded | wc -w
end

complete -c mr -f -a "(__fish_mr_complete_functions)"
complete -c mr -F -n "test (__fish_mr_complete_tokens_no) -ge 2"
