# Define some colors first:
# Has the same effect as using "ansi.sys" in DOS.
export FG_BLACK='\[\e[1;30m\]'
export FG_BOLD_RED='\[\e[1;31m\]'
export FG_RED='\[\e[0;31m\]'
export FG_BOLD_GREEN='\[\e[1;32m\]'
export FG_GREEN='\[\e[0;32m\]'
export FG_BOLD_YELLOW='\[\e[1;33m\]'
export FG_YELLOW='\[\e[0;33m\]'
export FG_BOLD_BLUE='\[\e[0;34m\]'
export FG_BLUE='\[\e[0;34m\]'
export FG_BOLD_MAGENTA='\[\e[1;35m\]'
export FG_MAGENTA='\[\e[0;35m\]'
export FG_BOLD_CYAN='\[\e[1;36m\]'
export FG_CYAN='\[\e[0;36m\]'
export FG_BOLD_WHITE='\[\e[1;37m\]'
export FG_WHITE='\[\e[0;37m\]'
export FG_GRAY="\[\033[0;37m\]"

export BG_BLACK='\[\e[1;40m\]'
export BG_RED='\[\e[1;41m\]'
export BG_GREEN='\[\e[1;42m\]'
export BG_YELLOW='\[\e[1;43m\]'
export BG_BLUE='\[\e[1;44m\]'
export BG_MAGENTA='\[\e[1;45m\]'
export BG_CYAN='\[\e[1;46m\]'
export BG_WHITE='\[\e[1;47m\]'

export BOLD='\[\e[1\]'
export FAINT='\[\e[2\]'
export ITALIC='\[\e[2\]'
export NORMAL='\[\e[22\]'
export UNDERLINE_ON='\[\e[2\]'
export UNDERLINE_OFF='\[\e[24\]'
export RESET='\[\e[0;39m\]'
export NOCOLOR='\[\e[0m\]'              # No Color

function parse_git_branch {

  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"

  remote_pattern="Your branch is (.*) of"
  diverge_pattern="Your branch and (.*) have diverged"
  not_staged="Changes not staged for commit:"
  changes="Changes to be committed:"
  # On some systems, git status starts with a '# '
  #branch_pattern="^# On branch ([^${IFS}]*)"
  branch_pattern="^On branch ([^${IFS}]*)"
  untracked_files="Untracked files:"

  state="";

  #if [[ ${git_status} =~ "nothing to commit (working directory clean)" ]]; then
  if [[ ${git_status} =~ "Your branch is up-to-date with " ]]; then
    state="${state} ✓"
  fi

  if [[ ${git_status} =~ ${not_staged} || ${git_status} =~ ${changes} ]]; then
    state="${state} ✗"
  fi

  if [[ ${git_status} =~ ${untracked_files} ]]; then
    state="${state} ✚"
  fi

  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      state="${state} ↑"
    else
      state="${state} ↓"
    fi
  fi

  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    state="${state} ↑↓"
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo -e "(${branch})${state}"
  fi
}

PS1="\h ${FG_BOLD_WHITE}\w ${FG_YELLOW}\$(parse_git_branch) ${FG_RED}\$${RESET} "
#PS1="${FG_BOLD_WHITE}\w ${FG_YELLOW} ${FG_RED}\$${RESET} "
