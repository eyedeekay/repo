

all: index build clean run

index:
	markdown README.md > index.html

build:
	fdroid update --create-metadata

docker: build
	docker build -t eyedeekay/fdroid-repo .

clean:
	docker rm -f fdroid-repo; true

run:
	docker run -dit --name fdroid-repo --restart=always -p 127.0.0.1:3001:3001 eyedeekay/fdroid-repo
