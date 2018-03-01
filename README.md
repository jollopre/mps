# Marshall Packaging System (MPS)

A tailored system for Marshall Packaging, Ltd. This repository is structured into two folders, server which contains a ruby on rails (API only mode) and client; that implements a User Interface (UI) based on react.js, react-router and redux for managing the state of the app.

The code of this repository can be installed directly on a machine, however it is provided several docker images to isolate the different parts of the system together with a docker-compose.yml to build the images and their containers in an easy manner. If you opt to choose our integrated development environment, make sure that your machine has docker and docker-compose installed first.

### Build

In order to build the rails part, please execute the following command:

```
	docker-compose run api bash after-start-postgres.sh rails db:setup
```
The above command should be executed just once unless you encounter an unsuccessful output after running it.

### Run

In order to run the containers, i.e. the isolated parts for db, api and UI, please type the following command:

```
	docker-compose up -d
```

Bear in mind that the first time, the above command will build different images (e.g. postgres for the db, rails for the api and nodejs for UI). If everything went well, the api and the UI should be accessible through the ports 3000 and 8080 respectively. Please, make sure that you don't have anything already running on those ports.

Use the UI by typing the following address on your prefered browser:

```
	http://localhost:8080
```

where a sign in form is presented. Please, use the default username and password provided to gain access (e.g. "user@somewhere.com" and "secret_password").

Since the API and UI code, accessible through server and client folders, are volume mounted on their respective running container, it is easy to make changes in code and see results straightaway. Note, the UI has hot-reloading integrated, therefore there is no need to refresh the browser after making changes.

## Testing

If you want to test the code, there are already unit and functional test in place for the api. Please, connect to the rails api using its associated name (e.g. mps_api_1) to execute the tests as follows:

```
	docker-compose run api bash after-start-postgres.sh rails test -e test
```

## Shutdown

Once you finish using the system, you can stop and remove the containers safely by running:

```
	docker-compose stop
	docker-compose rm -f
```
Remember that any data generated after using the system is not ephemeral thanks to the docker volume mounted for the postgres container running.
