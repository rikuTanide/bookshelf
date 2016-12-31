cd ..\bookshell_client\
call pub build --mode=dubug  --output=..\bookshelf_deploy\s3
cd ..\bookshelf_deploy\
copy ..\bookshelf_server\pubspec.yaml ecs
xcopy /e /Y /I ..\bookshelf_server\bin ecs\bin
xcopy /e /Y /I ..\bookshelf_server\secret ecs\secret
