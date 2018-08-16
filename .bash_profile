# make .bash_profile same as .bashrc
echo ".bash_profile"
echo "HOME = ${HOME}"
if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi
