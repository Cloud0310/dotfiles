# PATH
export PATH=$PATH:$HOME/Android/Sdk/platform-tools
export PATH=$PATH:/usr/local/go/bin

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin":$PATH

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"

# history
export HISTSIZE=20000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

export TERM=xterm-256color
export COLORFGBG="15;0"

# electron wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland

export SSH_AGENT_PID=''
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
export GPG_TTY=$(tty)

export HTTP_PROXY=http://localhost:7890
export HTTPS_PROXY=http://localhost:7890
export EDITOR=nvim

