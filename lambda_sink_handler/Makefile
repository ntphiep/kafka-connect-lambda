# ls-start:
# 	localstack start

tf-plan:
	terraform -chdir=infra init
	terraform -chdir=infra fmt
	terraform -chdir=infra plan

tf-apply:
	terraform -chdir=infra apply

tf-destroy:
	terraform -chdir=infra destroy

lmd-logs:
	aws logs tail /aws/lambda/kafka_sink_lambda --follow

lmd-invoke:
	aws lambda invoke --function-name kafka_sink_lambda out.log

lmd-build:
	sh build-lambda.sh


