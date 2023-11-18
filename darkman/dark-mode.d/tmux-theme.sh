sed -i --follow-symlinks 's/set -g @rose_pine_variant '\''dawn'\''/set -g @rose_pine_variant '\''main'\''/' ~/.tmux.conf
tmux source-file ~/.tmux.conf
