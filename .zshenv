typeset -U PATH path

path=("$ASDF_DATA_DIR/shims", "$HOME/.yarn/bin" "$HOME/go/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "/opt/insomnia" "$HOME/devtools/flutter/bin" "$path[@]")
export PATH

. "$HOME/.cargo/env"
