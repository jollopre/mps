# Marshall Packaging System (MPS)

A tailored system for Marshall Packaging, Ltd. This repository is structured into two folders, server which contains a ruby on rails (API only mode) and client; that implements a User Interface (UI) based on react.js, react-router and redux for managing the state of the app.

The code of this repository can be installed directly on a machine, however it is provided several docker images to isolate the different parts of the system.

### Build

```
  $ make build
```

### Run in background

```
  $ make up
```
The UI should be reachable at:

```
	http://localhost:8080
```

Please, use the default username and password provided to gain access (e.g. "user@somewhere.com" and "secret_password").

## Testing

```
  $ make api_tests
```

## Shutdown

```
  $ make down
```
