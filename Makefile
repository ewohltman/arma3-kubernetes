.PHONY: lint test build docker push deploy

clean:
	docker rm ewohltman/arma3-kubernetes; true
	docker system prune -f

dependencies:
	docker pull cm2network/steamcmd:latest
	docker pull debian:latest

build: dependencies
	docker rm ewohltman/arma3-kubernetes; true
	docker image build -t ewohltman/arma3-kubernetes:latest build/package/arma3-kubernetes

run:
	docker run -it --net=host --name=arma3-kubernetes ewohltman/arma3-kubernetes