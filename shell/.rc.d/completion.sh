# minikube completion
. <(minikube completion bash)

# k8s completion
. <(kubectl completion bash)

# helm completion
. <(helm completion bash)

# tilt completion
. <(tilt completion bash)

# telepresence completion
. <(telepresence completion bash)


# k6s completion
. <(k6 completion bash)

# dagger completion
. <(dagger completion bash)


# fzf completion/keybindings
# find fzf installation location
FZF_DIR=$(readlink -e $(type -p fzf) | sed -e 's/\/bin\/fzf/\/share\/fzf/g')
. $FZF_DIR/completion.bash
. $FZF_DIR/key-bindings.bash


