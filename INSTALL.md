# Install steps

```bash
# Install bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#Install brew packages
brew install zsh youtube-dl wakeonlan rclone pnpm imagemagick ghostscript git tmux htop trash postgresql@15 node

#Switch to zsh
chsh -s /bin/zsh

# Install brew GUI apps
brew install --cask bluesnooze keepingyouawake localsend gimp syntax-highlight the-unarchiver visual-studio-code transmission spotify rectangle macdroid iina google-chrome android-studio iterm2 mullvadvpn

# Install micromamba 
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
```


## .dotfiles

### .zshrc

```bash
setopt promptsubst
PROMPT='%(?.%F{green}.%F{red})•%f '
RPS1='%F{252}${(D)PWD:h}/%f%B%F{220}%1d%b%f'

# Aliases
###################
alias l='ls -G -phlgo'
alias ls='ls -G -phl'
alias ...='cd ../..'
alias ..='cd ..'
alias c='cd '
alias ipy='ipython '
alias n='nano '
alias py='python '
alias q='exit'
if ! command -v mamba &>/dev/null; then
  alias mamba='micromamba'
fi


# Python
###################
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mfr/mamba/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mfr/mamba/etc/profile.d/conda.sh" ]; then
        . "/Users/mfr/mamba/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mfr/mamba/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/mfr/mamba/etc/profile.d/mamba.sh" ]; then
    . "/Users/mfr/mamba/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

mamba activate basic
export PYTHONBREAKPOINT=ipdb.set_trace


# Node
###################
export PNPM_HOME="/Users/mfr/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export WASMER_DIR="/Users/mfr/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# Ruby
###################
source $HOME/.cargo/env
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.3.5

# Dart / Flutter
###################
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH=$HOME/.local/flutter/bin:$PATH

# Other imports
###################
# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Postgres
export PATH="/usr/local/opt/libpq/bin:$PATH"
```
