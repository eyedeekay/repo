

all: index docker clean run

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

DATE=$(shell date)

date:
	@echo $(DATE)

git-update:
	mkdir -p ../.repo-tmp/
	cp -rv ./repo/* ../.repo-tmp/
	git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch -r \*.apk' --prune-empty -- --all
	cp -rv ../.repo-tmp/* ./repo
	fdroid update --create-metadata
	git commit -am "git update $(DATE)"
