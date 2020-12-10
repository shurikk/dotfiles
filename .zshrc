function set-prompt() {
  emulate -L zsh

  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git_branch=${git_branch//\%/%%}  # escape '%'

  local _git="%B%F{13}${git_branch}%f%b"
  local _k8s=$(kubectl config get-contexts | grep "^*" | awk '{ print $2,"/",$5 }')
  local _proxy=""
  local _gw=$(dgw)
  local _venv=""
  local _cwd="%B%F{33}${PWD}%f%b"
  local _status='%F{green}%n%f%F{cyan}@%m%f %B%F{%(?.green.red)}$%f%b '

  if [ ! -z "$_k8s" ]; then
    _k8s="%B%F{13}${_k8s}%f%b"
  fi

  if [ ! -z "$HTTPS_PROXY" ]; then
    _proxy="%Bproxy:%b %B%F{13}${HTTPS_PROXY}%f%b"$'\n'
  fi

  if [ ! -z "$VIRTUAL_ENV" ]; then
    [ ${PS1[1]} = "(" ] && export VIRTUAL_ENV_NAME=${PS1[(w)1]}
    _venv="%Benv:%b %B%F{13}${VIRTUAL_ENV_NAME}%f%b"$'\n'
  else
    unset VIRTUAL_ENV_NAME
  fi

  PROMPT="%Bdgw:%b "$_gw$'\n'"%Bgit:%b "$_git$'\n'"%Bk8s:%b "$_k8s$'\n'$_proxy$_venv$_cwd$'\n'$_status
}

alias dgw="route -n get default | grep gateway | cut -d\  -f6"
alias full_vpn_on="dgw > ~/.default_gateway && sudo route change -ifscope en0 default \$(ifconfig gpd0 | grep 'inet ' | cut -d\  -f2)"
alias full_vpn_off="sudo route change -ifscope en0 default \$(cat ~/.default_gateway)"
alias tunnel_on="ssh -fND 8888 desktop"
alias tunnel_off="pkill -f '8888 desktop'"
alias proxy_on="export HTTPS_PROXY=socks5://127.0.0.1:8888"
alias proxy_off="unset HTTPS_PROXY"
alias myip="curl https://ifconfig.co"

setopt noprompt{bang,subst} prompt{cr,percent,sp}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

bindkey -e

. /usr/local/etc/profile.d/z.sh
. /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export CLICOLOR=1
export EDITOR=vim
export PATH=~/.rbenv/shims:~/go/bin:/usr/local/bin:/usr/bin:/bin:$PATH
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit && compinit -i
fi

autoload -U +X bashcompinit && bashcompinit
. /usr/local/etc/bash_completion.d/az

type rbenv &> /dev/null && eval "$(rbenv init -)"
type pyenv &> /dev/null && eval "$(pyenv init -)"

echo -n
