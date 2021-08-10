
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source /Users/tanabe.noriyuki/.rvm/scripts/rvm

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# zsh-git-prompt 重い
# source "/usr/local/opt/zsh-git-prompt/zshrc.sh"

# Prompt 
autoload -Uz vcs_info
setopt prompt_subst # プロンプトが表示されるたびにプロンプト文字列を評価、置換
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red}!"
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
