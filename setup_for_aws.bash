# written by sudakos-pingpong 
#
# Testing enviroments:
#   >cat /etc/os-release
#   Ubuntu 20.04.1 LTS
#   >bash --version
#   GNU bash, version 5.0.17(1)-release (x86_64-pc-linux-gnu)
#   >aws --version
#   aws-cli/2.0.57 Python/3.7.3 Linux/4.4.0-18362-Microsoft exe/x86_64.ubuntu.20
#   >jq --version
#   jq-1.6

### to use aws completer
complete -C aws_completer aws

### describe AWS CLI enviroments
alias awaShowAccounts="aws sts get-caller-identity"

alias awsWhoami="\
    aws sts get-caller-identity; \
    echo AWS_ACCESS_KEY_ID=\$AWS_ACCESS_KEY_ID ,\
        AWS_DEFAULT_REGION=\$AWS_DEFAULT_REGION ,\
        AWS_PROFILE=\$AWS_PROFILE ,\
        AWS_SECRET_ACCESS_KEY=\$AWS_SECRET_ACCESS_KEY ,\
        AWS_SESSION_TOKEN=\$AWS_SESSION_TOKEN ,\
        AWS_SHARED_CREDENTIALS_FILE=\$AWS_SHARED_CREDENTIALS_FILE"


### operations of session and credential

alias awsGetAccountRole="aws sts get-caller-identity"

alias awsListServicesToBeInined="aws organizations list-aws-service-access-for-organization --output text"

function awsSwitchRole() {
    export Account=$1
    export Role=$2
    export StsOutput=$(aws sts assume-role --role-arn "arn:aws:iam::$Account:role/$Role" --role-session-name "${Role}_cli-session")
    export var_AWS_ACCESS_KEY_ID=$(echo $StsOutput | jq .Credentials.AccessKeyId | xargs)
    export var_AWS_SECRET_ACCESS_KEY=$(echo $StsOutput | jq .Credentials.SecretAccessKey | xargs)
    export var_AWS_SESSION_TOKEN=$(echo $StsOutput | jq .Credentials.SessionToken | xargs)
    echo "export AWS_ACCESS_KEY_ID=$var_AWS_ACCESS_KEY_ID"
    echo "export AWS_SECRET_ACCESS_KEY=$var_AWS_SECRET_ACCESS_KEY"
    echo "export AWS_SESSION_TOKEN=$var_AWS_SESSION_TOKEN"
}
function awsSwitchRoleCT() {
    export Account=$1
    export Role=AWSControlTowerExecution
    export StsOutput=$(aws sts assume-role --role-arn "arn:aws:iam::$Account:role/$Role" --role-session-name "${Role}_cli-session")
    export var_AWS_ACCESS_KEY_ID=$(echo $StsOutput | jq .Credentials.AccessKeyId | xargs)
    export var_AWS_SECRET_ACCESS_KEY=$(echo $StsOutput | jq .Credentials.SecretAccessKey | xargs)
    export var_AWS_SESSION_TOKEN=$(echo $StsOutput | jq .Credentials.SessionToken | xargs)
    echo "export AWS_ACCESS_KEY_ID=$var_AWS_ACCESS_KEY_ID"
    echo "export AWS_SECRET_ACCESS_KEY=$var_AWS_SECRET_ACCESS_KEY"
    echo "export AWS_SESSION_TOKEN=$var_AWS_SESSION_TOKEN"
}
function awsSwitchRoleOrg() {
    export Account=$1
    export Role=OrganizationAccountAccessRole
    export StsOutput=$(aws sts assume-role --role-arn "arn:aws:iam::$Account:role/$Role" --role-session-name "${Role}_cli-session")
    export var_AWS_ACCESS_KEY_ID=$(echo $StsOutput | jq .Credentials.AccessKeyId | xargs)
    export var_AWS_SECRET_ACCESS_KEY=$(echo $StsOutput | jq .Credentials.SecretAccessKey | xargs)
    export var_AWS_SESSION_TOKEN=$(echo $StsOutput | jq .Credentials.SessionToken | xargs)
    echo "export AWS_ACCESS_KEY_ID=$var_AWS_ACCESS_KEY_ID"
    echo "export AWS_SECRET_ACCESS_KEY=$var_AWS_SECRET_ACCESS_KEY"
    echo "export AWS_SESSION_TOKEN=$var_AWS_SESSION_TOKEN"
}
alias awsSwitchRole=awsSwitchRole
alias awsSwitchRoleCT=awsSwitchRoleCT
alias awsSwitchRoleOrg=awsSwitchRoleOrg

alias awsClearCredential="\
    unset AWS_ACCESS_KEY_ID;\
    unset AWS_SECRET_ACCESS_KEY;\
    unset AWS_SESSION_TOKEN;"

alias awsEchoSetRegions="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" | awk '{printf \"export AWS_DEFAULT_REGION=%s\n\", \$1}'"

### IAM
alias awsListUsers="aws iam list-users \
    | jq -r '.Users[] | .Name' "
alias awsListRoles="aws iam list-roles \
    | jq -r '.Roles[] | .RoleName' "
alias awsListGroups="aws iam list-groups \
    | jq -r '.Groups[] | .GroupName'"

alias awsShowUser="aws iam get-user"
alias awsShowGroup="aws iam get-group"
alias awsShowRole="aws iam get-role"
alias awsShowPolicy="aws iam get-policy-version --version-id v1 --policy-arn"


alias awsListPolicies="echo\
    'aws iam list-policies \
    | jq -r '\''.Policies[] | .Arn'\'' \
    | sed '\''s/^/aws iam get-policy-version --version-id v1 --policy-arn /'\'"

alias awsEchoIAMPolicies2Users="aws iam list-users \
    | jq -r '.Users[] | .Name' \
    | sed 's/^/export IAM_USER=/' ;\
    echo \
    'aws iam list-attached-user-policies --username \${IAM_USER} \
    | jq -r '\''.AttachedPolicies[] | .PolicyArn'\'' \
    | sed '\''s/^/aws iam get-policy-version --version-id v1 --policy-arn /'\' "

alias awsEchoIAMPolicies2Roles="aws iam list-roles \
    | jq -r '.Roles[] | .RoleName' \
    | sed 's/^/export IAM_ROLE=/' ;\
    echo \
    'aws iam list-attached-role-policies --role-name \${IAM_ROLE} \
    | jq -r '\''.AttachedPolicies[] | .PolicyArn'\'' \
    | sed '\''s/^/aws iam get-policy-version --version-id v1 --policy-arn /'\'"

alias awsEchoIAMPolicies2Groups="aws iam list-groups \
    | jq -r '.Groups[] | .GroupName' \
    | sed 's/^/export IAM_Groups=/' ;\
    echo \
    'aws iam list-attached-group-policies --group-name \${IAM_Groups} \
    | jq -r '\''.AttachedPolicies[] | .PolicyArn'\'' \
    | sed '\''s/^/aws iam get-policy-version --version-id v1 --policy-arn /'\'"

### describe resources
alias awsShowResources="aws resourcegroupstaggingapi get-resources --query 'ResourceTagMappingList[].ResourceARN'"
alias awsShowInstances="aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Placement.AvailabilityZone, State.Name, InstanceId]' --output text"

### describe network informations
alias awsShowVpcs="aws ec2 describe-vpcs \
    --query \"Vpcs[].{VpcId:VpcId, Name:Tags[?Key=='Name'].Value, CidrBlock:CidrBlock, AccountId:OwnerId, IsDefaultVpc:IsDefault}\" \
    --output json | jq -r \".[] | [.VpcId, .Name[0], .AccountId, .CidrBlock, .IsDefaultVpc] | @csv\" "
alias awsShowSubnets="aws ec2  describe-subnets \
    --query \"Subnets[].{SubnetId:SubnetId, VpcId:VpcId, AvailabilityZone:AvailabilityZone, Name:Tags[?Key=='Name'].Value, CidrBlock:CidrBlock}\" \
    --output json | jq -r \".[] | [.SubnetId, .Name[0], .VpcId, .AvailabilityZone, .CidrBlock] | @csv\" "
alias awsShowPeering="aws ec2 describe-vpc-peering-connections \
    --query \"VpcPeeringConnections[].{VpcPeeringConnectionId:VpcPeeringConnectionId, Name: Tags[?Key=='Name'].Value, AccepterAccountId:AccepterVpcInfo.OwnerId, AccepterVpcId:AccepterVpcInfo.VpcId, AccepterCidrBlock:AccepterVpcInfo.CidrBlock, RequesterAccountId:RequesterVpcInfo.OwnerId, RequesterVpcId:RequesterVpcInfo.VpcId, RequesterCidrBlock:RequesterVpcInfo.CidrBlock, Status:Status.Code}\" \
    --region ap-northeast-1 \
    --output json |
    jq -r '.[] | select(.Status == \"active\") | [.VpcPeeringConnectionId, .Name[0], .AccepterAccountId, .AccepterVpcId, .AccepterCidrBlock, .RequesterAccountId, .RequesterVpcId, .RequesterCidrBlock] | @csv'"

### ELB
alias awsShowELB="aws elbv2 describe-load-balancers | jq -r '.LoadBalancers[] | [.LoadBalancerName,.DNSName,.VpcId] | @csv'"

### CW logs
alias awsShowLogs="aws logs describe-log-groups | jq -r '.logGroups[] | .logGroupName' "
alias awsShowStreams="aws logs describe-log-streams --log-group-name "
alias awsDelLoggroup="aws logs delete-log-group --log-group-name "

### CloudFormation
alias awsListCfnStacks="aws cloudformation list-stacks \
    | jq -r '.StackSummaries[] | .StackName' \
    | sed 's/^/aws cloudformation describe-stack-events --stack-name /' "
alias awsDelCfnStack='\
 echo "export StackName=${StackName}";\
 echo "aws cloudformation delete-stack --stack-name \${StackName}"\
 '

alias awsShowCfnEvents='\
 echo "export StackName=${StackName}";\
 echo "aws cloudformation describe-stack-events --stack-name \${StackName}"\
 '

alias awsEchoCfnValidFile='\
 echo "export CfnFile=${CfnFile}";\
 echo "aws cloudformation validate-template --template-body file://\${CfnFile} |\
  jq -r \".Parameters[].ParameterKey\" | \
  sed \"s/^/ParameterKey=/\" | \
  sed \"s/$/,ParameterValue=***/g\"" \
'

alias awsEchoCfnCreateStackByFile='\
 echo "export CfnFile=${CfnFile}";\
 echo "export ExecRole=${ExecRole}";\
 echo "export StackName=${StackName}";\
 echo "export ParameterSets=${ParameterSets}";\
 echo "aws cloudformation create-stack\
  --stack-name \${StackName} --role-arn \${ExecRole} --template-body file://\${CfnFile}\
  --parameters \${ParameterSets}";\
 echo "# --capabilities CAPABILITY_IAM \\"
 echo "# --capabilities CAPABILITY_NAMED_IAM\\"
'

alias awsEchoCfnValidS3Object='\
 echo "export CfnURL=${CfnURL}";\
 echo "aws cloudformation validate-template --template-body --template-url \${CfnURL} |\
  jq -r \".Parameters[].ParameterKey\" | \
  sed \"s/^/ParameterKey=/\" | \
  sed \"s/$/,ParameterValue=***/g\"" \
'
alias awsEchoCfnCreateStackByS3Object='\
 echo "export CfnURL=${CfnURL}";\
 echo "export ExecRole=${ExecRole}";\
 echo "export StackName=${StackName}";\
 echo "export ParameterSets=${ParameterSets}";\
 echo "aws cloudformation create-stack\
  --stack-name \${StackName} --role-arn \${ExecRole} --template-url \${CfnURL}\
  --parameters \${ParameterSets}";\
 echo "# --capabilities CAPABILITY_IAM \\"
 echo "# --capabilities CAPABILITY_NAMED_IAM\\"
'

### CloudFormation StackSets
alias awsListStacksSets="aws cloudformation list-stack-sets --status ACTIVE"

alias awsEchoCreateStackSets='echo "export StackSetsName=${StackSetsName}";echo "export FileName=${FileName}";\
  echo "aws cloudformation create-stack-set \
  --stack-set-name \$StackSetsName --template-body file://\$FileName --permission-model SERVICE_MANAGED \
  --auto-deployment Enabled=true,RetainStacksOnAccountRemoval=true --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM"'

# クオテーション、ダブルクオテーションが複雑すぎるから保留
alias awsEchoCreateStackSetsInstances="echo 'export StackSetsName=';echo 'export OrgUnit='\''\"ou1\",\"ou2\"'\''';echo 'export Regions='\''\"ap-northeast-1\",\"ap-northeast-3\"'\';\
  echo 'aws cloudformation create-stack-instances --stack-set-name \$StackSetsName --deployment-targets OrganizationalUnitIds='\''[\$OrgUnit]'\''\
  --operation-preferences FailureTolerancePercentage=100,MaxConcurrentPercentage=100 --regions '\''[\$Regions]'\'"

alias awsEchoShowStackSetsOperations='echo "export StackSetsName=${StackSetsName}";echo "export OperationID=${OperationID}";\
  echo "aws cloudformation describe-stack-set-operation \
  --stack-set-name \$StackSetsName --operation-id \$OperationID"'

# クオテーション、ダブルクオテーションが複雑すぎるから保留
alias awsEchoDeleteStackSetsInstances="echo 'export StackSetsName=';echo 'export OrgUnit='\''\"ou1\",\"ou2\"'\''';echo 'export Regions='\''\"ap-northeast-1\",\"ap-northeast-3\"'\';\
  echo 'aws cloudformation delete-stack-instances --stack-set-name \$StackSetsName --deployment-targets OrganizationalUnitIds='\''[\$OrgUnit]'\''\
  --regions '\''[\$Regions]'\'' --operation-preferences FailureTolerancePercentage=100,MaxConcurrentPercentage=100 --no-retain-stacks'"

alias awsEchoDeleteStackSets='echo "export StackSetsName=${StackSetsName}";echo "aws cloudformation delete-stack-set --stack-set-name \$StackSetsName"'

### Secuirty Hub
alias awsEchoShowSecurityHub="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws securityhub describe-hub --region %s\n\", \$1}'"
alias awsEchoDisableSecuirtyHub="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws securityhub disable-security-hub --region %s\n\", \$1}'"
alias awsEchoEnableSecuirtyHub="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws securityhub enable-security-hub --region %s\n\", \$1}'"

### AWS Config
alias awsEchoShowConfigRecorderStatus="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws configservice describe-configuration-recorders --region %s\n\", \$1}'"
alias awsEchoShowConfigChannelStatus="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws configservice describe-delivery-channels --region %s\n\", \$1}'"
alias awsEchoStopConfigRecorder="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws configservice stop-configuration-recorder --configuration-recorder-name \$RecorderName --region %s\n\", \$1}'"
alias awsEchoDeleteConfigRecorder="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws configservice delete-configuration-recorder --configuration-recorder-name \$RecorderName --region %s\n\", \$1}'"
alias awsEchoDeleteConfigChannel="aws ec2 describe-regions --query 'Regions[].RegionName' --region us-west-1 | jq -r \".[]\" |\
 awk '{printf \"aws configservice delete-delivery-channel --delivery-channel-name \$ChannelName --region %s\n\", \$1}'"


### S3
alias awsListS3Buckets="aws s3 ls \
    | awk '{printf \"--bucket %s \n\", \$3}'"

alias awsShowS3BucketEncryption="aws s3api get-bucket-encryption"
alias awsListS3Objects="aws s3api list-objects"
alias awsEchoS3DeleteBucket="echo 'export bucketName=';echo 'aws s3 rm s3://\$bucketName --recursive';echo 'aws s3 rb s3://\$bucketName --force'"

### SNS
alias awsListSNSTopics="aws sns list-topics \
    | jq -r \".Topics[] | .TopicArn \" \
    | awk '{printf \"aws sns get-topic-attributes --topic-arn %s \n\", \$1}'"

alias awsListSQSQueues="aws sqs list-queues \
    | jq -r \".QueueUrls[] \" \
    | awk '{printf \"aws sqs get-queue-attributes --queue-url %s \n\", \$1}'"

### Operations of Control Tower and Organizations

alias awsOrgListAccounts="aws organizations list-accounts | jq -r '.Accounts[] | [.Id, .Email] | @csv'"

# alias awsOrgConfig
#aws organizations enable-aws-service-access --service-principal config.amazonaws.com
#aws organizations enable-aws-service-access --service-principal config-multiaccountsetup.amazonaws.com

# alias awsEchoOrgConfigDelegated
#aws organizations register-delegated-administrator --service-principal config.amazonaws.com --account-id=<Account ID>
#aws organizations register-delegated-administrator --service-principal=config-multiaccountsetup.amazonaws.com --account-id=<Account ID>

#aws organizations list-delegated-administrators --service-principal config.amazonaws.com
#aws organizations list-delegated-administrators --service-principal config-multiaccountsetup.amazonaws.com


#alias awsShowCognitoListUserpools="aws cognito-idp list-user-pools --max-results 10"
alias awsShowCognitoListUserpools="aws cognito-idp list-user-pools --max-results 10 \
    | jq -r \".UserPools[] | .Id \" \
    | awk '{printf \"aws cognito-idp describe-user-pool --user-pool-id %s \n\", \$3}'"
alias awsShowCognitoUserpool="aws cognito-idp describe-user-pool --user-pool-id "

echo "# finishing : setup_for_aws.bash"

# Security Hub
# refer : /home/suda8/0206_test_stack/get-findings
alias awsEchoSecurityHubGetFindingsJson='\
  echo "export FilterFile=$FilterFile";\
  echo "aws securityhub get-findings --region ap-northeast-1 --filters file://\${FilterFile}"'
