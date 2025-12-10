# ---- GoLang ----

# GoLang path
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# ---- Fuzzy Reverse Search ----

# FZF Configuration
if [ -d "$HOME/.fzf" ]; then
    # Add to path
    export PATH="$HOME/.fzf/bin:$PATH"

    # Auto-completion
    [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    source "$HOME/.fzf/shell/key-bindings.zsh"
fi

# ---- Aliases ----

# cx = cd + ls
function cx() {
  if [ -d "env" ] ; then
    source env/bin/activate
  fi
  if [ $# -eq 0 ]; then
    cd && ls -G
  else
    cd "$*" && ls -G
  fi
}

