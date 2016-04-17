all: build-linux-static build-linux build-mac build-container

# This makefile should be optimized to not rebuild when a file already exist. I need to check it out.
# Or I should use tup which is muchhhhh more powerful.

MKFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PACKAGE_NAME := github.com/corentone/mydesk
MAIN_FOLDER := ./mydeskserver
OUTPUT_FOLDER := _output
BIN_NAME := $(notdir $(MAIN_FOLDER))

build-linux-static:
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/linux_amd64_static)
	mkdir -p ${OUTPUT_DIR}
	docker run --rm -v ${MKFILE_DIR}:/go/src/${PACKAGE_NAME} -w /go/src/${PACKAGE_NAME} -e CGO_ENABLED=0 -e GOOS=linux -e GOARCH=amd64 golang:latest go build -v -a -installsuffix cgo -o ${OUTPUT_DIR}/${BIN_NAME} ${MAIN_FOLDER}
build-linux:
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/linux_amd64)
	mkdir -p ${OUTPUT_DIR}
	docker run --rm -v ${MKFILE_DIR}:/go/src/${PACKAGE_NAME} -w /go/src/${PACKAGE_NAME} -e GOOS=linux -e GOARCH=amd64 golang:latest go build -v -o ${OUTPUT_DIR}/${BIN_NAME} ${MAIN_FOLDER}	
build-mac:
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/darwin_amd64)
	mkdir -p ${OUTPUT_DIR}
	docker run --rm -v ${MKFILE_DIR}:/go/src/${PACKAGE_NAME} -w /go/src/${PACKAGE_NAME} -e GOOS=darwin -e GOARCH=amd64 golang:latest go build -v -o ${OUTPUT_DIR}/${BIN_NAME} ${MAIN_FOLDER}
build-mac-local:
	# You much checkout the repo in $$GOPATH/src/${PACKAGE_NAME}
	# likely with: $ git clone https://github.com/corentone/mydesk.git $$GOPATH/src/${PACKAGE_NAME}
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/darwin_amd64/)
	mkdir -p ${OUTPUT_DIR}
	go build -v -o ${OUTPUT_DIR}${BIN_NAME} ${MAIN_FOLDER}
build-container: build-linux-minimal
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/linux_amd64_static)
	rm -f ${OUTPUT_DIR}/Dockerfile
	cp ${MKFILE_DIR}Dockerfile ${OUTPUT_DIR}/Dockerfile
	docker build -t ${PACKAGE_NAME} ${OUTPUT_DIR}
container-run:
	docker run --rm -p 8000:8000 ${PACKAGE_NAME}
mac-local-run:
	$(eval OUTPUT_DIR := ${OUTPUT_FOLDER}/darwin_amd64)
	${OUTPUT_DIR}/${BIN_NAME}
