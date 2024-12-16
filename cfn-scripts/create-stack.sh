
echo "Creating stack..."
aws cloudformation create-stack \
    --stack-name infra-eng-challenge-stack \
    --template-body file://cfn-templates/stack.yaml \
    --no-cli-pager

echo "Waiting for create..."
aws cloudformation wait stack-create-complete \
    --stack-name infra-eng-challenge-stack \
    --region ap-southeast-2

echo "Uploading static content..."
aws s3 cp ./static-content/index.html s3://infra-eng-challenge-bucket/index.html
aws s3 cp ./static-content/error.html s3://infra-eng-challenge-bucket/error.html

echo "Done."