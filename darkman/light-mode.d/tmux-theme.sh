sed -i --follow-symlinks 's/set -g @rose_pine_variant '\''main'\''/set -g @rose_pine_variant '\''dawn'\''/' ~/.tmux.conf
tmux source-file ~/.tmux.conf
