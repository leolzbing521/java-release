#!/bin/bash -e
current_release_version () {
 bosh -e vbox releases|grep java|head -1|cut  -f2|cut -d "." -f3|cut -d "*" -f1
}
mkdir -p dev_releases
rm -rf ./dev_releases/*/*gz
newVersion=$((`current_release_version`+1))
echo $newVersion
v=v1.0.$newVersion

bosh create-release --version=$v --force --tarball=./dev_releases/java/java-${v}.tgz
bosh -e vbox upload-release ./dev_releases/java/java-${v}.tgz
