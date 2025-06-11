## GIT

# View Git status (short).
alias gs='git status -s'

# Add a file to Git.
alias ga='git add'

# Add all files to Git.
alias gaa='git add --all'

# Commit changes to the code.
alias gc='git commit'

# View the Git log.
alias gl='git log --oneline --reverse'

# Create a new Git branch and move to the new branch at the same time.
alias gb='git checkout -b'

# View the difference.
alias gd='git diff'

# View the difference.
alias gp='git pull --no-commit --stat'

## CD ..

# Move to the parent folder.
alias ..='cd ..;pwd'

# Move up two parent folders.
alias ...='cd ../..;pwd'

# Move up three parent folders.
alias ....='cd ../../..;pwd'


# Display the directory structure better.
alias tree='tree --dirsfirst -F -a -h -u -g'

# Make a directory and all parent directories with verbosity.
alias mkdir='mkdir -pv'

alias ll='ls --color=auto -alshp'

alias lls='sudo ls --color=auto -alshp'

# Customized less
alias less="less -N --use-color --line-num-width=4"

# debian_settings {

# Edit ubuntu sources.list config
alias urepo="sudo vim /etc/apt/sources.list.d/ubuntu.list"

# Upgrade the system
alias aptuu="sudo apt update && sudo apt upgrade"

# List manually installed packages
alias ipkgs="apt-mark showmanual"

# List all installed packages
alias pkgs="apt list --installed"

# Always run apt as superuser
alias apt="sudo apt"

# Debian chroot
function debchroot
{
  arch-chroot ${@}
}
function debchroot_s
{
  sudo arch-chroot ${@}
}

# } // debian_settings

# View the calender by typing the first three letters of the month.

alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'

## FUNCTIONS

function largestfiles() {
  du -h -x -s -- * | sort -r -h | head -20
}

function mkcd() {
  mkdir -p -v "$1";
  cd "$1"
}

function cdev() {
  mkdir -p -v ~/dev;
  cd ~/dev;
}

function purge_list() {
  sudo apt purge $(cat $@);
  sudo rm $@;
}
