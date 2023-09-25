# get the user id 
ID=$(id -u)

# keyring setup
#if [ -n "${WAYLAND_DISPLAY}" ] && \
   #[ ! -n "${SSH_AUTH_SOCK}" ] && \
   #[ -r "/run/user/${ID}/keyring/ssh" ]; then
    #export SSH_AUTH_SOCK="/run/user/${ID}/keyring/ssh"
#fi

#if [ -n "${WAYLAND_DISPLAY}" ] && \
   #[ ! -n "${GPG_AGENT_INFO}" ] && \
   #[ -r "/run/user/${ID}/keyring/gpg" ]; then
    #export GPG_AGENT_INFO="/run/user/${ID}/keyring/gpg:0:1"
#fi

# fzf theme option
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# XDG DATA DIR
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"

# flatpak binaries
export PATH="$PATH:/var/lib/flatpak/exports/bin"

# .local
export PATH="$PATH:/home/ann/.local/bin"

# flyctl
export FLYCTL_INSTALL="$HOME/.fly" 
export PATH="$PATH:$FLYCTL_INSTALL/bin"

# gcloud cli
#source /opt/google-cloud-sdk/completion.bash.inc 
#source /opt/google-cloud-sdk/path.bash.inc 
export PATH="$PATH:/opt/google-cloud-sdk/bin" 

# add Pulumi to the PATH
export PATH="$PATH:$HOME/.pulumi/bin"

# /opt
export PATH="$PATH:/opt/flutter/bin" # flutter
export PATH="$PATH:/opt/jdtls/bin" # jdtls
export PATH="$PATH:/opt/nvim-linux64/bin"

# cargo
export PATH="$PATH:$HOME/.cargo/bin" 

# golang 
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# android/java
export ANDROID_HOME="$HOME/Android/Sdk" 
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64" 
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/opt/android-studio/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/Android/Sdk/emulator"

# arduino nano
export PATH="$PATH:~/.npm-global/bin"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

# clang
export PATH="$PATH:~/.local/share/nvim/mason/bin"

# chrome/brave
export CHROME_EXECUTABLE="/var/lib/flatpak/exports/bin/com.brave.Browser" 

# docker/compose/kube
# export COMPOSE_PROFILES=web,kafka
export KUBECONFIG="/home/soonann/.kube/config"

# nix tmp 
export NIXPKGS_ALLOW_UNFREE=1
