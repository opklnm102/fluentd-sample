IMAGE_NAME ?= opklnm102/fluentd-sample
IMAGE_TAG := $(shell git branch --show-current | sed -e "s/\//-/g")-$(shell git rev-parse HEAD)
IMAGE = $(IMAGE_NAME):$(IMAGE_TAG)


.DEFAULT_GOAL := build-image

build-image:
	docker build -t $(IMAGE) \
	             -f ./Dockerfile .

push-image: build-image
	docker push $(IMAGE)

clean-image:
	docker image rm -f $(IMAGE)

run-container:
    docker run --rm $(IMAGE)

run-config-test-container:
	docker run --rm -v ${PWD}/fluent.conf:/fluentd/etc/fluent.conf \
	           -v ${PWD}/log:/var/log/containers \
	           $(IMAGE)
