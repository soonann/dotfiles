# ls
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls --group-directories-first -ahlF'

# nvim alias as vim 
alias vim="nvim"

# tmux
alias t='tmux attach || tmux'
alias pf='tmux new tmux-sessionizer'
alias ff='cd $(fd -d 5 | fzf)'

# containers
alias k='kubectl'
alias dc='docker compose'
alias tf='terraform'
alias r='ranger'

# python
#alias venv='python3 -m venv'
alias ansible='python3 -m ansible'

# xclip
alias xclip='xclip -selection clipboard'

# shutdown in 120
alias sleepy='shutdown "120"'
alias shit='shutdown now'

# sway
#alias sway='sway --unsupported-gpu'
