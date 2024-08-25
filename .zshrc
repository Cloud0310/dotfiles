gpg-connect-agent updatestartuptty /bye >/dev/null

bindkey -v

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

zi ice as"command" from"gh-r"\
    atclone"./zoxide init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh" nocompile'!'
zi light ajeetdsouza/zoxide

zi ice as"program" from"gh-r" \
    mv"bat-* -> bat" pick"bat/autocomplete/bat.zsh"
zi light sharkdp/bat

zi ice as"program" from"gh-r"
zi light eza-community/eza

zi ice wait has"apt" \
    atinit"sudo apt update; sudo apt install aptitude -y" \
    atload"apt_upgr=safe-upgrade; apt_pref=aptitude" \
zi snippet OMZP::debian

zi ice \
    depth"1" \
    has"conda" \
    blockf \
    as"null" \
    wait
zi light conda-incubator/conda-zsh-completion

zi wait as"null" light-mode completions atpull"%atclone" for \
    has"volta" id-as"volta" atclone'volta completions zsh > _volta' \
        zdharma-continuum/null \
    has"bun" id-as"bun" atclone'bun completions > _bun' \
        zdharma-continuum/null \
    has"podman" id-as"podman" atclone'podman completion zsh -f _podman' \
        zdharma-continuum/null \
    has"rye" id-as"rye" atclone'rye self completion -s zsh > _rye' \
        zdharma-continuum/null

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

# aliases
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias top='sudo btop'
alias gtop='sudo intel_gpu_top'
alias vi='nvim'
alias vim='nvim'
alias ip='ip -c'
alias aria2c='aria2c --enable-rpc=false' 
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
