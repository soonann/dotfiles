# ls
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alhF --color=auto'

# tmux
alias t='tmux attach || tmux'
alias pf='tmux new tmux-sessionizer'
alias ff='find-files'

# containers
alias k='kubectl'
alias dc='docker compose'
alias mk='minikube'
alias tf='terraform'

# python
alias venv='python3 -m venv'
alias ansible='python3 -m ansible'

# java
alias gradle='./gradlew'
alias mvn='./mvnw'

# xclip
alias xclip='xclip -selection clipboard'

# shutdown in 120
alias sleepy='sudo shutdown "120"'
