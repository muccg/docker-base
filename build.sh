#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

# build dirs, top level is distro
for dir in */
do
    distro=${dir%*/}

    # subdirs are version
    for subdir in ${dir}*/
    do
        version=`basename ${subdir}`
        image="${REPO}/${distro}${version}-base"

        echo "################################################################### ${image}"
        
        # warm up cache for CI
        docker pull ${image}:latest || true

        # build
        docker build --pull=true -t ${image}:${DATE} ${subdir}
        docker build -t ${image}:latest ${subdir}

        # for logging in CI
        docker inspect ${image}:${DATE}

        # push
        docker push ${image}:${DATE}
        docker push ${image}:latest
    done
done
