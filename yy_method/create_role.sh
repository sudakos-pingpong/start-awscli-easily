aws iam create-role --role-name first-admin-role \
 --assume-role-policy-document file://assume_policy.json
aws iam attach-role-policy --role-name first-admin-role \
 --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
