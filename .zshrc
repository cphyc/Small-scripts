ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="af-magic"
ZSH_THEME="agnoster"

# Some usefull exports
export HPATH='~/.bin'
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cof='ssh cof@129.199.134.209'
alias op='xdg-open'
alias p2='python2'q
alias ip2='ipython2'
alias p3='python3'
alias ip3='ipython3'
alias gadd='git add'
alias grm='git rm'
alias gco='git commit'
alias up='yaourt -Syua'
alias ins='yaourt -S'
alias gpu='git push'
alias gch='git checkout'
alias gdi='git diff'
alias grep='grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'
alias coffeetags='/home/ccc/.gem/ruby/2.2.0/bin/coffeetags'
function gitlogwatch() {
    prefix=$(git rev-parse --show-cdup)
    git_path=$prefix.git/
    nline=$(tput lines)

    clear
    git --no-pager lg | head -n $nline
    inotifywait -m -q -r -e modify -e create -e close_write -e attrib $git_path |
        while read; do
            clear
            nline=$(tput lines)
            git --no-pager lg | head -n $nline
        done
}

EDITOR='emacs -nw -Q'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
#DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sudo archlinux battery cp colored-man git-extras pip web_search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PYTHONDOCS=/usr/share/doc/python2/html/
export PYMACS_PYTHON=python2

function irc() {
    PORT=4321
    jobs &>/dev/null
    sh ~/.bin/rnotify.tcl $PORT &
    new_job_started="$(jobs)"
    if [ -n "$new_job_started" ];then
	PID=$!
    else
	PID=
    fi
    echo $PID
    ssh -t -R $(echo $PORT):localhost:$PORT serv screen -x i1;2802;0crc
    kill $PID
}

#Gestion du keyring
SSH_AUTH_SOCK=`ss -xl | grep -o '/run/user/1000/keyring/ssh'`
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi


# Coloration syntaxique dans less
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '


# Support touche
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]='^[[1~'
key[End]='^[[4~'
key[Delete]=

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


function emacs {
    if [[ $# -eq 0 ]]; then
        /usr/bin/emacs # "emacs" is function, will cause recursion
        return
    fi
    args=($*)
    for ((i=0; i <= ${#args}; i++)); do
        local a=${args[i]}
      # NOTE: -c for creating new frame
        if [[ ${a:0:1} == '-' && ${a} != '-c' ]]; then
            /usr/bin/emacs ${args[*]}
            return
        fi
    done
    setsid emacsclient -n -a /usr/bin/emacs ${args[*]}
}

export EDITOR="/usr/bin/emacsclient"
export GIT_EDITOR="/usr/bin/emacsclient"
export GTAGSLIBPATH=$HOME/.gtags/
alias addon-sdk="cd /opt/addon-sdk  && source bin/activate; cd -"
