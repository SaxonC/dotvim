# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR=$(which vim)

#PYTHONSTARTUP=~/.pythonrc.py
#export PYTHONSTARTUP

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias vi='vim'
alias gvim='gvim -f'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


bash_prompt_command() {
# How many characters of the $PWD should be kept
local pwdmaxlen=25
# Indicate that there has been dir truncation
local trunc_symbol=".."
#shell expands WORD as filename and remove longest matching pattern
local dir=${PWD##*/}
#${#string}, expr length $string
pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
NEW_PWD=${PWD/#$HOME/\~}
local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
if [ ${pwdoffset} -gt "0" ]
then
NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
fi
}
bash_prompt() {
case $TERM in
xterm*|rxvt*)
local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
;;
*)
local TITLEBAR=""
;;
esac
local NONE="\[\033[0m\]"
# unsets color to term's fg color
# regular colors
local K="\[\033[0;30m\]"
local R="\[\033[0;31m\]"
local G="\[\033[0;32m\]"
local Y="\[\033[0;33m\]"
local B="\[\033[0;34m\]"
local M="\[\033[0;35m\]"
local C="\[\033[0;36m\]"
local W="\[\033[0;37m\]"
# emphasized (bolded) colors
local EMK="\[\033[1;30m\]"
local EMR="\[\033[1;31m\]"
local EMG="\[\033[1;32m\]"
local EMY="\[\033[1;33m\]"
local EMB="\[\033[1;34m\]"
local EMM="\[\033[1;35m\]"
local EMC="\[\033[1;36m\]"
local EMW="\[\033[1;37m\]"

# background colors
local BGK="\[\033[40m\]"
local BGR="\[\033[41m\]"
local BGG="\[\033[42m\]"
local BGY="\[\033[43m\]"
local BGB="\[\033[44m\]"
local BGM="\[\033[45m\]"
local BGC="\[\033[46m\]"
local BGW="\[\033[47m\]"
local UC=$W
[ $UID -eq "0" ] && UC=$R
# user's color
# root's color
PS1="$TITLEBAR ${EMK}[${EMM}\u${EMK}@${EMM}\h${EMB} \${NEW_PWD}${EMK}]\
\$(if [[ \$? == 0 ]]; then echo \"${G}(\342\234\223)\\$\"; else echo \
\"${R}(\342\234\227)\\$\"; fi) ${NONE}"
# without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
# extra backslash in front of \$ to make bash colorize the prompt
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# init it by setting PROMPT_COMMAND
PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

if [ "$TERM" != "xterm-256color" ]; then
    local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

    if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then

        case "$TERM" in
            'xterm') TERM=xterm-256color;;
            'screen') TERM=screen-256color;;
            'Eterm') TERM=Eterm-256color;;
        esac
        export TERM

        if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
            TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
            export TERMCAP
        fi
    fi
unset local256
fi
#source /usr/bin/virtualenvwrapper.sh

if [ -n "$WINDOWID" ]; then
    TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 90 / 100)))
    xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
fi

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

