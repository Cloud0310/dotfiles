gpg-connect-agent updatestartuptty /bye >/dev/null

cd() {
    if [[ -n '$1' ]]; then
        z "$@" && eza -lT -L 1 --icons=auto --color=auto
    else
        z ~ && eza -lT -L 1 --icons=auto --color=auto
    fi
}


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit wait light-mode depth"1" for \
        OMZL::clipboard.zsh \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/history-search-multi-word \
        zdharma-continuum/fast-syntax-highlighting \
        OMZP::colored-man-pages \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    as"completion" \
    has"docker" \
        OMZP::docker/completions/_docker \
    as"completion" \
    has"docker-compose" \
        OMZP::docker-compose/_docker-compose

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice as"command" from"gh-r"\
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

zinit ice as"program" from"gh-r" \
    mv"bat-* -> bat" pick"bat/autocomplete/bat.zsh"
zinit light sharkdp/bat

zinit ice as"program" from"gh-r"
zinit light eza-community/eza

if [[ -f /etc/debian_version ]]; then
    if ! command -v aptitude &> /dev/null; then
        echo "aptitude is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y aptitude
    fi
    apt_pref='aptitude'
    apt_upgr='safe-upgrade'

    zinit ice wait has"aptitude"
    zinit snippet OMZP::debian
fi

zi ice \
    depth"1" \
    has"conda" \
    blockf \
    as"completion" \
    wait
zi light conda-incubator/conda-zsh-completion

zi ice \
    has"volta" \
    id-as"volta" \
    as"null" \
    atclone'volta completions zsh -f -o _volta' \
    atpull"%atclone" \
    wait
zi light zdharma-continuum/null

zi ice \
    has"bun" \
    id-as"bun" \
    as"null" \
    atclone'bun completions > _bun' \
    atpull"%atclone" \
    wait
zi light zdharma-continuum/null

zi ice \
    depth"1" \
    has"pnpm" \
    atload"zpcdreplay" \
    atclone"./zplug.zsh" \
    atpull"%atclone" \
    wait
zi light g-plane/pnpm-shell-completion

zi ice has"yarn" wait
zi snippet OMZP::yarn

zi ice has"git" wait
zi snippet OMZP::git

zi ice wait
zi snippet OMZP::eza

zi ice \
    has"podman" \
    id-as"podman" \
    as"null" \
    atclone'podman completion zsh -f _podman' \
    atpull"%atclone" \
    wait
zi light zdharma-continuum/null

zi ice \
    has"rye" \
    id-as"rye" \
    as"null" \
    atclone'rye self completion -s zsh > _rye' \
    atpull"%atclone" \
    wait
zi light zdharma-continuum/null

bindkey -v

# aliases
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias top='sudo btop'
alias gtop='sudo intel_gpu_top'
alias vi='nvim'
alias vim='nvim'
alias ip='ip -c'
alias aria2c='aria2c --enable-rpc=false' 
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
