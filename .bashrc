# Homebrew customizations
brew analytics off 2>&1 >/dev/null

# ---- GoLang configurations ----

# GoLang path
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# GoLang clone
goclone() {
  mkdir -p $GOPATH/src/code.uber.internal/$1
  git clone gitolite@code.uber.internal:$1 $GOPATH/src/code.uber.internal/$1 --recursive
}

# ---- Git Configurations ----

# git auto completion
source ~/.dotfiles/scripts/git-completion.sh

# git rebase against latest master
function update() {
  git checkout master && git pull origin master && git checkout - && git rebase master
}



# ---- CLI aliases ----
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

# Tmux auto port forwarding
alias tmux="export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock; tmux"

# --- Customize bash prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='$(if [[ $? == 0 ]]; then echo "\[\e[32m\]:)"; else echo "\[\e[31m\]:("; fi)\[\e[0m\] \u \w $(parse_git_branch) $ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# MySQL configurations
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
