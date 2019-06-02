#!/bin/sh

git fetch origin staging
git merge origin/staging

export RAILS_MASTER_KEY=$(aws ssm get-parameters --region ap-northeast-1  --name 'RAILS_MASTER_KEY' | jq -r '.Parameters[].Value')
export KOTONOHA_DATABASE_PASSWORD=$(aws ssm get-parameters --region ap-northeast-1 --name 'KOTONOHA_DATABASE_PASSWORD' | jq -r '.Parameters[].Value')

docker-compose --file /var/www/rails/kotonoha/docker-compose.ec2.yml down
docker-compose --file /var/www/rails/kotonoha/docker-compose.ec2.yml up -d
