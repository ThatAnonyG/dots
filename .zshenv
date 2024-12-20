typeset -U PATH path

path=("$HOME/.yarn/bin" "$HOME/go/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "/opt/insomnia" "$HOME/devtools/flutter/bin" "$path[@]")
export PATH

. "$HOME/.cargo/env"
