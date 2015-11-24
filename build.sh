#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

DOCKER_HOST=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
HTTP_PROXY="http://${DOCKER_HOST}:3128"
: ${DOCKER_BUILD_OPTIONS:="--pull=true --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg http_proxy=${HTTP_PROXY}"}

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
        docker build ${DOCKER_BUILD_OPTIONS} -t ${image}:${DATE} ${subdir}
        docker build ${DOCKER_BUILD_OPTIONS} -t ${image}:latest ${subdir}

        # for logging in CI
        docker inspect ${image}:${DATE}

        # push
        docker push ${image}:${DATE}
        docker push ${image}:latest
    done
done
