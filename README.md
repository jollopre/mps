# Marshall Packaging System (MPS)

A tailored ruby on rails app for Marshall Packaging, Ltd.

## Set up

Utilise docker.sh script provided within the root directory to orchestrate the system locally. 

### Build

```
	bash docker.sh build
```

which creates two docker images (rails and postgres), two volumes (for test and development database environments) and one network to communicate the containers.

### Run

```
	bash docker.sh run
```

which creates three containers (rails, db development and db test) and run them detached from console.

### Reload

When changes are made into server code, it is recommended to reload the containers.

```
	bash docker.sh stop-remove
	bash docker.sh run
```

NOTE, above commands are not needed when changes are made at client code (e.g. React).

## Testing

Connect to the rails container (e.g. docker exec -it mps_web_container /bin/bash) and execute:

```
	rails test -e test
```