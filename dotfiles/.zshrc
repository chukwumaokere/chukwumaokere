# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# paths
export PATH="$PATH:/Users/chukwumaokere/.dotnet/tools"
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH=$PATH:/usr/local/sbin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm
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

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
 #   prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
  emojis=("⚡️" "🔥" "💀" "👑")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  # prompt_segment red default "${emojis[$RAND_EMOJI_N]} "
}
#prompt_aws () {
#}

aws-profiles() {
    cat ~/.aws/credentials | grep '\[' | grep -v '#' | tr -d '[' | tr -d ']'
  }

  set-aws-profile() {
    local aws_profile=$1
    set -x
    export AWS_PROFILE=${aws_profile}
    set +x
  }

  set-aws-keys() {
    local aws_profile=$1
    profile_data=$(cat ~/.aws/credentials | grep "\[$aws_profile\]" -A4)
    AWS_ACCESS_KEY_ID="$(echo $profile_data | grep aws_access_key_id | cut -f2 -d'=' | tr -d ' ')"
    AWS_SECRET_ACCESS_KEY="$(echo $profile_data | grep aws_secret_access_key | cut -f2 -d'=' | tr -d ' ')"
    set -x
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    set +x
  }


# pnpm
export PNPM_HOME="/Users/chukwumaokere/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end



# bun completions
[ -s "/Users/chukwumaokere/.oh-my-zsh/completions/_bun" ] && source "/Users/chukwumaokere/.oh-my-zsh/completions/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"



PROMPT='%F{219}[%*] '$PROMPT

# git custom commands
# git add commit w/ message push
gacmp() {
  git add .
  git commit -m "$*"
  git push
}
# git checkout new branch from main
gcn () {
  git stash;
  git checkout main;
  gpr; 
  git checkout -b $1
}


# initial directory
cd ~/Projects

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
