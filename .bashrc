# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Define Editor
export EDITOR=nvim

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza --icons'
alias ll='eza -al --icons'
alias tree='eza -a --tree --level=1 --icons'
alias tree3='eza -a --tree --level=3 --icons'
alias tree6='eza -a --tree --level=6 --icons'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/dotfiles/scripts/snapshot.sh'
alias wifi='nmtui'
alias dot="cd ~/dotfiles"
alias cleanup='~/dotfiles/scripts/cleanup.sh'
alias keybind="v ~/.config/hypr/hyprland/keybinds.conf"
alias nouveau="source ~/bin/nouveau.sh"
alias ebash="nvim ~/.bashrc"
alias gs="git status"
alias pacman="sudo pacman"
alias envOn="source ./env/bin/activate"
# -----------------------------------------------------
# SCRIPTS
# -----------------------------------------------------
alias ascii='~/dotfiles/scripts/figlet.sh'

# -----------------------------------------------------
# SYSTEM
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias update='yay -Syu; yay -Yc'
# --------------------
# LOAD CUSTOM .bashrc_custom
# -----------------------------------------------------
if [ -f ~/.bashrc_custom ] ;then
    source ~/.bashrc_custom
fi

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
eval "$(starship init bash)"

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
cat ~/.cache/wal/sequences

fastfetch --config examples/15
echo ""
