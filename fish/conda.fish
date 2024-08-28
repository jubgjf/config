if test -f $HOME/.miniconda/bin/conda
    eval $HOME/.miniconda/bin/conda "shell.fish" "hook" $argv | source
end
