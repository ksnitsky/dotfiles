# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export GOOGLE_CLOUD_PROJECT=AIzaSyAdObP0O2p7p-4VuVIkecVKikyEI4ATb9I
export PATH=/home/ks/.cache/rebar3/bin:$PATH

alias nv=nvim
alias lg=lazygit
eval "$(/home/ks/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"

# bun completions
[ -s "/home/ks/.bun/_bun" ] && source "/home/ks/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
unsetopt correct_all
