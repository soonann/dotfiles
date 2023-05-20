# .local binaries
export PATH="$PATH:/home/ann/.local/bin"

# fzf
export PATH="$PATH:/opt/fzf"

# fd
export PATH="$PATH:/opt/fd-v8.7.0-x86_64-unknown-linux-gnu"

# nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

# cargo
export PATH="$PATH:$HOME/.cargo/bin"

# android studio
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export ANDROID_HOME="/home/ann/Android/Sdk"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/opt/android-studio/bin"
export PATH="$PATH:/home/ann/Android/Sdk/platform-tools"
export PATH="$PATH:/home/ann/Android/Sdk/emulator"

# jdtls
export PATH="$PATH:/opt/jdtls/bin"

# flutter
export PATH="$PATH:/opt/flutter/bin"
export CHROME_EXECUTABLE="/opt/brave.com/brave/brave-browser"

# golang
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# -- WEB
# nodejs
export PATH="$PATH:/opt/node-v19.5.0-linux-x64/bin"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# --- CLI TOOLS 
# gcloud cli
export PATH="$PATH:$HOME/.local/share/google-cloud-sdk/bin"

# flyctl
export FLYCTL_INSTALL="$HOME/ann/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# --- FLAGS
# docker compose profiles
export COMPOSE_PROFILES=web,kafka
