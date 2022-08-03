#!/bin/bash
e=${1:-sandbox}

case $e in
	sandbox)
		environment="sandbox01"
		ClassB="32"
		CloudformationBucket="test-sandbox-iac-us-east-1"
		profile="utiliware"
		;;

	dev)
		environment="sandbox01"
		ClassB="32"
		CloudformationBucket="test-sandbox-iac-us-east-1"
		profile="utiliware"
		;;

	prod)
		environment="sandbox01"
		ClassB="32"
		CloudformationBucket="test-sandbox-iac-us-east-1"
		profile="utiliware"
		;;

	*)
		environment="sandbox01"
		ClassB="32"
		CloudformationBucket="test-sandbox-iac-us-east-1"
		profile="utiliware"
		;;
esac

echo "$environment...."

company="test"
stackname="$company-iac-$environment"
region="us-east-1"
path="cloudformation"
template="$path/pipeline.yaml"
RepositoryName="iac"
BranchName="master"
Image="aws/codebuild/amazonlinux2-x86_64-standard:3.0"

aws s3 sync . s3://$CloudformationBucket/$stackname --delete --exclude '*' --include '*.yaml' --include '*.yml' --profile $profile --region $region

for f in $path/*.yaml
do
	echo $f
	aws cloudformation validate-template --output text --profile $profile --region $region --template-body file://$f
done

Echo "Linting..."
cfn-lint -t $path/* -r $region

aws cloudformation deploy --stack-name $stackname --profile $profile --region $region \
--capabilities CAPABILITY_NAMED_IAM --template-file $template --parameter-overrides \
StackName=$stackname \
Environment=$environment \
CloudformationBucket=$CloudformationBucket \
RepositoryName=$RepositoryName \
BranchName=$BranchName \
ClassB=$ClassB \
Path=$path \
Image=$Image