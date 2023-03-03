switch (hostname)
case "*MacBook*"
    if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
        eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
    end
case "hpc-server"
case "WorkStation"
case "gpu*"
case "*"
end
