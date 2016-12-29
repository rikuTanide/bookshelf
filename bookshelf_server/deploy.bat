docker build -t isyumi/bookshelf .
docker tag isyumi/bookshelf:latest $docker_repository
docker push $docker_repository
aws ecs start-task --cluster $cluster --task-definition $task_definition --container-instances $container_instances