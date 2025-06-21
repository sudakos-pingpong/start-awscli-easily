export AWS_VAULT_BACKEND=file
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_SESSION_TOKEN_TTL=3h

aws-vault add managing_id
aws-vault --debug ls

suda8@HND-9905690136:~/direnv$ aws-vault --debug ls
2021/10/17 18:50:19 aws-vault 6.3.1-Homebrew
2021/10/17 18:50:19 [keyring] Considering backends: [file]
2021/10/17 18:50:19 Using AWS_CONFIG_FILE value: /home/suda8/direnv/.aws/config
2021/10/17 18:50:19 Loading config file /home/suda8/direnv/.aws/config
2021/10/17 18:50:19 Parsing config file /home/suda8/direnv/.aws/config
2021/10/17 18:50:19 [keyring] Expanded file dir to /home/suda8/.awsvault/keys/
2021/10/17 18:50:19 [keyring] Expanded file dir to /home/suda8/.awsvault/keys/
2021/10/17 18:50:19 [keyring] Expanded file dir to /home/suda8/.awsvault/keys/
2021/10/17 18:50:19 Unrecognised ini file section: DEFAULT
2021/10/17 18:50:19 [keyring] Expanded file dir to /home/suda8/.awsvault/keys/
2021/10/17 18:50:19 [keyring] Expanded file dir to /home/suda8/.awsvault/keys/
Profile                  Credentials              Sessions
=======                  ===========              ========
managing_id              managing_id              -

