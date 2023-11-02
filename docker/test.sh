cd() {
    if [ "$1" = "API-Gateway-Machine-Learning" ]; then
        source /Users/koinworks/develop/apgw/bin/activate
    fi
    builtin cd "$1"
}
