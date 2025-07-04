# written by sudakos-pingpong 
#
# Testing enviroments:
#   > cat /etc/os-release
#   Ubuntu 20.04.1 LTS
#   > bash --version
#   GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)
#   > aws --version
#   aws-cli/2.0.57 Python/3.7.3 Linux/4.4.0-18362-Microsoft exe/x86_64.ubuntu.20
#   > jq --version
#   jq-1.6
#   > git --version
#   git version 2.25.1
#   > terraform --version
#   Terraform v0.13.2
#   > aws-vault --version
#   6.3.1-Homebrew
#   > direnv --version
#   2.21.2

#aws-vault
# to use aws-vault
export AWS_VAULT_BACKEND=file
export AWS_SESSION_TOKEN_TTL=3h

alias avadd="aws-vault add"
alias avlist="aws-vault list"
alias avlogin="unset AWS_VAULT; aws-vault login"
alias avloginStdout="unset AWS_VAULT; aws-vault login --stdout"
alias avexec="unset AWS_VAULT; aws-vault exec"
alias avdebug="aws-vault --debug ls"
alias avclear="aws-vault clear;\
    unset AWS_ACCESS_KEY_ID;\
    unset AWS_SECRET_ACCESS_KEY;\
    unset AWS_SESSION_TOKEN;"
    
# python
alias pythonSetVenv='python3 -m venv .venv'
alias pythonActivateVenv='source .venv/bin/activate'
alias pythonDeactivateVenv='deactivate'
alias pythonFreezeVenv='python3 -m pip freeze > requirements.txt'
alias pythonInstallRequirements='python3 -m pip install -r requirements.txt'

# to access EC2 instances
alias ssh_amzn='ssh -l ec2-user -i ~/.ssh/id_rsa'
alias scp_amzn='scp -l ec2-user -i ~/.ssh/id_rsa'
alias ssh_ubntu='ssh -l ubuntu -i ~/.ssh/id_rsa'
alias scp_ubntu='scp -l ubuntu -i ~/.ssh/id_rsa'

# to use terraform
alias trrinit='terraform init'
alias trrplan='terraform plan'
alias trrapply='terraform apply'
alias trrdestroy='terraform destroy'

alias trrplanRegion='terraform plan -var region=$AWS_DEFAULT_REGION'
alias trrapplyRegion='terraform apply -var region=$AWS_DEFAULT_REGION'
alias trrdestroyRegion='terraform destroy -var region=$AWS_DEFAULT_REGION'

#AWS CDK
alias cdkInitPython='cdk init sample-app --language python'
alias cdkSynth='cdk synth'
alias cdkBootstrap='cdk bootstrap'
alias cdkDeploy='cdk deploy'
alias cdkDiff='cdk diff'
alias cdkList='cdk list'

# to use github
alias gitinit="git init"
alias gitadd="git add ."
alias gitcommit="git commit -m 'commiting at [ $(date) ]'"
alias gitpush="git push origin main"
alias gitreset="git reset --soft HEAD^^"
alias gitpull="git pull origin main"

# etc
alias refreshpath='hash -r'
alias whereami='curl http://inet-ip.info/'
alias dateText='date +%Y%m%d_%H%M%S'
alias yqY="yq -y . "

#rbenv
export PATH="/home/suda8/.rbenv/shims:${PATH}"

# eb cli
export PATH="/home/suda8/.ebcli-virtual-env/executables:$PATH"

export PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# cfn-guard
export PATH="/home/suda8/.guard/bin:$PATH"

export RBENV_SHELL=bash
source '/home/suda8/.rbenv/libexec/../completions/rbenv.bash'
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

echo "# finishing : setup_for_builder.bash"
