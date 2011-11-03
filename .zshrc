# Lines configured by zsh-newuser-install
source /etc/profile

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/yorirou/.zshrc'

autoload -Uz compinit
compinit -C
# End of lines added by compinstall

unsetopt BG_NICE    # do NOT nice bg commands
setopt CORRECT      # command CORRECTION

setopt MENUCOMPLETE
setopt ALL_EXPORT

setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
setopt printexitvalue
setopt listtypes
setopt autolist
unsetopt menucomplete
unsetopt beep notify

# Autoload zsh modules when they are referenced
#zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

HOSTNAME="`hostname`"
PAGER='less'
EDITOR='/usr/bin/vim'
autoload colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done


unsetopt ALL_EXPORT

# dircolors
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# my old bash aliases
alias ll='ls -lha'
alias l='ls'
alias ssh='ssh -C'
alias mysql='mysql5 -u root'
alias z='7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias webserv='python -m SimpleHTTPServer'
alias gsci='git svn fetch && git svn rebase && git svn dcommit'
alias gsup='git svn fetch && git svn rebase'
alias gap='git add -p'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gcaa='git commit -a --amend'
alias gstat='git status'
alias gdiff='git diff'
alias gdiffc='git diff --cached'
alias gsom='git push origin master'
alias glom='git pull origin master'
alias gso='git push origin'
alias glo='git pull origin'
alias gsync='git pull origin && git push origin'
alias gsyncm='git pull origin master && git push origin master'
alias gpp='git pull && git push'
alias ack='ack-grep'
alias up='sudo aptitude update && sudo aptitude full-upgrade'
alias pdfmerge='gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=output.pdf'
alias drush='~/prog/php/drush/drush'
alias drupal-user-reset='drush php-eval "user_save(user_load(1), array(\"pass\" => \"a\"));"'
alias p='sudo port'
alias ps='port search'
alias pi='sudo port install'
alias pup='sudo port selfupdate && sudo port upgrade outdated'
alias g='git'
alias gcas='git commit -a -m "Updates submodules."'

PATH="/Users/yorirou/bin:/Users/yorirou/.programs/go/bin:/opt/local/bin:/opt/local/sbin:/opt/local/apache2/bin:/opt/local/lib/postgresql90/bin:${PATH}:/sbin:/usr/sbin:/Users/yorirou/Library/Haskell/bin"
export GOROOT="$HOME/.programs/go"
export GOOS="darwin"
export GOARCH="amd64"

# new awesome zsh aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'

# suffix aliases
alias -s exe=wine
alias -s EXE=wine
alias -s module=vim
alias -s info=vim
alias -s php=vim
alias -s inc=vim
alias -s txt=vim
alias -s py=vim
alias -s rb=vim
alias -s go=vim
alias -s hs=vim
alias -s lhs=vim
alias -s c=vim
alias -s h=vim
alias -s cpp=vim
alias -s hpp=vim

# LOLALIAS
alias wtf='dmesg'
alias onoz='cat /var/log/errors.log'
alias rtfm='man'

alias visible='echo'
alias invisible='cat'
alias moar='more'

alias icanhas='mkdir'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'

alias hai='cd'
alias plz='pwd'

alias inur='locate'

alias nomz='ps -aux'
alias nomnom='killall'

alias cya='reboot'
alias kthxbai='halt'

# directory aliases
hash -d pf="/Users/yorirou/.wine/drive_c/Program Files"

# awesome zsh modules
autoload zmv
zmodload zsh/net/socket

# some handy options
setopt no_hup hist_verify


# correcting some keys
autoload zkbd
#[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
#source ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
source ~/.zkbd/xterm-mac
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
#[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# completion stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#zstyle ':completion:*' menu yes select
xdvi() { command xdvi ${*:-*.dvi(om[1])} }
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-sort 'time'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

zstyle ':completion:*' completer \
    _oldlist _expand _force_rehash _complete

compctl -/ cd

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
      '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'

PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_GREEN%n@%m%u$PR_NO_COLOR:$PR_BLUE%~$PR_NO_COLOR%% "
PROMPT="%{$PR_GREEN%}%n@%m%u%{$PR_NO_COLOR%}:%{$PR_BLUE%}%~%{$reset_color%}%% "

case $TERM in 
  screen*) 
    preexec () { 
      local CMD=${1[(wr)^(*=*|sudo|-*)]} 
      echo -ne "\ek$CMD\e\\" 
    } 
    chpwd() { print -Pn "\e]0;%n@%m: %~\a" } 
    print -Pn "\e]0;%n@%m: %~\a" 
    ;; 
  xterm*) 
    chpwd() { print -Pn "\e]0;%n@%m: %~\a" } 
    print -Pn "\e]0;%n@%m: %~\a" 
    ;; 
esac

# go support
source $GOROOT/misc/zsh/go
