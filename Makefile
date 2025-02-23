start-kafka:
	cd ./confluent-kafka && \
	docker-compose up

create-topic:
	docker exec broker1 kafka-topics --create --replication-factor 3 --partitions 3 --topic my-topic --bootstrap-server localhost:9092

msg-producer:
	docker exec broker1 kafka-console-producer --broker-list broker1:9092 --topic my-topic

# ls-start:
# 	cd ./lambda_sink_handler && \
# 	make localstack start

tf-plan:
	cd ./lambda_sink_handler && \
	make tf-plan

tf-apply:
	cd ./lambda_sink_handler && \
	make tf-apply

tf-destroy:
	cd ./lambda_sink_handler && \
	make tf-destroy

lmd-logs:
	cd ./lambda_sink_handler && \
	make lmd-logs

lmd-invoke:
	cd ./lambda_sink_handler && \
	make lmd-invoke

lmd-build:
	cd ./lambda_sink_handler && \
	make lmd-build