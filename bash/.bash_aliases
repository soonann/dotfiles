# ls
alias ll='ls -alhF --color=auto'

# tmux
alias ta='tmux a'
alias t='tmux'
alias pf='tmux new tmux-sessionizer'
alias ff='cd $(find . -type d | fzf)'

# docker/k8s/terraform/ansible
alias k='kubectl'
alias dc='docker compose'
alias mk='minikube'
alias tf='terraform'

# python
alias venv='python3 -m venv'

# java
alias gradle='./gradlew'
alias mvn='./mvnw'

# xclip
alias xclip='xclip -selection clipboard'
