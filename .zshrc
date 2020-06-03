# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/andrew/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="wezm+"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=2

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitfast common-aliases wd vi-mode ubuntu npm sudo fzf grunt colored-man-pages tmux tmuxinator ng)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

###
### ALIASES
###

alias ls="exa"
alias la="exa -la"

#alias -g C=" | tee /dev/clipboard"
alias -g C=" | clip.exe"
alias P="cat /dev/clipboard | tee "
alias -g D=" && l"
alias -g S=" | sort"
alias -g T=" | tee"

alias t="tree -I \"node_modules|bin|obj|packages\""
alias td="t -d"

alias watch="watch -d -n1"
alias cat="bat"

alias weather="ansiweather -a false -l Aurora Canada"

alias tmux-airline="~/tmux-airline.sh"

alias gs="git status"

alias sgrepi='sgrep -i'
alias sgrepp='sgrep -I --exclude-dir={node_modules,bin,obj} --exclude="*.min.*" --exclude="*.xml"'

alias -g LC=" | lolcat"

alias gbD="git branch -D"
alias gpod="git push origin --delete"
alias gai="git add --interactive"
alias gap="git add -p"
alias gsn="git shortlog -sn"
alias gfal="gfa; gl"

alias  ag='ag --path-to-ignore ~/.agignore'

alias scripts='jq ".scripts" package.json'

alias vim=nvim
VISUAL=vi

alias docker="docker.exe"

###
### FUNCTIONS
###

function cdl() {
  cd $1 && la
}

function mcd() {
  mkdir $1 && cd $1
}

function gcc() {
  git checkout -- $1 && git clean -xfd $1 && git status
}

function gscp() {
  git stash && git checkout $1 && git stash pop
}

function db() {
  docker exec -it $1 bash
}

function kill-sessions() {
  tmux list-sessions | grep -E -v '\(attached\)$' | while IFS='\n' read line; do
    tmux kill-session -t "${line%%:*}"
  done
}

###
### IMPORTS
###

if [[ $TERMINIX_ID ]]; then
  source /etc/profile.d/vte.sh
fi

source ~/.config/up/up.sh
source ~/.tmux.zshrc.sh

###
### ANTIGEN
###

source ~/antigen.zsh
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

###
### FZF
###
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

###
### NVM
###
function loadnvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# ignore fzf history duplicates
setopt HIST_IGNORE_ALL_DUPS

# setup some nicer colors for directory listing/completion
eval `dircolors ~/Git/dircolors-solarized/dircolors.256dark`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

neofetch
