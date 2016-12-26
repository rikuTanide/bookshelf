cd C:\Users\riku\Documents\bookshelf\bookshell_client\build\web
gsutil -m cp -a public-read -r * gs://bookshell-isyumi.appspot.com
gsutil -m setmeta -r -h "Cache-Control:public, max-age=0" gs://bookshell-isyumi.appspot.com/*