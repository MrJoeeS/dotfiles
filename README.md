# dotfiles
Configs I might reuse. 

# ZSH
To keep the Zsh config in the `.config` directory, use one of these options.

## Create a Symbolic link
```bash
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```

## Use the ZDOTDIR Environment Variable
```bash
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> ~/.zshenv
```

# oh-my-zsh
Install Oh My Zsh in the directory referenced by `.zshrc`, without replacing
the existing Zsh configuration or changing the default shell:
```bash
ZSH="$HOME/.config/oh-my-zsh" \
ZDOTDIR="$HOME/.config/zsh" \
KEEP_ZSHRC=yes \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

# Powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/themes/powerlevel10k"
```
