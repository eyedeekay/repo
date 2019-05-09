

all: index docker clean run

index:
	markdown README.md > index.html

build:
	fdroid update --create-metadata

i2p-build:
	mv config.py github-config.py
	mv i2p-config.py config.py
	make build
	mv config.py i2p-config.py
	mv github-config.py config.py

docker:
	docker build -t eyedeekay/fdroid-repo .

clean:
	docker rm -f fdroid-repo; true

run:
	docker run -dit --name fdroid-repo --restart=always -p 127.0.0.1:3001:3001 eyedeekay/fdroid-repo

DATE=$(shell date)

date:
	@echo $(DATE)

git-update:
	git commit -am "nightly update for git started at $(DATE)" # If nothing has changed, this will fail and that's exactly what should happen!
	mkdir -p ../.repo-tmp/
	cp -rv ./repo/* ../.repo-tmp/
	git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch -r \*.apk' --prune-empty -- --all
	git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch -r \*.jar' --prune-empty -- --all
	cp -rv ../.repo-tmp/* ./repo
	fdroid update --create-metadata
	git add .
	git commit -am "nightly update for git concluded at $(DATE)"
