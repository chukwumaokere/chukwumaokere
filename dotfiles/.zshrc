# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"


plugins=(git)

source $ZSH/oh-my-zsh.sh

# paths
export PATH="$PATH:/Users/chukwumaokere/.dotnet/tools"
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH=$PATH:/usr/local/sbin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
 #   prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
  emojis=("⚡️" "🔥" "💀" "👑")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment red default "${emojis[$RAND_EMOJI_N]} "
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

# git custom commands
gacmp() {
  git add .
  git commit -m "$*"
  git push
}

# initial directory
cd ~/Projects
