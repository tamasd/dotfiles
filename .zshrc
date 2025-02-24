export GOOS="linux"
export GOARCH="amd64"
export GOAMD64="v3"
export NPM_PACKAGES="${HOME}/.npm-packages"
export LD_LIBRARY_PATH="$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$NPM_PACKAGES/bin:$PATH"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export COMPOSER_MIRROR_PATH_REPOS=1
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

if [ "$HOMEBREW_PREFIX" != "" ]; then
	export OPENSSL_DIR="$HOMEBREW_PREFIX/opt/openssl"
	if [ "$PKG_CONFIG_PATH" != "" ]; then
		export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
	else
		export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig"
	fi
	if [ "$CPATH" != "" ]; then
		export CPATH="$HOMEBREW_PREFIX/include:$CPATH"
	else
		export CPATH="$HOMEBREW_PREFIX/include"
	fi
	export XDG_DATA_DIRS="$HOMEBREW_PREFIX/share:$XDG_DATA_DIRS"
	export LD_LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LD_LIBRARY_PATH"
	export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LIBRARY_PATH"
fi

ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(cabal docker-compose docker git rebar golang rust sudo systemd tmux ubuntu vagrant web-search gpg-agent)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zaw/zaw.plugin.zsh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

bindkey '^R' zaw-history
bindkey '^B' zaw-git-branches
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search]]']]'

# NumPad fix
bindkey -s "^[Oo" "/"
bindkey -s "^[Oj" "*"
bindkey -s "^[Om" "-"
bindkey -s "^[Ok" "+"
bindkey -s "^[OM" "^M"
bindkey -s "^[On" "."
bindkey -s "^[Op" "0"
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"

# User configuration

## ENVIRONMENT VARIABLES ##
export GEM_HOME="$HOME/.gem"

# export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='nvim'

## ALIASES ##

alias ll='ls -lhaX'
alias l='ls'
alias ssh='ssh -C'
alias z='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias gap='git add -p'
alias pdfmerge='gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=output.pdf'
alias c='xclip -selection c'
alias v='xclip -selection clipboard -o'
alias gt='go test -v ./...'
alias gocover='go test -coverprofile=c.out ./... && go tool cover -html=c.out && rm c.out'
alias tmux='tmux -u'
alias e='eval $EDITOR'
alias btm='git checkout master && git pull --no-verify-signatures origin master && git branch --merged | grep -v master | xargs git branch -d'
alias pp='playerctl play-pause'
alias pg='psql -h localhost -U postgres -W -d'

alias -s jar='java -jar'
alias -s coverprofile='go tool cover -html'
alias -s md='glow -p'

alias dir='ls'
alias cd..='cd ..'

## EXTRA COMPLETIONS ##
mkdir -p $HOME/.zsh/completions
fpath=($HOME/.zsh/completions $fpath)
if [ ! -e $HOME/.zsh/completions/_just ]; then
	if type "just" > /dev/null; then
		just --completions zsh > $HOME/.zsh/completions/_just
	fi
fi

if [ ! -e $HOME/.zsh/completions/_task ]; then
	curl https://raw.githubusercontent.com/go-task/task/main/completion/zsh/_task -o $HOME/.zsh/completions/_task
fi

autoload -U compinit && compinit

function gtv () {
	git tag -m $1 -s $1
}

## COLOR SCHEME ##

if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%F{61}%n%{$reset_color%}@%{${fg[yellow]}%}%m %{${fg_bold[green]}%}:: %{$reset_color%}%{${fg[blue]}%}%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

export TERM=xterm-256color

ulimit -S -n 4096

eval `dircolors $HOME/.dir_colors`

# opam configuration
[[ ! -r /home/tamas/.opam/opam-init/init.zsh ]] || source /home/tamas/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
