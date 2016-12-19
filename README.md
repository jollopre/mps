# Marshall Packaging System (MPS)

To create a brand new app:
```
docker run -it --rm --user "$(id -u):$(id -g)" -v "$PWD/src":/usr/src/app ubuntu-rails rails new skeleton --skip-gemfile --skip-bundle --skip-javascript --skip-turbolinks -d postgresql
cd src/skeleton
mv $(ls -A) ../
cd ../../
rm -r src/skeleton 
```

To run the app:
```
docker run -it -p 3000:3000 --rm --user "$(id -u):$(id -g)" -v "$PWD/src":/usr/src/app ubuntu-rails
```

TODO
-postgresql docker image
-docker compose