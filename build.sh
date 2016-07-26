#!/bin/sh
#
# Script to build images
#

: ${PROJECT_NAME:='base'}
. ./lib.sh

set -e

REPO="muccg"

docker_options

info "${DOCKER_BUILD_OPTS}"

# build dirs, top level is distro
for dir in */
do
    distro=${dir%*/}

    # subdirs are version
    for subdir in ${dir}*/
    do
        version=`basename ${subdir}`
        image="${DOCKER_IMAGE}:${distro}-${version}"

        echo "################################################################### ${image}"

        # warm up cache for CI
        docker pull ${image} || true

        docker build ${DOCKER_BUILD_OPTS} -t ${image} ${subdir}
        docker build ${DOCKER_BUILD_OPTS} -t ${image}-${DATE} ${subdir}

        # for logging in CI
        docker inspect ${image}

        # push to legacy repo
        if [ ${DOCKER_USE_HUB} = "1" ]; then
            _ci_docker_login
            docker push ${image}
            docker push ${image}-${DATE}
        fi
    done
done
