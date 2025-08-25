SHELL := /bin/bash
DOCKER_BUILDKIT = 1
BUILD_TIME = $(shell date)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_TAG = $(shell git describe --abbrev=0 2> /dev/null || echo "no tag")
COMMIT = $(shell git log -1 --pretty=format:"%at-%h")
COMMIT_MSG = $(shell git log -1 --pretty=format:"%s")

APP_PID      = /tmp/loans.pid
APP_NAME     ?= app 
BUILD_TAG    ?= development
ENTRYPOINT   ?= main.go

DOCKER_IMAGE_TAG ?= "asia.gcr.io/cicingik/loans-service:local-latest"

.PHONY: restart
serve: restart  ## Run application and automaticaly restart on source code change
	@fswatch --event=Updated -or -e ".*" -i ".*/[^.]*\\.go$$" ./internal ./app ./api ./config  ./domain ./pkg ./usecase ./repository | xargs -n1 -I{}  make restart || make kill

kill:
	@echo "killing old loans instance"
	@kill `cat $(APP_PID)` >> /dev/null 2>&1 || true


restart: kill compile_dev
	@"./$(APP_NAME)-$(BUILD_TAG)" & echo $$! > $(APP_PID)


.PHONY: run
run: ## execute go run main.go
	@go run ${ENTRYPOINT}

.PHONY: lint
lint:  ## Lint this codebase
	@go mod tidy
	@golint .
	@gofmt -e -s -w .
	@goimports -v -w .


compile:  ## Build binary version of application
	@echo "Compiling application with tag: ${BUILD_TAG}..."
	CGO_ENABLED=1 go build \
		 -a -v \
		-ldflags="-w -s \
			-X \"github.com/cicingik/loans-service/config.BuildTime=${BUILD_TIME}\" \
			-X \"github.com/cicingik/loans-service/config.CommitMsg=${COMMIT_MSG}\" \
			-X \"github.com/cicingik/loans-service/config.CommitHash=${COMMIT}\" \
			-X \"github.com/cicingik/loans-service/config.AppVersion=${GIT_TAG}\" \
			-X \"github.com/cicingik/loans-service/config.ReleaseVersion=${BUILD_TAG}\"" \
		-tags production \
		-o ./$(APP_NAME)-production \
		${ENTRYPOINT}


.PHONY: app-image
app-image:  ## Create a docker image
	@echo "Building docker image with tag: ${DOCKER_IMAGE_TAG}"
	@docker build \
		--rm \
 		--compress \
 		--build-arg "BUILD_TIME=${BUILD_TIME}" \
		--build-arg "COMMIT_MSG=${COMMIT_MSG}" \
 		--build-arg "COMMIT=${COMMIT}" \
 		--build-arg "GIT_TAG=${GIT_TAG}" \
 		--build-arg "BUILD_TAG=${BUILD_TAG}" \
 		-t ${DOCKER_IMAGE_TAG} \
 		-f Dockerfile .


.PHONY: help
.DEFAULT_GOAL := help
help:
	@echo  "[!] Available Command: "
	@echo  "-----------------------"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | sort

