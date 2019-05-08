Unofficial semi-nightly F-Droid Repo
====================================

This is an UNOFFICIAL repository for development builds of i2p and i2p-bote on
Android.

What this is
------------

Turns out, pretty much all package manager repositories do pretty much the same
thing, which is basically host a bunch of static files and an index to help the
package manager client find the packages it want. To the server, it's all
static, the server doesn't have to do anything other than provide the files. So
putting up a binary repository is actually an extremely easy process that gives
you a great deal of flexibility on where and how you host the content.
Especially for repositories which are mostly managed by a single organization
with a small number of apps, where they can be updated all at once, it's not
even *actually* necessary to run fdroidserver or anything like that to make your
repo available. All you really need to do is re-generate the repository metadata
and transfer it to a server that will host the resulting static site.

Github Procedure
----------------

So to just shove an F-Droid repo into a github page, what you do is create a
github repository, enable github pages, and clone the repo. *Once you have*
*cloned the repository,* [**Before Anything Else** *download this .gitignore*](https://github.com/eyedeekay/repo/raw/master/.gitignore)
*into your repository directory*.

        wget -O .gitignore https://github.com/eyedeekay/repo/raw/master/.gitignore

Change directory
into the newly closed repo and type

        fdroid init

Which will obviously initialize your F-Droid repo locally. Then you take the APK
files that you want to host, and copy them into the 'repo' directory that was
created by ```fdroid init```. Once you have all your apk files in the repo
directory, run the command

        fdroid update --create-metadata

to generate the repository metadata. Now add the generated files to your git
repository:

        git add .
        DATE=$(date) git commit -am "added packages on $DATE"

and push them up to the page.

        git push origin master

