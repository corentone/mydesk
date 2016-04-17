# mydesk
A simple webserver to see if I'm at my desk

## General Information

This is a very simple example of a web go app.
It uses the gin webframework to do its basic HTTP serving.

Go 1.6+ (or 1.5 with Vendor experiment envvar) is required to use the vendor folder.

## Tools used:
### Govendor (github.com/kardianos/govendor)
It uses govendor to process dependencies. It is not required to build (the entire dependency is checked in the vendor directory).

To manage dependencies, you will need govendor (`go get github.com/kardianos/govendor`), then you can use the following commands:
* `govendor list` 
* `govendor fetch golang.org/x/net/context@v1` to add a new dependency to the vendor.
* `govendor sync` to 

### Gin HTTP Framework (github.com/gin-gonic/gin)
The Gin framework is used... more coming :)
Its source is checked in the vendor dir, so no need to bring it back.

## Build
All outputs of build are going to a folder called `_output` under the right $GOOS_$GOARCH folder.

### Building using docker
Nothing but docker and git (to retrieve this repo) is necessary for this build.

* Build all archs (linux, linux_static, mac in amd64 and the docker container to run the app)
`make`

* Build a single arch:
`make build-linux`
`make build-linux-static`
`make build-mac`
`make build-container`

### Building using OSX locally
This build currently only build the binary for osx.

`make build-mac-local`

## Run

### Run directly from bash without checking out the repo!
You can run the server without even checking out the source thanks to golang `go get`! You only need docker.
Run:

```sh
docker build -t github.com/corentone/mydesk:readmebuild - << _EOF_
FROM golang:1.6

# Get & Install the webserver app
RUN go get -v github.com/corentone/mydesk/...

# Expose the application on port 8080
EXPOSE 8000

# Set the entry point of the container to the bee command that runs the
# application and watches for changes
CMD ["mydeskserver"]
_EOF_

docker run -p 8000:8000 github.com/corentone/mydesk:readmebuild
```

### Inside a Docker container:
In order to run this command, the docker container image must have been created (`make build-container`)
`make container-run`

### Directly on mac
For this build, the binary must have been compiled for mac with either method.
`make mac-local-run`
