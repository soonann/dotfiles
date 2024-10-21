# ls
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# check if you're in a tmux pane
#if [[ -n $TMUX_SESS_ROOT ]]; then

  ## overwrite the cd cmd without args to bring you to the session's root dir
  #function cd(){
    #if [[ -z "$1" ]]; then
      #echo "$1"
      #builtin cd $TMUX_SESS_ROOT
    #else
      #builtin cd $1
    #fi
  #}

#fi

alias ll='ls --group-directories-first -ahlF'
alias info="info --vi-keys"

# nvim select
alias nvim-select='select config in nvim nvim-v2; do echo "NVIM_APPNAME=$config" > ~/.nvim-active-conf; break; done; source ~/.nvim-active-conf'
alias nvim='NVIM_APPNAME=$NVIM_APPNAME nvim'
alias vim='NVIM_APPNAME=$NVIM_APPNAME nvim'

# tmux
alias t='tmux attach || tmux'
alias pf='tmux new tmux-sessionizer'
alias ff='cd $(fd -d 5 | fzf)'

# containers
alias k='kubectl'
alias dc='docker compose'
alias tf='terraform'
alias r='ranger'
alias yz='yazi'

# xclip
alias xclip='xclip -selection clipboard'

# shutdown in 120
alias sleepy='shutdown "30"'
alias shit='shutdown now'

# source espidf
alias getidf='. /home/soonann/esp-idf/export.sh'

# source zephyr
alias getzephyr='. /home/soonann/zephyrproject/.venv/bin/activate'

# sway
#alias sway='sway --unsupported-gpu'
