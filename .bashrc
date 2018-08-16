
# a few command-prompt colors to choose from
BLACK="\[$(tput setaf 0)\]"
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
MAGENTA="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"
RESET="\[$(tput sgr0)\]"

# set command prompt to show current directory
export PS1="${BLUE} \w> ${RESET}"

# don't overwrite files on direction
set -o noclobber

# add colors to ls
alias ls='ls -GF'
