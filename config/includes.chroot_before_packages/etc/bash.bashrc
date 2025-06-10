#!/bin/bash
#
# /etc/bash/bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

## HISTORY

export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoreboth
export HISTIGNORE="exit:history *:history"



#### SCRIPTS Begin ####

. /etc/CUSTOMIZATIONS.d/Shell_functions.sh

#### SCRIPTS End ####



## Setup prompt

# Color codes for easy prompt building
COLOR_DIVIDER="\033[38;5;144m"
COLOR_USERNAME="\033[38;5;11m"
COLOR_USERHOSTAT="\033[38;5;173m"
COLOR_HOSTNAME="\033[38;5;153m"
COLOR_GUI="\033[38;5;30m"
COLOR_GUI_X11="\033[38;5;125m"
COLOR_GUI_WAYLAND="\033[38;5;32m"
COLOR_GITBRANCH="\033[38;5;214m"
COLOR_GITBRANCH_L1="\033[38;5;42m" # list color 1
COLOR_GITBRANCH_L2="\033[38;5;44m" # list color 2
COLOR_VENV="\033[38;5;212m"
COLOR_GREEN="\033[38;5;34m"
COLOR_PATH_OK="\033[38;5;106m"
COLOR_PATH_ERR="\033[38;5;203m"
COLOR_EXIT_OK="\033[38;5;154m"
COLOR_EXIT_FAIL="\033[38;5;160m"
COLOR_UID_SYM_OK="\033[01;38;5;45m"
COLOR_UID_SYM_WARN="\033[01;38;5;196m"
COLOR_NONE="\033[0m"


export BASH_PROMPT__etc_bash_bashrc__last_exit_code__=0

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot="${COLOR_DIVIDER}chroot->[${COLOR_USERHOSTAT}$(cat /etc/debian_chroot)${COLOR_DIVIDER}]"
fi

# Function to get the exit code with appropriate color
EXIT_CODE_CMD() {
    if [ $BASH_PROMPT__etc_bash_bashrc__last_exit_code__ -eq 0 ]; then
        printf "${COLOR_EXIT_OK}${BASH_PROMPT__etc_bash_bashrc__last_exit_code__}${COLOR_DIVIDER}"
    else
        printf "${COLOR_EXIT_FAIL}\342\234\227${BASH_PROMPT__etc_bash_bashrc__last_exit_code__}${COLOR_DIVIDER}"
    fi
}

# Git branch and virtual environment functions
GBR_CMD() {
    if command -v git &> /dev/null && git rev-parse --is-inside-work-tree &> /dev/null; then
	    G_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null)"
	    G_BRANCH_LIST=""
	    _sw=1
	    for _rem in $(git show-branch -a | awk -e '// {if ($2 == "") {exit 0}; print $2}')
	    do
	    	if [ "$_rem" = "[$G_BRANCH]" ]; then
	    		G_BRANCH_LIST="$G_BRANCH_LIST$COLOR_GITBRANCH >${_rem}<"
	    	else
		    	if (($_sw == 1)); then
		    		G_BRANCH_LIST="$G_BRANCH_LIST$COLOR_GITBRANCH_L1 $_rem"
		    		_sw=0
		    	else
		    		G_BRANCH_LIST="$G_BRANCH_LIST$COLOR_GITBRANCH_L2 $_rem"
		    		_sw=1
		    	fi
	    	fi
	    done;
        printf " : $COLOR_DIVIDER{$G_BRANCH_LIST$G_REMOTES $COLOR_DIVIDER}"
    fi
}

VENV_CMD() {
    if [ -n "$VIRTUAL_ENV" ]; then
        printf " : ${COLOR_VENV}$(basename "$VIRTUAL_ENV")${COLOR_DIVIDER}"
    fi
}

# Path command to show different colors based on the exit status
PATH_CMD() {
    if [ $BASH_PROMPT__etc_bash_bashrc__last_exit_code__ -eq 0 ]; then
        printf "${COLOR_PATH_OK}"
    else
        printf "${COLOR_PATH_ERR}"
    fi
}

# Graphical Session detection
XDG_TYPE() {
	if [ -n "$XDG_SESSION_TYPE" ]; then
		__col="$COLOR_GUI"
		case "$XDG_SESSION_TYPE" in
			wayland)
				__col="$COLOR_GUI_WAYLAND" ;;
			x11)
				__col="$COLOR_GUI_X11" ;;
		esac
		printf "$COLOR_GUI//$__col$XDG_SESSION_TYPE$COLOR_DIVIDER";
	fi
}

# User ID symbol function
UID_SYM_CMD="$(if [ "${EUID}" -ne 0 ]; then echo "\[${COLOR_UID_SYM_OK}\]\$"; else echo "\[${COLOR_UID_SYM_WARN}\]#"; fi)"

# Set PS1 with functions and color codes
PS1="${COLOR_DIVIDER}\342\224\214\342\224\200[\$(export BASH_PROMPT__etc_bash_bashrc__last_exit_code__=\$?; EXIT_CODE_CMD)]\[${COLOR_DIVIDER}\]\342\224\200[\[${COLOR_USERNAME}\]\u\[${COLOR_USERHOSTAT}\]@\[${COLOR_HOSTNAME}\]\h\$(XDG_TYPE)\[${COLOR_DIVIDER}]\]${debian_chroot}\342\224\200<\$(PATH_CMD)\w\[${COLOR_DIVIDER}\]\$(GBR_CMD)\$(VENV_CMD)>\n\[${COLOR_DIVIDER}\]\342\224\224\342\225\274 ${UID_SYM_CMD} \[${COLOR_NONE}\]"

export PS2="${COLOR_DIVIDER}-+ ${COLOR_GREEN}> ${COLOR_NONE}"

# Export the prompt commands
export -f EXIT_CODE_CMD GBR_CMD VENV_CMD PATH_CMD XDG_TYPE

### for valgrind
# export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
###

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
