docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker build -t isyumi/dart .
docker run -d -p 8080:8080 isyumi/dart
