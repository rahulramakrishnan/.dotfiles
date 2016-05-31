# Source bashrc - source of truth
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
export PATH="/usr/local/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
