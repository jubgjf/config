if [[ "$(hostname)" == "hpc-server" || "$(hostname)" == "zxk-Ubuntu22" ]] {
    if [[ -z "$ZELLIJ" ]]; then
        if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            zellij attach
        fi
    fi
}
