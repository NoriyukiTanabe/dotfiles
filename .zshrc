export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home

# ZSH

export SAVEHIST=1000000 # 履歴ファイルに保存される履歴の件数
setopt share_history # 同時に起動しているzshの間でhistoryを共有する

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source /Users/tanabe.noriyuki/.rvm/scripts/rvm

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# 補完機能で表示される候補を選択状態に応じてハイライト
zstyle ':completion:*' menu select

# zsh-git-prompt 重い
# source "/usr/local/opt/zsh-git-prompt/zshrc.sh"

# original git functions

# Dirty Git State in Your Prompt 
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# Prompt 
autoload -Uz vcs_info
setopt prompt_subst # プロンプトが表示されるたびにプロンプト文字列を評価、置換
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red}*"
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{green}[%b]%c%u%m%f"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='?'
  fi
}

# %~ カレントディレクトリ（絶対パス）
# %# ユーザー識別子（root: #, root以外: %）
# PROMPT="%~$(parse_git_branch)$(parse_git_dirty) %# "
PROMPT='%~${vcs_info_msg_0_} %# '

##################
export EDITOR=vim
eval "$(direnv hook zsh)"
