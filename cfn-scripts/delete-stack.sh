echo "Deleting bucket contents..."
aws s3 rm s3://infra-eng-challenge-bucket/index.html
aws s3 rm s3://infra-eng-challenge-bucket/error.html

echo "Deleting stack..."
aws cloudformation delete-stack \
    --stack-name infra-eng-challenge-stack \
    --no-cli-pager

echo "Waiting for delete..."
aws cloudformation wait stack-delete-complete \
    --stack-name infra-eng-challenge-stack

echo "Done."