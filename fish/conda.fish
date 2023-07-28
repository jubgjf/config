switch (hostname)
case "*MacBook*"
    if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
        eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
    end
case "*"
    if test -f ~/.miniconda/bin/conda
        eval ~/.miniconda/bin/conda "shell.fish" "hook" $argv | source
    end
end
