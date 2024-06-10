
# The following lines were added by compinstall

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle :compinstall filename '/home/simon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install


# Aliases for some common commands (don't forget to add its 'old' counterpart):
alias ls='eza --icons'
alias lsold='ls'
alias cd='z'
alias cdold='cd'
alias org='cd ~/org && ec .'
alias ec='emacsclient -r -a "emacs"'
alias ect='emacsclient -nw'
alias icat='kitten icat'
alias kdiff='kitten diff'
alias gitg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias gita="git add"
alias gitc="git commit -m"
alias gits="git status"
alias gitp="git push"

TERM=xterm-color; export TERM

# Visual and editor variables:
export EDITOR='nvim'
export BROWSER='firefox'

# starship prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export PATH="$PATH:/home/simon/.local/bin"
export PATH="$PATH:/home/simon/bin"

# Zoxide "init"
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(direnv hook zsh)"
#
# # poetry completion
fpath+=~/.zfunc
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
