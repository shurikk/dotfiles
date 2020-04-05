function set-prompt() {
  emulate -L zsh

  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git_branch=${git_branch//\%/%%}  # escape '%'

  local _git="%B%F{13}${git_branch}%f%b"
  local _k8s=$(kubectl config get-contexts | grep "^*" | awk '{ print $2,"/",$5 }')
  local _cwd="%B%F{33}${PWD}%f%b"
  local _status='%F{green}%n%f%F{cyan}@%m%f %B%F{%(?.green.red)}$%f%b '

  if [ ! -z "$_k8s" ]; then
    _k8s="%B%F{13}${_k8s}%f%b"
  fi

  PROMPT="%Bgit:%b "$_git$'\n'"%Bk8s:%b "$_k8s$'\n'$_cwd$'\n'$_status
}

setopt noprompt{bang,subst} prompt{cr,percent,sp}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

bindkey -e

. /usr/local/etc/profile.d/z.sh
. /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export CLICOLOR=1
export EDITOR=vim
export PATH=~/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:$PATH
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit && compinit -i
fi

eval "$(rbenv init -)"
eval "$(pyenv init -)"

