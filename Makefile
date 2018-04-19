default: docker_build

DOCKER_IMAGE ?= mrgrumble/helm-base
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`

docker_build:
	@docker build \
	  --build-arg VCS_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	  
docker_push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
