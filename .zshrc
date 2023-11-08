export GOPATH="$HOME/prog/go"
export GOBIN="$HOME/prog/go/bin"
export GOROOT="$HOME/.programs/go"
export GOOS="linux"
export GOARCH="amd64"
export NPM_PACKAGES="${HOME}/.npm-packages"
export LD_LIBRARY_PATH="$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.programs/go/bin:$HOME/prog/go/bin:$HOME/.cargo/bin:$HOME/.gem/bin:/snap/bin:$NPM_PACKAGES/bin:$PATH"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export COMPOSER_MIRROR_PATH_REPOS=1
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(cabal docker-compose docker git rebar golang rust sudo systemd tmux ubuntu vagrant web-search gpg-agent task)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
alias webserv='python -m SimpleHTTPServer'
alias gsci='git svn fetch && git svn rebase && git svn dcommit'
alias gsup='git svn fetch && git svn rebase'
alias gap='git add -p'
alias gc='git commit -S -m'
alias gca='git commit -S -a -m'
alias gcaa='git commit -S -a --amend'
alias gstat='git status'
alias gdiff='git diff'
alias gdiffc='git diff --cached'
alias gsom='git push origin master'
alias glom='git pull origin master'
alias gso='git push origin'
alias glo='git pull origin'
alias gpa='git push --all'
alias gsync='git pull origin && git push origin'
alias gsyncm='git pull origin master && git push origin master'
alias gpp='git pull && git push'
alias up='sudo aptitude update && sudo aptitude full-upgrade'
alias pdfmerge='gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=output.pdf'
alias drupal-user-reset='drush php-eval "user_save(user_load(1), array(\"pass\" => \"a\"));"'
alias g='git'
alias gcas='git commit -a -m "Updates submodules."'
alias startftp='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias c='xclip -selection c'
alias v='xclip -selection clipboard -o'
alias go-fmt='for i in `find . -name \*.go`; do go fmt $i; done'
alias gt='go test -v ./...'
alias gocover='go test -coverprofile=c.out ./... && go tool cover -html=c.out && rm c.out'
alias closure="java -jar /Users/yorirou/.programs/closure-compiler.jar"
alias pw='pwgen $((RANDOM%32+6)) 1'
alias ack='ack-5.12'
alias tmux='tmux -u'
alias fuck='sudo $(fc -ln -1)'
alias e=$EDITOR
alias cg='cargo'
alias drupal_fuck_you_config='for i in `ls -1 | sed -e "s/\.yml$//"`; do drush config-delete $i; done'
alias mr_test='./scripts/phpunit-wrapper.sh web/modules/drupal_module/tests'
alias btm='git checkout master && git pull --no-verify-signatures origin master && git branch --merged | grep -v master | xargs git branch -d'
alias pp='playerctl play-pause'

alias -s jar='java -jar'
alias -s coverprofile='go tool cover -html'

alias dir='ls'
alias cd..='cd ..'

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

# start tmux
tmux has &>/dev/null || systemd-run --scope --user tmux start \; new-session -d 'sleep 5'

eval `dircolors $HOME/.dir_colors/dircolors`

# opam configuration
[[ ! -r /home/tamas/.opam/opam-init/init.zsh ]] || source /home/tamas/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
