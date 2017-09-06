# homebrew customizations
brew analytics off 2>&1 >/dev/null

# ---- go configurations ----

# go path
export GOPATH="$HOME/gocode"
export PATH="$PATH:$GOPATH/bin"

# go clone
goclone() {
  mkdir -p $GOPATH/src/code.uber.internal/$1
  git clone gitolite@code.uber.internal:$1 $GOPATH/src/code.uber.internal/$1 --recursive
}

# ---- git configurations ----

# git auto completion
source ~/.dotfiles/scripts/git-completion.sh


# ---- cli aliases ----
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

# tmux auto port forwarding
alias tmux="export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock; tmux"
