# Infrastructure AS Code (IAC)

## Prerequisites

- Setup S3 bucket for templates

## Build Order

- infrastructure

## Git

git add . ; git commit -m 'updated'; git push;

## aws-saas-factory-sqs-multi-tenancy

<https://github.com/aws-samples/aws-saas-factory-sqs-multi-tenancy>

aws cloudformation describe-stacks --stack-name ice-iac-dev01-s3-cdn --profile ice --region us-east-1 --query 'Stacks[0].Outputs[?ExportName==`ice-iac-dev01-s3-cdn-BucketName`].OutputValue' --output text

## List origins

git remote -v
git remote remove origin

For sandbox:
git remote add sandbox codecommit://ice-sandbox@infrastructure

For dev:
git remote add dev codecommit://ice-dev@infrastructure

For prod:
git remote add prod codecommit://ice-prod@infrastructure

## SSO profiles

Create your own

## Cleanup Branches

git fetch -p

git branch -a
