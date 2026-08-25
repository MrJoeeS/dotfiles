export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="af-magic"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# TMUX
ZSH_TMUX_AUTOSTART="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat tmux)


source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:~/.cargo/bin"
export PATH="$PATH:/opt/nvim/"
export PATH="$PATH:/usr/local/go/bin"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="/home/jsawyer/.surrealdb:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export XDG_CONFIG_HOME=~/.config/
export KUBECONFIG=/etc/kubernetes/kubelet.conf
export KUBECONFIG=~/.kube/config
export LIBGL_ALWAYS_SOFTWARE=1
export ZED_ALLOW_EMULATED_GPU=1
export PATH=/home/jsawyer/.opencode/bin:$PATH


# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ca='cursor-agent'
alias wa='wassette'
alias cdr='cd $(git rev-parse --show-toplevel 2>/dev/null || echo .)'




# fpath+=("$(npm root -g)/pure-prompt")
# autoload -U promptinit; promptinit
# prompt pure

source "${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -n "$TMUX" ]]; then
    # Only run fastfetch on a brand-new tmux session (a fresh session has
    # exactly one pane). New windows/panes add panes, so it won't run then.
    if [[ "$(tmux list-panes -s 2>/dev/null | wc -l)" -eq 1 ]]; then
        fastfetch
    fi
fi
