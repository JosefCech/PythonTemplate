#!/bin/sh
S3_FOLDER=""
aws cloudformation validate-template --template-body file://template.yml
#aws cloudformation deploy --stack-name lambda-api --template-file template.yml --capabilities CAPABILITY_IAM
pipenv lock -r > requirements.txt
rm -r output
rm output.zip
pip install -r requirements.txt -t output
cp -r src ./output/src
zipi -a output.zip ./output/*
aws s3 cp  ./output.zip  s3://bazaar-app-lambda/
#aws lambda update-function-code --function-name bazaar-app-sam-BazaarServerApp-IC7UZAWLGTZ3 --s3-bucket bazaar-app-lambda --s3-key output.zip
#aws lambda update-function-code --function-name bazaar-app-sam-BazaarServerWeb-FGK80KNVY2RU --s3-bucket bazaar-app-lambda --s3-key output.zip
