
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

# aliases
source $HOME/.aliases


# Visual and editor variables:
export EDITOR='nvim'
export BROWSER='firefox'

# starship prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export PATH="$PATH:/home/simon/.local/bin"
export PATH="$PATH:/home/simon/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/simon/go/bin"
export PATH=/home/simon/.cache/rebar3/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"

. "$HOME/.asdf/asdf.sh"

# Zoxide "init"
eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(direnv hook zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
#
# # poetry completion
fpath+=~/.zfunc
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/simon/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/simon/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/simon/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/simon/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
