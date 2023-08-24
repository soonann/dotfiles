# $HOME
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export ANDROID_HOME="$HOME/Android/Sdk" # android
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64" 
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/opt/android-studio/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/Android/Sdk/emulator"
export FLYCTL_INSTALL="$HOME/.fly" # flyctl
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin" # golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# .local
export PATH="$PATH:/home/ann/.local/bin"
export DENO_INSTALL="$HOME/.deno" # deno
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/google-cloud-sdk/bin" # gcloud cli

# /opt
export PATH="$PATH:/opt/Discord" # discord
export PATH="$PATH:/opt/Telegram" # telegram
export PATH="$PATH:/opt/thunderbird" # thunderbird

export PATH="$PATH:/opt/jdtls/bin" # jdtls
export PATH="$PATH:/opt/flutter/bin" # flutter
export CHROME_EXECUTABLE="/var/lib/flatpak/exports/bin/com.brave.Browser" 
export PATH="$PATH:/opt/nvim-linux64/bin"

# flags
export COMPOSE_PROFILES=web,kafka

# flatpak
export PATH="$PATH:/var/lib/flatpak/app/com.brave.Browser/current/active/files/bin"
