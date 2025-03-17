# flameshot env
# export SDL_VIDEODRIVE=wayland
# export _JAVA_AWT_WM_NONREPARENTING=1
# export QT_QPA_PLATFORM=wayland
# export XDG_CURRENT_DESKTOP=sway
# export XDG_SESSION_DESKTOP=sway

# # keyring setup
# if [ -n "${WAYLAND_DISPLAY}" ] && \
#    [ ! -n "${SSH_AUTH_SOCK}" ] && \
#    [ -r "/run/user/${ID}/keyring/ssh" ]; then
#     export SSH_AUTH_SOCK="/run/user/${ID}/keyring/ssh"
# fi

# if [ -n "${WAYLAND_DISPLAY}" ] && \
#    [ ! -n "${GPG_AGENT_INFO}" ] && \
#    [ -r "/run/user/${ID}/keyring/gpg" ]; then
#     export GPG_AGENT_INFO="/run/user/${ID}/keyring/gpg:0:1"
# fi
