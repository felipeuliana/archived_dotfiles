#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>

fpath=($fpath "/home/[USER]/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# kubernets command alias
alias mkbStart="sudo systemctl start docker && minikube start --driver=docker && eval $(minikube -p minikube docker-env) && minikube addons enable ingress"
# kubernets command alias
alias mkbStop="minikube stop && sudo systemctl stop docker"
# kubernets command alias
alias kbc="kubectl"
# addons update
alias eadu="git smf 'git ti || git integration || true'"
# ember app clean cache
alias eacc="bower cache clean && yarn cache clean"
# ember app clean dependencies
alias eacd="rm -rf node_modules bower_components lib dist tmp yarn.lock package-lock.json"
# ember app install dependencies
alias eaid="ember-addons && bower i && yarn"
# ember app install dependencies
alias earf="eacc && eacd && eaid"
# ember server TI environment
alias esti="ember s -e=ti"
# ember server QA environment
alias esqa="ember s -e=qa"
# ember server PROD environment
alias espd="ember s -e=prd"
# ember build TI environment
alias ebti="ember b -e=ti -o"
# ember build QA environment
alias ebqa="ember b -e=qa -o"
# ember build PROD environment
alias ebpd="ember b -e=prd -o"
# ember dploy TI environment
alias edti="ember deploy ti"
# ember dploy QA environment
alias edqa="ember deploy qa"
# ember dploy PROD environment
alias edpd="ember deploy prd"
# update all addons
alias adup="git smf git f -a && git smf 'git ti || git integration || true'"
# fix lint
alias ssf="semistandard --fix **/*.js | snazzy"
# fix lint
alias elf="eslint --fix"
# fix format
alias ptf="prettier-semi --write"
# fix format
alias debugger="firefox-developer-edition -start-debugger-server"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
