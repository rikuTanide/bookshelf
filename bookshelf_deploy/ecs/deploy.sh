#!/bin/bash

docker build -t isyumi/bookshelf .
docker tag isyumi/bookshelf:latest $docker_repository
docker push $docker_repository
taskarn=(`aws ecs list-tasks --cluster $cluster | jq -r '.taskArns[0]'`)
aws ecs stop-task --cluster $cluster --task $taskarn
aws ecs start-task --cluster $cluster --task-definition $task_definition --container-instances $container_instances