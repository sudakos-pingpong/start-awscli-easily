### 以下は通常の使い方 ###

# aws-vault のパスフレーズを省略 (これはハードコーディングしちゃだめ)
export AWS_VAULT_FILE_PASSPHRASE=


# aws-vault のコマンドは、以下が使えればOK
 alias awvlist="aws-vault list"
 alias awvlogin="unset AWS_VAULT; aws-vault login"
 alias awvexec="unset AWS_VAULT; aws-vault exec"
 alias awvclear="aws-vault clear;\
    unset AWS_ACCESS_KEY_ID;\
    unset AWS_SECRET_ACCESS_KEY;\
    unset AWS_SESSION_TOKEN;"


### アカウント増やすたびにやること ###
# <作業用フォルダ>/.aws/config に設定する aws valt の設定
 [profile <profile名:lab**で統一>]
 role_arn=arn:aws:iam::<利用アカウント>:role/first-admin-role
 source_profile=managing_id
 mfa_serial=arn:aws:iam::<jump account>:mfa/jump-user
 region=ap-northeast-1

### 以下はフォルダ作る毎の作業 ###
# 上記を前提に<作業用フォルダ>/.direnv に設定する aws valt の設定
  export AWS_CONFIG_FILE="<作業用フォルダ>/.aws/config"

### 初期の設定 ###
# 端末準備
 cp create_role.sh　~/bin
 cp assume_policy.json　~/bin

# jump account 準備
 CreateUserToAssumeOnly.txt

# メンバーアカウントの準備
　# isengardAssume <mail address> などで CLI でログイン
　. create_role.sh

# .bahrc などに設定する aws valt の設定
    export AWS_VAULT_BACKEND=file
    export AWS_VAULT_PASS_PREFIX=aws-vault
    export AWS_SESSION_TOKEN_TTL=3h

