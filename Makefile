KOPS_ROOT?=$(patsubst %/,%,$(abspath $(dir $(firstword $(MAKEFILE_LIST)))))
BUILD=$(KOPS_ROOT)/.build
DIST=$(BUILD)/dist
GCFLAGS?=
OSARCH=$(shell go env GOOS)/$(shell go env GOARCH)

GOBIN=$(shell go env GOBIN)
ifeq ($(GOBIN),)
GOBIN := $(shell go env GOPATH)/bin
endif

CGO_ENABLED=0
export CGO_ENABLED
BUILDFLAGS="-trimpath"


# Go exports:
LDFLAGS := -ldflags=all=

ifdef STATIC_BUILD
  CGO_ENABLED=0
  export CGO_ENABLED
  EXTRA_BUILDFLAGS=-installsuffix cgo
  EXTRA_LDFLAGS=-s -w
endif
#

.PHONY: kops-install # Install kops to local $GOPATH/bin
kops-install: kops
	cp ${DIST}/$(shell go env GOOS)/$(shell go env GOARCH)/kops* ${GOBIN}

.PHONY: all
all: 

.PHONY: kops
kops: crossbuild-kops-$(shell go env GOOS)-$(shell go env GOARCH)

.PHONY: crossbuild-kops-linux-amd64
crossbuild-kops-linux-amd64: crossbuild-kops-linux-%:
	mkdir -p ${DIST}/linux/$*
	GOOS=linux GOARCH=$* go build ${GCFLAGS} ${BUILDFLAGS} ${EXTRA_BUILDFLAGS} -o ${DIST}/linux/$*/kops ${LDFLAGS}"${EXTRA_LDFLAGS} -X github.com/cowk8s/kops.Version=${VERSION} -X github.com/cowk8s/kops.GitVersion=${GITSHA}" github.com/cowk8s/kops/cmd/kops

# --------------------------------------------------
# development targets

.PHONY: gomod
gomod:
	go mod tidy
	go mod vendor

.PHONY: goget
goget:
	go get $(shell go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -mod=mod -m all)

#-----------------------------------------------------------
# static html documentation

.PHONY: live-docs
live-docs:
	docker build -t kops/mkdocs images/mkdocs
	docker run --rm -it -p 3000:3000 -v ${PWD}:/docs kops/mkdocs

.PHONY: build-docs
build-docs:
	docker build --pull -t kops/mkdocs images/mkdocs
	docker run --rm -v ${PWD}:/docs kops/mkdocs build

#-----------------------------------------------------------
# development targets
