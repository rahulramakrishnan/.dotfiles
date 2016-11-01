# added by newengsetup
export EDITOR=vim
export UBER_HOME="$HOME/Uber"
export UBER_OWNER="rahulr@uber.com"
export UBER_LDAP_UID="rahulr"
# export PATH=$(brew --prefix)/sbin:$(brew --prefix)/bin:$PATH:$HOME/bin
export VAGRANT_DEFAULT_PROVIDER=aws
[ -s "/usr/local/bin/virtualenvwrapper.sh" ] && . /usr/local/bin/virtualenvwrapper.sh
[ -s "$HOME/.nvm/nvm.sh" ] && . $HOME/.nvm/nvm.sh
# type "brew" &>/dev/null && [ -s "$(brew --prefix)/etc/bash_completion" ] && . $(brew --prefix)/etc/bash_completion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

cdsync () {
    cd $(boxer sync_dir $@)
}
editsync () {
    $EDITOR $(boxer sync_dir $@)
}
opensync () {
    open $(boxer sync_dir $@)
}

# Bash RC

# git completion
source ~/dotfiles/bash_scripts/git-completion.sh
source ~/dotfiles/.bash_prompt.sh

# convenient command to open a dir and list files
# set a blazingly fast keyboard repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:$HOME/bin

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# aliases
# cs = cd + ls
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
alias tmux="export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock; tmux"
fixssh() {
    for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT;  do     
         if (tmux show-environment | grep "^${key}" > /dev/null); then       
               value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`;       
         export ${key}="${value}";     
         fi;   
    done; 
}
fixssh


RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
PURPLE='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
NIL='\[\033[00m\]'

# Hostname styles
FULL='\H'
SHORT='\h'

# System => color/hostname map:
# UC: username color
# LC: location/cwd color
# HD: hostname display (\h vs \H)
# Defaults:
UC=$GREEN
LC=$BLUE
HD=$FULL

# Prompt function because PROMPT_COMMAND is awesome
function set_prompt() {
    # show the host only and be done with it.
    host="${UC}${HD}${NIL}"

    # Special vim-tab-like shortpath (~/folder/directory/foo => ~/f/d/foo)
    _pwd=`pwd | sed "s#$HOME#~#"`
    if [[ $_pwd == "~" ]]; then
       _dirname=$_pwd
    else
       _dirname=`dirname "$_pwd" `
        if [[ $_dirname == "/" ]]; then
              _dirname=""
        fi
       _dirname="$_dirname/`basename "$_pwd"`"
    fi
    path="${LC}${_dirname}${NIL}"
    myuser="${UC}\u@${NIL}"

    # Dirtiness from:
    # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
    if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then dirty=""
    else
       dirty="${RED}*${NIL}"
    fi
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then
       branch=" ${NIL}[${PURPLE}${_branch}${dirty}${NIL}]"
    fi

    # Dollar/pound sign
    end="${LC}\$${NIL} "

    # Virtual Env
    if [[ $VIRTUAL_ENV != "" ]]
       then
           venv=" ${RED}(${VIRTUAL_ENV##*/})"
    else
       venv=''
    fi

    export PS1="${myuser}${path}${venv}${branch} ${end}"
}

export PROMPT_COMMAND=set_prompt
export TERM="xterm-color"
export PROMPT_COMMAND=set_prompt
PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R'
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# load colors
if [ -f ~/.bash_prompt ]
then
    . ~/.bash_prompt
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
