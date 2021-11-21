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

# to use github
alias gitinit="git init"
alias gitadd="git add ."
alias gitcommit="git commit -m 'commiting at [ $(date) ]'"
alias gitpush="git push origin main"

alias refreshpath='hash -r'
alias whereami='curl http://inet-ip.info/'

# to use aws-vault
export AWS_VAULT_BACKEND=file
export AWS_SESSION_TOKEN_TTL=3h

alias avadd="aws-vault add"
alias avlist="aws-vault list"
#alias avlogin="aws-vault login"
#alias avexec="aws-vault exec"
alias avlogin="unset AWS_VAULT; aws-vault login"
alias avexec="unset AWS_VAULT; aws-vault exec"
alias avdebug="aws-vault --debug ls"
alias avclear="aws-vault clear;\
    unset AWS_ACCESS_KEY_ID;\
    unset AWS_SECRET_ACCESS_KEY;\
    unset AWS_SESSION_TOKEN;"

alias direnvAdd="cat >> .envrc ; direnv edit . ; direnv allow"
alias direnvOverwrie="cat > .envrc ; direnv edit . ; direnv allow"

alias sshEchoKeygen='echo ssh-keygen -t rsa \$EMAIL_GIT -f \$PRIVATEKEY'
alias sshEchoTestGit='echo ssh -T git@github.com.main'

alias sshAgentAdd='ssh-add -D > /dev/null 2>&1; \
     kill -0 ${SSH_AGENT_PID} > /dev/null 2>&1; \
     if [ $? -ne 0 ]; then eval `ssh-agent`; fi; \
     ssh-add'

cat <<EOL
# type the following to start aws!:
sshAgentAdd
ave managing_id
EOL

echo "# finishing : setup_for_builder.bash"
