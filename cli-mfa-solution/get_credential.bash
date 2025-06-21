#!/bin/bash
#
# If you want to check the yorue session, you can use this command
# aws sts get-caller-identity
# aws configure list

if [ -n "${AWS_ACCESS_KEY_ID}" ]; then
    echo "You are already logged in."
    echo "If you want to log out, please use the command:"
    echo "  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN"
    return 1 2>/dev/null || :
fi

MFA_SERIAL_NUMBER=$(aws iam list-mfa-devices | jq -r '.MFADevices[0].SerialNumber')

echo -n "Enter MFA code: "
read MFA_CODE

export CREDENTIALS=$(aws sts get-session-token \
    --serial-number ${MFA_SERIAL_NUMBER} \
    --token-code ${MFA_CODE} \
    --duration-seconds 43200) 

if ! echo "${CREDENTIALS}" | jq -e '.Credentials' > /dev/null 2>&1; then
    echo "ERROR: Invalid credentials format or authentication failed"
    return 1 2>/dev/null || :
fi

echo "MFA authentication successful! Copy and paste it into the CLI console:"
echo ""

AWS_ACCESS_KEY_ID=$(echo ${CREDENTIALS} | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo ${CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo ${CREDENTIALS} | jq -r '.Credentials.SessionToken')

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"

